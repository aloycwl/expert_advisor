#property copyright "Snake_Ea_"
#property link      "Snake_Ea_@gmail.com"

bool gi_76 = FALSE;
double gd_80 = 100.0;
bool gi_88 = TRUE;
bool gi_92 = TRUE;
extern string A1 = "جàمè÷هٌêîه ÷èٌëî";
extern int magic = 1;
extern string A2 = "رٍàًٍîâûé ëîٍ";
extern double start_lot = 0.1;
extern string A3 = "طàم";
extern double range = 1.0;
extern string A4 = "تîë-âî îًنهًîâ";
extern int level = 999999999;
bool gi_152 = TRUE;
double gd_156 = 1.0;
double gd_164 = 0.1;
bool gi_172 = FALSE;
double gd_176 = 60.0;
double gd_184 = 30.0;
extern string A5 = "زد â نهيüمàُ";
extern double tp_in_money = 10.0;
bool gi_208 = TRUE;


string gs_unused_224 = "----- Additional -----";
bool gi_232 = FALSE;
int gi_236 = 4;
double gd_240 = 0.5;
double gd_248 = 1.0;
double gd_256 = 1.0;
int gi_264 = 3;
double gd_268;
double g_minlot_276;
double g_stoplevel_284;
int gi_292 = 0;
int g_count_296 = 0;
int g_ticket_300 = 0;
double g_lots_304;
double gd_320;
double gd_328;
double gd_336;
double gd_344;
double gd_352;
double gd_360;
bool gi_368;
int gi_unused_372 = 0;
string gs_null_376 = "NULL";
int gi_unused_384;
int gi_388;
bool gi_unused_392 = FALSE;

int init() {
   gi_unused_384 = Bars;
   if (gi_88) gi_388 = 0;
   else gi_388 = 1;
   if (Digits == 3 || Digits == 5) gd_268 = 10.0 * Point;
   else gd_268 = Point;
   g_minlot_276 = MarketInfo(Symbol(), MODE_MINLOT);
   g_stoplevel_284 = MarketInfo(Symbol(), MODE_STOPLEVEL);
   if (start_lot < g_minlot_276) Print("lotsize is to small.");
   if (gd_176 < g_stoplevel_284) Print("stoploss is to tight.");
   if (gd_184 < g_stoplevel_284) Print("takeprofit is to tight.");
   if (g_minlot_276 == 0.01) gi_292 = 2;
   if (g_minlot_276 == 0.1) gi_292 = 1;
   g_lots_304 = start_lot;
   if (gi_232 == FALSE) gi_236 = 0;
   gd_320 = gd_240;
   gd_328 = gd_248 * range * gd_268;
   gd_336 = gd_156;
   gd_344 = gd_256;
   gd_352 = gi_264;
   gd_360 = AccountEquity();
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   int count_0;
   int count_4;
   int count_8;
   int li_12;
   int li_16;
   int datetime_20;
   int datetime_24;
   bool li_28;
   bool li_32;
   string ls_36;
   int cmd_52;
   double order_open_price_56;
   double order_lots_64;
   double ld_72;
   double ld_80;
   double ld_88;
   double ld_96;
   double ld_104;
   double ld_112;
   double ld_120;
   double order_stoploss_128;
   double order_takeprofit_136;
   double ld_144;
   if (f0_0() != 0) {
      if (gi_76 && f0_1() >= gd_80) {
         Comment("\ndaily target achieved.");
         return (0);
      }
      if (!gi_92 && DayOfWeek() == 5 && f0_4() == 0) {
         Comment("\nstop trading in Friday.");
         return (0);
      }
      count_0 = 0;
      count_4 = 0;
      count_8 = 0;
      li_16 = 0;
      li_28 = FALSE;
      li_32 = FALSE;
      ls_36 = "0";
      for (int pos_44 = 0; pos_44 <= OrdersTotal(); pos_44++) {
         OrderSelect(pos_44, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderType() < OP_BUYLIMIT) {
            count_0++;
            datetime_20 = OrderOpenTime();
            if (OrderType() == OP_BUY) count_4++;
            if (OrderType() == OP_SELL) count_8++;
            if (count_0 == 1 || datetime_20 < datetime_24) {
               datetime_24 = datetime_20;
               ls_36 = "B";
               if (OrderType() == OP_SELL) ls_36 = "S";
            }
         }
      }
      if (ls_36 == "B") {
         li_16 = count_4;
         li_12 = count_8;
         gs_null_376 = "BUY";
         if (gi_232 == TRUE && count_4 >= gi_236 - 1) li_28 = TRUE;
      }
      if (ls_36 == "S") {
         li_16 = count_8;
         li_12 = count_4;
         gs_null_376 = "SELL";
         if (gi_232 == TRUE && count_8 >= gi_236 - 1) li_32 = TRUE;
      }
      gd_156 = gd_336;
      if (gd_344 > 0.0 && li_16 >= gd_352 - 1.0) gd_156 = gd_344;
      if (count_0 == 0) gi_368 = FALSE;
      if (li_16 == 0 && g_count_296 == 0 && li_12 == 0) {
         if (f0_2() == -2 && gi_368 == FALSE) {
            if (gi_208) {
               if (gi_172) {
                  g_lots_304 = start_lot;
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, Ask - gd_176 * gd_268, Ask + gd_184 * gd_268, "", magic, 0, Blue);
               } else {
                  g_lots_304 = start_lot;
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, 0, 0, "", magic, 0, Blue);
               }
            } else {
               if (gi_172) {
                  g_lots_304 = start_lot;
                  if (OrderSend(Symbol(), OP_BUY, start_lot, Ask, 3, Ask - gd_176 * gd_268, Ask + gd_184 * gd_268, "", magic, 0, Blue) > 0) {
                     for (int li_48 = 1; li_48 < level; li_48++) {
                        if (gi_152) {
                           g_lots_304 = NormalizeDouble(start_lot * MathPow(gd_156, li_48), gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_BUYLIMIT, g_lots_304, Ask - range * li_48 * gd_268, 3, Ask - range * li_48 * gd_268 - gd_176 * gd_268, Ask - range * li_48 * gd_268 +
                              gd_184 * gd_268, "", magic, 0, Blue);
                        } else {
                           g_lots_304 = NormalizeDouble(start_lot + gd_164 * li_48, gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_BUYLIMIT, g_lots_304, Ask - range * li_48 * gd_268, 3, Ask - range * li_48 * gd_268 - gd_176 * gd_268, Ask - range * li_48 * gd_268 +
                              gd_184 * gd_268, "", magic, 0, Blue);
                        }
                     }
                  }
               } else {
                  g_lots_304 = start_lot;
                  if (OrderSend(Symbol(), OP_BUY, start_lot, Ask, 3, 0, 0, "", magic, 0, Blue) > 0) {
                     for (li_48 = 1; li_48 < level; li_48++) {
                        if (gi_152) {
                           g_lots_304 = NormalizeDouble(start_lot * MathPow(gd_156, li_48), gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_BUYLIMIT, g_lots_304, Ask - range * li_48 * gd_268, 3, 0, 0, "", magic, 0, Blue);
                        } else {
                           g_lots_304 = NormalizeDouble(start_lot + gd_164 * li_48, gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_BUYLIMIT, g_lots_304, Ask - range * li_48 * gd_268, 3, 0, 0, "", magic, 0, Blue);
                        }
                     }
                  }
               }
            }
            if (li_28 == TRUE) g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304 * gd_320, Bid, 3, 0, Bid - gd_328, "h", magic, 0, Red);
         }
         if (f0_2() == 2 && gi_368 == FALSE) {
            if (gi_208) {
               if (gi_172) {
                  g_lots_304 = start_lot;
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, Bid + gd_176 * gd_268, Bid - gd_184 * gd_268, "", magic, 0, Red);
               } else {
                  g_lots_304 = start_lot;
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, 0, 0, "", magic, 0, Red);
               }
            } else {
               if (gi_172) {
                  g_lots_304 = start_lot;
                  if (OrderSend(Symbol(), OP_SELL, start_lot, Bid, 3, Bid + gd_176 * gd_268, Bid - gd_184 * gd_268, "", magic, 0, Red) > 0) {
                     for (li_48 = 1; li_48 < level; li_48++) {
                        if (gi_152) {
                           g_lots_304 = NormalizeDouble(start_lot * MathPow(gd_156, li_48), gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_SELLLIMIT, g_lots_304, Bid + range * li_48 * gd_268, 3, Bid + range * li_48 * gd_268 + gd_176 * gd_268, Bid + range * li_48 * gd_268 - gd_184 * gd_268,
                              "", magic, 0, Red);
                        } else {
                           g_lots_304 = NormalizeDouble(start_lot + gd_164 * li_48, gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_SELLLIMIT, g_lots_304, Bid + range * li_48 * gd_268, 3, Bid + range * li_48 * gd_268 + gd_176 * gd_268, Bid + range * li_48 * gd_268 - gd_184 * gd_268,
                              "", magic, 0, Red);
                        }
                     }
                  }
               } else {
                  g_lots_304 = start_lot;
                  if (OrderSend(Symbol(), OP_SELL, start_lot, Bid, 3, 0, 0, "", magic, 0, Red) > 0) {
                     for (li_48 = 1; li_48 < level; li_48++) {
                        if (gi_152) {
                           g_lots_304 = NormalizeDouble(start_lot * MathPow(gd_156, li_48), gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_SELLLIMIT, g_lots_304, Bid + range * li_48 * gd_268, 3, 0, 0, "", magic, 0, Red);
                        } else {
                           g_lots_304 = NormalizeDouble(start_lot + gd_164 * li_48, gi_292);
                           g_ticket_300 = OrderSend(Symbol(), OP_SELLLIMIT, g_lots_304, Bid + range * li_48 * gd_268, 3, 0, 0, "", magic, 0, Red);
                        }
                     }
                  }
               }
            }
            if (li_32 == TRUE) g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304 * gd_320, Ask, 3, 0, Ask + gd_328, "h", magic, 0, Blue);
         }
      }
      if (gi_208 && li_16 > 0 && li_16 < level && li_12 == 0) {
         for (li_48 = 0; li_48 < OrdersTotal(); li_48++) {
            OrderSelect(li_48, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic) continue;
            cmd_52 = OrderType();
            order_open_price_56 = OrderOpenPrice();
            order_lots_64 = OrderLots();
         }
         if (cmd_52 == OP_BUY && Ask <= order_open_price_56 - range * gd_268 && gi_368 == FALSE) {
            if (gi_172) {
               if (gi_152) {
                  g_lots_304 = NormalizeDouble(order_lots_64 * gd_156, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, Ask - gd_176 * gd_268, Ask + gd_184 * gd_268, "", magic, 0, Blue);
               } else {
                  g_lots_304 = NormalizeDouble(order_lots_64 + gd_164, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, Ask - gd_176 * gd_268, Ask + gd_184 * gd_268, "", magic, 0, Blue);
               }
            } else {
               if (gi_152) {
                  g_lots_304 = NormalizeDouble(order_lots_64 * gd_156, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, 0, 0, "", magic, 0, Blue);
               } else {
                  g_lots_304 = NormalizeDouble(order_lots_64 + gd_164, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304, Ask, 3, 0, 0, "", magic, 0, Blue);
               }
            }
            if (li_28 == TRUE) g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304 * gd_320, Bid, 3, 0, Bid - gd_328, "h", magic, 0, Red);
         }
         if (cmd_52 == OP_SELL && Bid >= order_open_price_56 + range * gd_268 && gi_368 == FALSE) {
            if (gi_172) {
               if (gi_152) {
                  g_lots_304 = NormalizeDouble(order_lots_64 * gd_156, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, Bid + gd_176 * gd_268, Bid - gd_184 * gd_268, "", magic, 0, Red);
               } else {
                  g_lots_304 = NormalizeDouble(order_lots_64 + gd_164, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, Bid + gd_176 * gd_268, Bid - gd_184 * gd_268, "", magic, 0, Red);
               }
            } else {
               if (gi_152) {
                  g_lots_304 = NormalizeDouble(order_lots_64 * gd_156, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, 0, 0, "", magic, 0, Red);
               } else {
                  g_lots_304 = NormalizeDouble(order_lots_64 + gd_164, gi_292);
                  g_ticket_300 = OrderSend(Symbol(), OP_SELL, g_lots_304, Bid, 3, 0, 0, "", magic, 0, Red);
               }
            }
            if (li_32 == TRUE) g_ticket_300 = OrderSend(Symbol(), OP_BUY, g_lots_304 * gd_320, Ask, 3, 0, Ask + gd_328, "h", magic, 0, Blue);
         }
      }
      ld_72 = 0;
      pos_44 = 0;
      for (pos_44 = 0; pos_44 <= OrdersTotal(); pos_44++) {
         OrderSelect(pos_44, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderType() < OP_BUYLIMIT) {
            if ((ls_36 == "B" && OrderType() == OP_SELL) || (ls_36 == "S" && OrderType() == OP_BUY)) ld_80 += OrderLots();
            ld_88 += OrderLots();
            ld_72 = ld_88 - ld_80;
            ld_96 = ld_72 - ld_80;
         }
      }
      ld_104 = AccountEquity();
      ld_112 = ld_104 - gd_360;
      if (ld_112 > ld_120) ld_120 = ld_112;
      Comment("OPT = ", gs_null_376, "  /  LEVEL = ", li_16, "  /  Hedge Start = ", gi_236, "  |  Standard Lots = ", DoubleToStr(ld_72, 2), "  /  Hedge Lots = ", DoubleToStr(ld_80, 2), "  /  Net Lots = ", DoubleToStr(ld_96, 2), 
      "\n", "Account Equity = ", DoubleToStr(ld_104, 2), "  /  Account Profit = ", DoubleToStr(ld_112, 2));
      if (gi_172 && f0_4() > 1) {
         for (li_48 = 0; li_48 < OrdersTotal(); li_48++) {
            OrderSelect(li_48, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic || OrderType() > OP_SELL) continue;
            cmd_52 = OrderType();
            order_stoploss_128 = OrderStopLoss();
            order_takeprofit_136 = OrderTakeProfit();
         }
         for (li_48 = OrdersTotal() - 1; li_48 >= 0; li_48--) {
            OrderSelect(li_48, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic || OrderType() > OP_SELL) continue;
            if (OrderType() == cmd_52)
               if (OrderStopLoss() != order_stoploss_128 || OrderTakeProfit() != order_takeprofit_136) OrderModify(OrderTicket(), OrderOpenPrice(), order_stoploss_128, order_takeprofit_136, 0, CLR_NONE);
         }
      }
      ld_144 = 0;
      for (li_48 = 0; li_48 < OrdersTotal(); li_48++) {
         OrderSelect(li_48, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic || OrderType() > OP_SELL) continue;
         ld_144 += OrderProfit();
      }
      if (ld_144 >= tp_in_money || g_count_296 > 0) {
         f0_3();
         f0_3();
         f0_3();
         g_count_296++;
         if (f0_4() == 0) g_count_296 = 0;
      }
      if (!((!gi_208) && gi_172 && f0_4() < level)) return (0);
      f0_3();
   }
   return (0);
}

double f0_1() {
   int day_0 = Day();
   double ld_ret_4 = 0;
   for (int pos_12 = 0; pos_12 < OrdersHistoryTotal(); pos_12++) {
      OrderSelect(pos_12, SELECT_BY_POS, MODE_HISTORY);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic) continue;
      if (TimeDay(OrderOpenTime()) == day_0) ld_ret_4 += OrderProfit();
   }
   return (ld_ret_4);
}

int f0_4() {
   int count_0 = 0;
   for (int pos_4 = 0; pos_4 < OrdersTotal(); pos_4++) {
      OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic) continue;
      count_0++;
   }
   return (count_0);
}

int f0_2() {
   double imacd_0 = iMACD(NULL, 0, 17, 26, 9, PRICE_OPEN, MODE_MAIN, gi_388 + 0);
   double ld_8 = 0;
   double imacd_16 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_MAIN, gi_388 + 2);
   double imacd_24 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_SIGNAL, gi_388 + 2);
   double imacd_32 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_MAIN, gi_388 + 1);
   double imacd_40 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_SIGNAL, gi_388 + 1);
   double imacd_48 = iMACD(NULL, 0, 17, 26, 9, PRICE_OPEN, MODE_MAIN, gi_388 + 0);
   double ld_56 = 0;
   double imacd_64 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_MAIN, gi_388 + 2);
   double imacd_72 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_SIGNAL, gi_388 + 2);
   double imacd_80 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_MAIN, gi_388 + 1);
   double imacd_88 = iMACD(NULL, 0, 17, 26, 9, PRICE_CLOSE, MODE_SIGNAL, gi_388 + 1);
   if (imacd_0 < ld_8 && imacd_16 < imacd_24 && imacd_32 > imacd_40) return (-2);
   if (imacd_48 > ld_56 && imacd_64 > imacd_72 && imacd_80 < imacd_88) return (2);
   return (0);
}

int f0_0() {
    if (IsDemo() || IsTradeAllowed() == TRUE) return (1);
   if (IsTesting() == TRUE) return (1);
   
   Alert("تë‏÷ يه âهًيûé ٌîâهٍيèê يه ًàلîٍàهٍ");
   return (0);
}

void f0_3() {
   for (int pos_0 = OrdersTotal() - 1; pos_0 >= 0; pos_0--) {
      OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != magic) continue;
      gi_368 = TRUE;
      if (OrderType() > OP_SELL) OrderDelete(OrderTicket());
      else {
         if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, 3, CLR_NONE);
         else OrderClose(OrderTicket(), OrderLots(), Ask, 3, CLR_NONE);
      }
   }
}