//------------------------------------------------------------------
#property copyright "www.forex-tsd.com "
#property link      "www.forex-tsd.com/"
//------------------------------------------------------------------
#include <stdlib.mqh>

//
//
//
//
//

extern bool   TrailAllSymbols   = true;
extern bool   TrailOnlyInProfit = false;
extern double CloseWhenProfit   = 0.0;
extern bool   showMessages      = true;

//
//
//
//
//

extern int  TimeFrame         =   0;
extern int  HighLowBar        =   1;
extern int  InitialStop       = 100;
extern int  magicNumber.from  =   0;
extern int  magicNumber.to    =   0;


//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

int init()   { return(0); }
int deinit()
{
   return(0);
}



//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//
      
int start()
{
   datetime startTime   = TimeCurrent();
   double   totalProfit = 0;
   int      err,c;
   
   //
   //
   //
   //
   //

   for (int i=OrdersTotal()-1; i>=0; i--)
   { 
      OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
      if (!TrailAllSymbols)
         if (OrderSymbol()!=Symbol())               continue;
         if (OrderMagicNumber() < magicNumber.from) continue;
         if (OrderMagicNumber() > magicNumber.to)   continue;
      RefreshRates();

      //
      //
      //
      //
      //
         
         int    digits     = MarketInfo(OrderSymbol(),MODE_DIGITS);
         double point      = MarketInfo(OrderSymbol(),MODE_POINT);
         double PointRatio = 1;
               if (digits==3 || digits==5) PointRatio = 10;
      
      //
      //
      //
      //
      //

      if (OrderType()==OP_BUY) 
      {
         totalProfit += OrderProfit();
         double bid        = MarketInfo(OrderSymbol(),MODE_BID);
         double maxBuyStop = NormalizeDouble(bid-MarketInfo(OrderSymbol(),MODE_STOPLEVEL)*point,digits);
            if (OrderStopLoss()==0 && InitialStop > 0)
               {
                  double buyStop        = bid-InitialStop*point*PointRatio;
                  double currentBuyStop = buyStop-point;
               }
            else
               {             
                  buyStop        = stopValue(OrderSymbol(),1);
                  currentBuyStop = OrderStopLoss(); if(currentBuyStop == 0) currentBuyStop = OrderOpenPrice();
                  currentBuyStop = MathMax(currentBuyStop,OrderOpenPrice());
               }                                          
         buyStop        = NormalizeDouble(buyStop       ,digits);
         currentBuyStop = NormalizeDouble(currentBuyStop,digits);
         
         //
         //
         //
         //
         //

         bool doModifyBuy = (buyStop > NormalizeDouble(OrderStopLoss(),digits)); if (TrailOnlyInProfit) doModifyBuy = (buyStop > currentBuyStop);
         if ( doModifyBuy && (buyStop < maxBuyStop))
         for(c=0 ; c<3; c++)
         {
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(buyStop,Digits),OrderTakeProfit(),0,CLR_NONE);
               err=GetLastError();
               if(err==4 || err==136 || err==137 || err==138 || err==146)
               {
                  RefreshRates();
                  continue;
               }
            break; 
         }                     
      }   

      //
      //
      //
      //
      //
      
      if (OrderType()==OP_SELL)
      {
         totalProfit += OrderProfit();
         double ask         = MarketInfo(OrderSymbol(),MODE_ASK);
         double minSellStop = NormalizeDouble(ask+MarketInfo(OrderSymbol(),MODE_STOPLEVEL)*point,digits);
            if (OrderStopLoss()==0 && InitialStop > 0)
               {
                  double sellStop        = ask+InitialStop*point*PointRatio;
                  double currentSellStop = sellStop+point;
               }
            else
               {             
                  sellStop        = stopValue(OrderSymbol(),2);
                  currentSellStop = OrderStopLoss(); if(currentSellStop == 0) currentSellStop = OrderOpenPrice();
                  currentSellStop = MathMin(currentSellStop,OrderOpenPrice());
               }                                          
         sellStop        = NormalizeDouble(sellStop       ,digits);
         currentSellStop = NormalizeDouble(currentSellStop,digits);
         
         //
         //
         //
         //
         //
            
         bool doModifySell = (sellStop < NormalizeDouble(OrderStopLoss(),digits) || OrderStopLoss()==0); if (TrailOnlyInProfit) doModifySell = (sellStop < currentSellStop);
         if ( doModifySell && (sellStop > minSellStop))
         for(c=0 ; c<3; c++)
         {
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(sellStop,digits),OrderTakeProfit(),0,CLR_NONE);
               err=GetLastError();
               if(err==4 || err==136 || err==137 || err==138 || err==146)
               {
                  RefreshRates();
                  continue;
               }
            break; 
         }                     
      }
   }
   
   //
   //
   //
   //
   //
   
   if (CloseWhenProfit>0)
   {
      if ((TimeCurrent()-startTime)>15) totalProfit = colectProfit();
      
      //
      //
      //
      //
      //
      
      if (CloseWhenProfit<totalProfit)
      for (i=OrdersTotal()-1; i>=0; i--)
      { 
         OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         if (!TrailAllSymbols)
            if (OrderSymbol()!=Symbol())               continue;
            if (OrderMagicNumber() < magicNumber.from) continue;
            if (OrderMagicNumber() > magicNumber.to)   continue;
      
            //
            //
            //
            //
            //
            
            if (OrderType()==OP_BUY || OrderType()==OP_SELL)
            for(c=0 ; c<3; c++)
            {
               OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,CLR_NONE);
                  err=GetLastError();
                  if(err==4 || err==136 || err==137 || err==138 || err==146)
                  {
                     RefreshRates();
                     continue;
                  }
                  break; 
            }                     
      }
   }
   return(0);      
}




//------------------------------------------------------------------
//
//------------------------------------------------------------------
//
//
//
//
//

double colectProfit()
{
   double profitSoFar=0;
   
   //
   //
   //
   //
   //
   
   for (int i=OrdersTotal()-1; i>=0; i--)
   { 
      OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
      if (!TrailAllSymbols)
         if (OrderSymbol()!=Symbol())               continue;
         if (OrderMagicNumber() < magicNumber.from) continue;
         if (OrderMagicNumber() > magicNumber.to)   continue;
         if (OrderType()==OP_BUY || OrderType()==OP_SELL)
               profitSoFar += OrderProfit();
   }         
   return(profitSoFar);
}

//
//
//
//
//

double stopValue(string symbol, int forWhat)
{
   if (forWhat==1)
         return(iLow(symbol,TimeFrame,HighLowBar));
   else  return(iHigh(symbol,TimeFrame,HighLowBar));
}