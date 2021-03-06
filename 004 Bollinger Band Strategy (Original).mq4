#include <stdlib.mqh>
#include <stderror.mqh>

int LotDigits; //initialized in OnInit
int MagicNumber = 475403;
extern double TradeSize = 0.1;
int MaxSlippage = 3; //adjusted in OnInit
bool crossed[4]; //initialized to true, used in function Cross
extern int MaxOpenTrades = 10;
int MaxLongTrades = 1000;
int MaxShortTrades = 1000;
int MaxPendingOrders = 1000;
int MaxLongPendingOrders = 1000;
int MaxShortPendingOrders = 1000;
bool Hedging = true;
int OrderRetry = 5; //# of retries if sending order returns error
int OrderWait = 5; //# of seconds to wait if sending order returns error
double myPoint; //initialized in OnInit

bool Cross(int i, bool condition) //returns true if "condition" is true and was false in the previous call
  {
   bool ret = condition && !crossed[i];
   crossed[i] = condition;
   return(ret);
  }

int TradesCount(int type) //returns # of open trades for order type, current symbol and magic number
  {
   int result = 0;
   int total = OrdersTotal();
   for(int i = 0; i < total; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false) continue;
      if(OrderMagicNumber() != MagicNumber || OrderSymbol() != Symbol() || OrderType() != type) continue;
      result++;
     }
   return(result);
  }

int myOrderSend(int type, double price, double volume, string ordername) //send order, return ticket ("price" is irrelevant for market orders)
  {
   if(!IsTradeAllowed()) return(-1);
   int ticket = -1;
   int retries = 0;
   int err = 0;
   int long_trades = TradesCount(OP_BUY);
   int short_trades = TradesCount(OP_SELL);
   int long_pending = TradesCount(OP_BUYLIMIT) + TradesCount(OP_BUYSTOP);
   int short_pending = TradesCount(OP_SELLLIMIT) + TradesCount(OP_SELLSTOP);
   string ordername_ = ordername;
   if(ordername != "")
      ordername_ = "("+ordername+")";
   //test Hedging
   if(!Hedging && ((type % 2 == 0 && short_trades + short_pending > 0) || (type % 2 == 1 && long_trades + long_pending > 0))) return(-1);
   //test maximum trades
   if((type % 2 == 0 && long_trades >= MaxLongTrades)
   || (type % 2 == 1 && short_trades >= MaxShortTrades)
   || (long_trades + short_trades >= MaxOpenTrades)
   || (type > 1 && type % 2 == 0 && long_pending >= MaxLongPendingOrders)
   || (type > 1 && type % 2 == 1 && short_pending >= MaxShortPendingOrders)
   || (type > 1 && long_pending + short_pending >= MaxPendingOrders)
   ) return(-1);
   //prepare to send order
   while(IsTradeContextBusy()) Sleep(100);
   RefreshRates();
   if(type == OP_BUY) price = Ask;
   else if(type == OP_SELL) price = Bid;
   else if(price < 0) return(-1);
   int clr = (type % 2 == 1) ? clrRed : clrBlue;
   while(ticket < 0 && retries < OrderRetry+1)
     {
      ticket = OrderSend(Symbol(), type, NormalizeDouble(volume, LotDigits), NormalizeDouble(price, Digits()), MaxSlippage, 0, 0, ordername, MagicNumber, 0, clr);
      if(ticket < 0) Sleep(OrderWait*1000);
      retries++;
     }
   if(ticket < 0) return(-1);
   return(ticket);
  }

void myOrderClose(int type, double volumepercent, string ordername) //close open orders for current symbol, magic number and "type" (OP_BUY or OP_SELL)
  {
   if(!IsTradeAllowed() || type > 1) return;
   bool success = false;
   int err = 0;
   string ordername_ = ordername;
   if(ordername != "")
      ordername_ = "("+ordername+")";
   int total = OrdersTotal();
   int orderList[][2];
   int orderCount = 0;
   int i;
   for(i = 0; i < total; i++)
     {
      while(IsTradeContextBusy()) Sleep(100);
      if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
      if(OrderMagicNumber() != MagicNumber || OrderSymbol() != Symbol() || OrderType() != type) continue;
      orderCount++;
      ArrayResize(orderList, orderCount);
      orderList[orderCount - 1][0] = OrderOpenTime();
      orderList[orderCount - 1][1] = OrderTicket();
     }
   if(orderCount > 0)
      ArraySort(orderList, WHOLE_ARRAY, 0, MODE_ASCEND);
   for(i = 0; i < orderCount; i++)
     {
      if(!OrderSelect(orderList[i][1], SELECT_BY_TICKET, MODE_TRADES)) continue;
      while(IsTradeContextBusy()) Sleep(100);
      RefreshRates();
      double price = (type == OP_SELL) ? Ask : Bid;
      double volume = NormalizeDouble(OrderLots()*volumepercent * 1.0 / 100, LotDigits);
      if (NormalizeDouble(volume, LotDigits) == 0) continue;
      success = OrderClose(OrderTicket(), volume, NormalizeDouble(price, Digits()), MaxSlippage, clrWhite);
     }
  }

int OnInit(){   
   myPoint = Point();
   if(Digits() == 5 || Digits() == 3)
     {
      myPoint *= 10;
      MaxSlippage *= 10;
     }
   double LotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   if(LotStep >= 1) LotDigits = 0;
   else if(LotStep >= 0.1) LotDigits = 1;
   else if(LotStep >= 0.01) LotDigits = 2;
   else LotDigits = 3;
   int i;
   for (i = 0; i < ArraySize(crossed); i++)
      crossed[i] = true;
   return(INIT_SUCCEEDED);
  }


void OnTick()
  {
   int ticket = -1;
   double price;   
   
   
   //Close Long Positions, instant signal is tested first
   RefreshRates();
   if(Cross(1, Bid > iBands(NULL, PERIOD_CURRENT, 120, 2, 0, PRICE_CLOSE, MODE_UPPER, 0)) //Price crosses above Bollinger Bands
   )
     {   
      if(IsTradeAllowed()) myOrderClose(OP_BUY, 100, "");
     }
   
   //Close Short Positions, instant signal is tested first
   RefreshRates();
   if(Cross(0, Bid < iBands(NULL, PERIOD_CURRENT, 120, 2, 0, PRICE_CLOSE, MODE_LOWER, 0)) //Price crosses below Bollinger Bands
   )
     {   
      if(IsTradeAllowed()) myOrderClose(OP_SELL, 100, "");
     }
   
   //Open Buy Order, instant signal is tested first
   RefreshRates();
   if(Cross(2, Bid < iBands(NULL, PERIOD_CURRENT, 120, 2, 0, PRICE_CLOSE, MODE_LOWER, 0)) //Price crosses below Bollinger Bands
   )
     {
      RefreshRates();
      price = Ask;   
      if(IsTradeAllowed())
        {
         ticket = myOrderSend(OP_BUY, price, TradeSize, "");
         if(ticket <= 0) return;
        }
     }
   
   //Open Sell Order, instant signal is tested first
   RefreshRates();
   if(Cross(3, Bid > iBands(NULL, PERIOD_CURRENT, 120, 2, 0, PRICE_CLOSE, MODE_UPPER, 0)) //Price crosses above Bollinger Bands
   )
     {
      RefreshRates();
      price = Bid;   
      if(IsTradeAllowed())
        {
         ticket = myOrderSend(OP_SELL, price, TradeSize, "");
         if(ticket <= 0) return;
        }
     }
  }