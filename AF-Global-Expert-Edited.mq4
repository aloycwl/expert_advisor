extern double Lots=0.01,LotExponent=1.44,PipStep=180,MaxLots=99,TakeProfit=50,TotalEquityRisk=20,TrailStart=13,TrailStop=3,slip=5;
extern int lotdecimal=2,MaxTrades_Hilo=20,MagicNumber_Hilo=10278,MaxTrades_15=20,g_magic_176_15=22324,MaxTrades_16=20,g_magic_176_16=23794;
extern bool MM=FALSE,UseEquityStop=FALSE,UseTrailingStop=FALSE;
bool gi_312,gi_360,gi_364,gi_368,gi_376,gi_524,gi_572,gi_576,gi_580,gi_588,gi_740,gi_788,gi_792,gi_796,gi_804,cg;
double g_price_216,g_price_264,gd_288,gd_296,gd_380,gd_388,g_price_444,g_price_476,gd_500,gd_508,gd_592,gd_600,g_price_660,g_price_692,gd_716,gd_724,gd_808,gd_816,order_stoploss_20,price_28;
int gi_324,g_pos,gi_348,gi_372,gi_536,gi_560,gi_584,g_datetime_608=1,gi_752,gi_776,gi_800,g_datetime_824=1;
int start(){
   int li_168,count_172,li_192,count_196;
   double ld_144,ld_152,ld_160,ld_176,ld_184,ld_1136,ld_1216,ld_1296,ld_1128;
   if (Lots>MaxLots) Lots=MaxLots;
   ld_144=(MM==TRUE)?((MathCeil(AccountBalance())<200000)?Lots:0.00001*MathCeil(AccountBalance())):Lots;
   if (UseTrailingStop&&TrailStop!=0) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) if (OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES)) {
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()||OrderMagicNumber()==MagicNumber_Hilo) {
         if (OrderType()==OP_BUY) {
            if (NormalizeDouble((Bid-g_price_264)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Bid-TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28>order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_264, price_28, OrderTakeProfit(), 0, Black);
         }
         if (OrderType()==OP_SELL) {
            if (NormalizeDouble((g_price_264-Ask)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Ask+TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28<order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_264, price_28, OrderTakeProfit(), 0, Black);
         }
      }
      Sleep(1000);
   }
   if (gi_324==Time[0]) return 0;
   gi_324=Time[0];
   for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) ld_1128 += OrderProfit();
   }
   if (CountTrades_Hilo()==0) gd_380=AccountEquity();
   gd_380=gd_380<gd_388?gd_388:AccountEquity();
   gd_388=AccountEquity();
   if (UseEquityStop&&(ld_1128<0&&MathAbs(ld_1128)>TotalEquityRisk/100*gd_380)) {
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()==Symbol()) {
            if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo) {
               if (OrderType()==OP_BUY) cg=OrderClose(OrderTicket(), OrderLots(), Bid, 0, Black);
               if (OrderType()==OP_SELL) cg=OrderClose(OrderTicket(), OrderLots(), Ask, 0, Black);
            }
            Sleep(1000);
         }
      }
      gi_376=FALSE;
   }
   gi_348=CountTrades_Hilo();
   if (gi_348==0) gi_312=FALSE;
   for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_BUY) { gi_364=TRUE; gi_368=FALSE; break; }
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_SELL) { gi_364=FALSE; gi_368=TRUE; break; }
   }
   if (gi_348>0&&gi_348<=MaxTrades_Hilo) {
      RefreshRates();
      gd_288=FindLastBuyPrice_Hilo();
      gd_296=FindLastSellPrice_Hilo();
      if ((gi_364&&gd_288-Ask>=PipStep*Point)||(gi_368&&Bid-gd_296>=PipStep*Point)) gi_360=TRUE;
   }
   else if(gi_348>MaxTrades_Hilo)
   {
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()==Symbol()) {
            if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo) {
               if (OrderType()==OP_BUY) cg=OrderClose(OrderTicket(), OrderLots(), Bid, 0, Black);
               if (OrderType()==OP_SELL) cg=OrderClose(OrderTicket(), OrderLots(), Ask, 0, Black);
            }
            Sleep(1000);
         }
      }
   }
   
   
   
   
   if (gi_348<1) { gi_368=FALSE; gi_364=FALSE; gi_360=TRUE; }
   if (gi_360) {
      gd_288=FindLastBuyPrice_Hilo();
      gd_296=FindLastSellPrice_Hilo();
      if (gi_368) {
         RefreshRates();
         gi_372=OpenPendingOrder_Hilo(1, NormalizeDouble(ld_144*MathPow(LotExponent, gi_348), lotdecimal));
         if (gi_372<0) { Print("Error: ", GetLastError()); return 0; }
         gd_296=FindLastSellPrice_Hilo(); gi_360=FALSE; gi_376=TRUE;
      } else if (gi_364) {
         gi_372=OpenPendingOrder_Hilo(0, NormalizeDouble(ld_144*MathPow(LotExponent, gi_348), lotdecimal));
         if (gi_372<0) { Print("Error: ", GetLastError()); return 0; }
         gd_288=FindLastBuyPrice_Hilo(); gi_360=FALSE; gi_376=TRUE;
      }
   }
   
   
   if ((gi_360&&gi_348<1)&&((!gi_368)&&!gi_364)) {
      if (iHigh(Symbol(), 0, 1)>iLow(Symbol(), 0, 2)) if (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1)>30) {
         gi_372=OpenPendingOrder_Hilo(1, NormalizeDouble(ld_144*MathPow(LotExponent, gi_348), lotdecimal));
         if (gi_372<0) { Print("Error: ", GetLastError()); return 0; }
         gd_288=FindLastBuyPrice_Hilo(); gi_376=TRUE;
      }else if (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1)<70) {
         gi_372=OpenPendingOrder_Hilo(0, NormalizeDouble(ld_144*MathPow(LotExponent, gi_348), lotdecimal));
         if (gi_372<0) { Print("Error: ", GetLastError()); return 0; }
         gd_296=FindLastSellPrice_Hilo(); gi_376=TRUE;
      }
      gi_360=FALSE;
   }
   gi_348=CountTrades_Hilo();
   g_price_264=0;
   for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) {
         g_price_264 += OrderOpenPrice()*OrderLots();
         ld_1136 += OrderLots();
      }
   }
   if (gi_348>0) g_price_264=NormalizeDouble(g_price_264/ld_1136, Digits);
   if (gi_376) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_BUY) { g_price_216=g_price_264+TakeProfit*Point; gi_312=TRUE; }
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_SELL) { g_price_216=g_price_264-TakeProfit*Point; gi_312=TRUE; }
   }
   if (gi_376&&gi_312) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo) while (!OrderModify(OrderTicket(), g_price_264, OrderStopLoss(), g_price_216, 0, Yellow)) {
         Sleep(1000);
         RefreshRates();
      }
      gi_376=FALSE;
   }
   /*
   
   ld_152=(MM==TRUE)?((MathCeil(AccountBalance())<200000)?Lots:0.00001*MathCeil(AccountBalance())):Lots;
   if (UseTrailingStop&&TrailStop!=0) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) if (OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES)) {
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if (OrderSymbol()==Symbol()||OrderMagicNumber()==g_magic_176_15) {
         if (OrderType()==OP_BUY) {
            if (NormalizeDouble((Bid-g_price_476)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Bid-TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28>order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_476, price_28, OrderTakeProfit(), 0, Black);
         }
         if (OrderType()==OP_SELL) {
            if (NormalizeDouble((g_price_476-Ask)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Ask+TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28<order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_476, price_28, OrderTakeProfit(), 0, Black);
         }
      }
      Sleep(1000);
   }
   if (gi_536!=Time[0]) {
      gi_536=Time[0];
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
         if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) ld_160 += OrderProfit();
      }
      if (CountTrades_15()==0) gd_592=AccountEquity();
      gd_592=gd_592<gd_600?gd_600:AccountEquity();
      gd_600=AccountEquity();
      if (UseEquityStop&&(ld_160<0&&MathAbs(ld_160)>TotalEquityRisk/100*gd_592)) { 
         for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
            cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol()==Symbol()) {
               if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15) {
                  if (OrderType()==OP_BUY) cg=OrderClose(OrderTicket(), OrderLots(), Bid, 0, Black);
                  if (OrderType()==OP_SELL) cg=OrderClose(OrderTicket(), OrderLots(), Ask, 0, Black);
               }
               Sleep(1000);
            }
         }
         Print("Closed All due to Stop Out");
         gi_588=FALSE;
      }
      gi_560=CountTrades_15();
      if (gi_560==0) gi_524=FALSE;
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_BUY) { gi_576=TRUE; gi_580=FALSE; break; }
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_SELL) { gi_576=FALSE; gi_580=TRUE; break; }
      }
      if (gi_560>0&&gi_560<=MaxTrades_15) {
         RefreshRates();
         gd_500=FindLastBuyPrice_15();
         gd_508=FindLastSellPrice_15();
         if ((gi_576&&gd_500-Ask>=PipStep*Point)||(gi_580&&Bid-gd_508>=PipStep*Point)) gi_572=TRUE;
      }
      if (gi_560<1) { gi_580=FALSE; gi_576=FALSE; gi_572=TRUE; }
      if (gi_572) {
         gd_500=FindLastBuyPrice_15();
         gd_508=FindLastSellPrice_15();
         if (gi_580) {
            RefreshRates();
            gi_584=OpenPendingOrder_15(1, NormalizeDouble(ld_152*MathPow(LotExponent, gi_560), lotdecimal));
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_508=FindLastSellPrice_15(); gi_572=FALSE; gi_588=TRUE;
         } else if (gi_576) {
            gi_584=OpenPendingOrder_15(0, NormalizeDouble(ld_152*MathPow(LotExponent, gi_560), lotdecimal));
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_500=FindLastBuyPrice_15(); gi_572=FALSE; gi_588=TRUE;
         }
      }
   }
   if (g_datetime_608!=iTime(NULL, PERIOD_H1, 0)) {
      li_168=OrdersTotal();
      count_172=0;
      for (int li_1212=li_168; li_1212>=1; li_1212--) {
         cg=OrderSelect(li_1212-1, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15) count_172++;
      }
      
      
      if (li_168==0||count_172<1) {
      if (gi_560<1){
         if (gi_364) {
            gi_584=OpenPendingOrder_15(1, ld_152);
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_500=FindLastBuyPrice_15(); gi_588=TRUE;
         } else if(gi_368) {
            gi_584=OpenPendingOrder_15(0, ld_152);
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_508=FindLastSellPrice_15(); gi_588=TRUE;
         }
         gi_572=FALSE;
         }
      }
  */
      /*
      if (li_168==0||count_172<1) {
         if (iClose(Symbol(), 0, 2)>iClose(Symbol(), 0, 1)) {
            gi_584=OpenPendingOrder_15(1, ld_152);
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_500=FindLastBuyPrice_15(); gi_588=TRUE;
         } else {
            gi_584=OpenPendingOrder_15(0, ld_152);
            if (gi_584<0) { Print("Error: ", GetLastError()); return 0; }
            gd_508=FindLastSellPrice_15(); gi_588=TRUE;
         }
         gi_572=FALSE;
      }
      
      */
       /*
      g_datetime_608=iTime(NULL, PERIOD_H1, 0);
   }
   gi_560=CountTrades_15();
   g_price_476=0;
   for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) {
         g_price_476 += OrderOpenPrice()*OrderLots();
         ld_1216 += OrderLots();
      }
   }
   if (gi_560>0) g_price_476=NormalizeDouble(g_price_476/ld_1216, Digits);
   if (gi_588) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_BUY) { g_price_444=g_price_476+TakeProfit*Point; gi_524=TRUE; }
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_SELL) { g_price_444=g_price_476-TakeProfit*Point; gi_524=TRUE; }
   }
   if (gi_588&&gi_524) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15) 
         while (!OrderModify(OrderTicket(), g_price_476, OrderStopLoss(), g_price_444, 0, Yellow)) {
            Sleep(1000);
            RefreshRates();
         }
   gi_588=FALSE;
   }
   
   
  
   
   
   
   ld_176=(MM==TRUE)?((MathCeil(AccountBalance())<200000)?Lots:0.00001*MathCeil(AccountBalance())):Lots;
   if (UseTrailingStop&&TrailStop!=0) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) if (OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES)) {
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if (OrderSymbol()==Symbol()||OrderMagicNumber()==g_magic_176_16) {
         if (OrderType()==OP_BUY) {
            if (NormalizeDouble((Bid-g_price_692)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Bid-TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28>order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_692, price_28, OrderTakeProfit(), 0, Black);
         }
         if (OrderType()==OP_SELL) {
            if (NormalizeDouble((g_price_692-Ask)/Point, 0)<TrailStart) continue;
            order_stoploss_20=OrderStopLoss();
            price_28=Ask+TrailStop*Point;
            if (order_stoploss_20==0||(order_stoploss_20!=0&&price_28<order_stoploss_20)) cg=OrderModify(OrderTicket(), g_price_692, price_28, OrderTakeProfit(), 0, Black);
         }
      }
      Sleep(1000);
   }
   if (gi_752!=Time[0]) {
      gi_752=Time[0];
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
         if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) ld_184 += OrderProfit();
      }
      if (CountTrades_16()==0) gd_808=AccountEquity();
      gd_808=gd_808<gd_816?gd_816:AccountEquity();
      gd_816=AccountEquity();
      if (UseEquityStop&&(ld_184<0&&MathAbs(ld_184)>TotalEquityRisk/100*gd_808)) {
         for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
            cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol()==Symbol()) {
               if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16) {
                  if (OrderType()==OP_BUY) cg=OrderClose(OrderTicket(), OrderLots(), Bid, 0, Black);
                  if (OrderType()==OP_SELL) cg=OrderClose(OrderTicket(), OrderLots(), Ask, 0, Black);
               }
               Sleep(1000);
            }
         }
         Print("Closed All due to Stop Out");
         gi_804=FALSE;
      }
      gi_776=CountTrades_16();
      if (gi_776==0) gi_740=FALSE;
      for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
         cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_BUY) { gi_792=TRUE; gi_796=FALSE; break; }
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_SELL) { gi_792=FALSE; gi_796=TRUE; break; }
      }
      if (gi_776>0&&gi_776<=MaxTrades_16) {
         RefreshRates();
         gd_716=FindLastBuyPrice_16();
         gd_724=FindLastSellPrice_16();
         if ((gi_792&&gd_716-Ask>=PipStep*Point)||(gi_796&&Bid-gd_724>=PipStep*Point)) gi_788=TRUE;
      }
      if (gi_776<1) { gi_796=FALSE; gi_792=FALSE; }
      if (gi_788) {
         gd_716=FindLastBuyPrice_16();
         gd_724=FindLastSellPrice_16();
         if (gi_796) {
            RefreshRates();
            gi_800=OpenPendingOrder_16(1, NormalizeDouble(ld_176*MathPow(LotExponent, gi_776), lotdecimal));
            if (gi_800<0) { Print("Error: ", GetLastError()); return 0; }
            gd_724=FindLastSellPrice_16(); gi_788=FALSE; gi_804=TRUE;
         } else if (gi_792) {
            gi_800=OpenPendingOrder_16(0, NormalizeDouble(ld_176*MathPow(LotExponent, gi_776), lotdecimal));
            if (gi_800<0) { Print("Error: ", GetLastError()); return 0; }
            gd_716=FindLastBuyPrice_16(); gi_788=FALSE; gi_804=TRUE;
         }
      }
   }
   if (g_datetime_824!=iTime(NULL, PERIOD_M1, 0)) {
      li_192=OrdersTotal();
      count_196=0;
      for (int li_1292=li_192; li_1292>=1; li_1292--) {
         cg=OrderSelect(li_1292-1, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
         if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16) count_196++;
      }
      if (li_192==0||count_196<1) {
         if (iClose(Symbol(), 0, 2)>iClose(Symbol(), 0, 1)) {
            if (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1)>30) {
               gi_800=OpenPendingOrder_16(1, ld_176);
               if (gi_800<0) { Print("Error: ", GetLastError()); return 0; }
               gd_716=FindLastBuyPrice_16(); gi_804=TRUE;
            }
         } else if (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1)<70) {
            gi_800=OpenPendingOrder_16(0, ld_176);
            if (gi_800<0) { Print("Error: ", GetLastError()); return 0; }
            gd_724=FindLastSellPrice_16(); gi_804=TRUE;
         }
         gi_788=FALSE;
      }
      g_datetime_824=iTime(NULL, PERIOD_M1, 0);
   }
   gi_776=CountTrades_16();
   g_price_692=0;
   for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16)&&(OrderType()==OP_BUY||OrderType()==OP_SELL)) {
         g_price_692 += OrderOpenPrice()*OrderLots();
         ld_1296 += OrderLots();
      }
   }
   if (gi_776>0) g_price_692=NormalizeDouble(g_price_692/ld_1296, Digits);
   if (gi_804) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_BUY) { g_price_660=g_price_692+TakeProfit*Point; gi_740=TRUE; }
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_SELL) { g_price_660=g_price_692-TakeProfit*Point; gi_740=TRUE; }
   }
   if (gi_804&&gi_740) for (g_pos=OrdersTotal()-1; g_pos>=0; g_pos--) {
      cg=OrderSelect(g_pos, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16) while (!OrderModify(OrderTicket(), g_price_692, OrderStopLoss(), g_price_660, 0, Yellow)) {
         Sleep(1000);
         RefreshRates();
      }
      gi_804=FALSE;
   }
   return 0;
   
   */
}



int CountTrades_Hilo() {
   int count_0;
   for (int pos_4=OrdersTotal()-1; pos_4>=0; pos_4--) {
      cg=OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo)&&(OrderType()==OP_SELL||OrderType()==OP_BUY)) count_0++;
   }
   return (count_0);
}
int OpenPendingOrder_Hilo(int ai_0, double a_lots_4) {
   int ticket_60,error_64,count_68,li_72=100;
   if (ai_0==0) for (count_68=0; count_68<li_72; count_68++) {
      RefreshRates();
      ticket_60=OrderSend(Symbol(), OP_BUY, a_lots_4, Ask, slip, 0, 0, gi_348, MagicNumber_Hilo, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   } else for (count_68=0; count_68<li_72; count_68++) {
      ticket_60=OrderSend(Symbol(), OP_SELL, a_lots_4, Bid, slip, 0, 0, gi_348, MagicNumber_Hilo, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   }
   return (ticket_60);
}
double FindLastBuyPrice_Hilo() {
   double order_open_price_0;
   int ticket_8, ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_BUY) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
double FindLastSellPrice_Hilo() {
   double order_open_price_0;
   int ticket_8, ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=MagicNumber_Hilo) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==MagicNumber_Hilo&&OrderType()==OP_SELL) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}

/*

int CountTrades_15() {
   int count_0;
   for (int pos_4=OrdersTotal()-1; pos_4>=0; pos_4--) {
      cg=OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15)&&(OrderType()==OP_SELL||OrderType()==OP_BUY)) count_0++;
   }
   return (count_0);
}
int OpenPendingOrder_15(int ai_0, double a_lots_4) {
   int ticket_60,error_64,count_68,li_72=100;
   if (ai_0==0) for (count_68=0; count_68<li_72; count_68++) {
      RefreshRates();
      ticket_60=OrderSend(Symbol(), OP_BUY, a_lots_4, Ask, slip, 0, 0, gi_560, g_magic_176_15, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   } else for (count_68=0; count_68<li_72; count_68++) {
      ticket_60=OrderSend(Symbol(), OP_SELL, a_lots_4, Bid, slip, 0, 0, gi_560, g_magic_176_15, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   }
   return (ticket_60);
}
double FindLastBuyPrice_15() {
   double order_open_price_0;
   int ticket_8,ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_BUY) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
double FindLastSellPrice_15() {
   double order_open_price_0;
   int ticket_8, ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_15) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_15&&OrderType()==OP_SELL) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}




int CountTrades_16() {
   int count_0;
   for (int pos_4=OrdersTotal()-1; pos_4>=0; pos_4--) {
      cg=OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if ((OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16)&&(OrderType()==OP_SELL||OrderType()==OP_BUY)) count_0++;
   }
   return (count_0);
}
int OpenPendingOrder_16(int ai_0, double a_lots_4) {
   int ticket_60,error_64,count_68,li_72=100;
   if (ai_0==0) for (count_68=0; count_68<li_72; count_68++) {
      RefreshRates();
      ticket_60=OrderSend(Symbol(), OP_BUY, a_lots_4, Ask, slip, 0, 0, gi_776, g_magic_176_16, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   }else for (count_68=0; count_68<li_72; count_68++) {
      ticket_60=OrderSend(Symbol(), OP_SELL, a_lots_4, Bid, slip, 0, 0, gi_776, g_magic_176_16, 0, Black);
      error_64=GetLastError();
      if (error_64==0||(!((error_64==4||error_64==137||error_64==146||error_64==136)))) break;
      Sleep(5000);
   }
   return (ticket_60);
}
double FindLastBuyPrice_16() {
   double order_open_price_0;
   int ticket_8, ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_BUY) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
double FindLastSellPrice_16() {
   double order_open_price_0;
   int ticket_8, ticket_20;
   for (int pos_24=OrdersTotal()-1; pos_24>=0; pos_24--) {
      cg=OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol()!=Symbol()||OrderMagicNumber()!=g_magic_176_16) continue;
      if (OrderSymbol()==Symbol()&&OrderMagicNumber()==g_magic_176_16&&OrderType()==OP_SELL) {
         ticket_8=OrderTicket();
         if (ticket_8>ticket_20) {
            order_open_price_0=OrderOpenPrice();
            ticket_20=ticket_8;
         }
      }
   }
   return (order_open_price_0);
}

*/