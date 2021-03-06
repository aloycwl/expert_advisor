string gs_76 = "1.8i";
extern int BrokerTimeZone = 0;
extern bool TakeHLSunday = FALSE;
int gi_92 = 11829830;
int gi_96 = 1;
bool gi_100 = TRUE;
bool gi_104 = TRUE;
int gi_108 = 25600;
int gi_112 = 12632256;
bool gi_116 = TRUE;
bool gi_120 = TRUE;
int gi_124 = 128;
int gi_128 = 12632256;
extern bool ShowComment = TRUE;
extern bool SendAlert = FALSE;
extern string Note = "To calculate your Risk and Reward please enter the Lot size";
extern double Lot = 1;
bool gi_156 = TRUE;
bool gi_160 = TRUE;
bool gi_164 = TRUE;
bool gi_168 = TRUE;
bool gi_172 = TRUE;
bool gi_176 = TRUE;
bool gi_180 = TRUE;
bool gi_184 = TRUE;
bool gi_188 = TRUE;
bool gi_192 = TRUE;
bool gi_196 = TRUE;
double gd_200 = 161.0;
double gd_208 = 200.0;
double gd_216 = 261.0;
double gd_224 = 361.0;
double gd_232 = 423.0;
double gd_240 = 161.0;
double gd_248 = 200.0;
double gd_256 = 261.0;
double gd_264 = 361.0;
double gd_272 = 423.0;
double g_ima_280 = 0.0;
double g_ima_288 = 0.0;
double gd_296 = 0.0;
double gd_304 = 0.0;
double gd_312 = 0.0;
double gd_320 = 0.0;
double g_ibuf_328[];
double g_ibuf_332[];
int gi_336 = 0;

int init() {
   IndicatorBuffers(2);
   SetIndexBuffer(0, g_ibuf_328);
   SetIndexBuffer(1, g_ibuf_332);
   SetIndexStyle(0, DRAW_NONE, EMPTY, 1);
   SetIndexArrow(0, 159);
   SetIndexBuffer(0, g_ibuf_328);
   SetIndexStyle(1, DRAW_NONE, EMPTY, 1);
   SetIndexArrow(1, 159);
   SetIndexBuffer(1, g_ibuf_332);
   IndicatorShortName("Dayly H/L");
   SetIndexLabel(0, "High");
   SetIndexLabel(1, "Low");
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   return (0);
}

int deinit() {
   ObjectsDeleteAll();
   Comment("");
   return (0);
}

int start() {
   double lda_68[][6];
   color l_color_528;
   int li_0 = IndicatorCounted();
   int li_4 = 0;
   int l_index_8 = 0;
   double ld_12 = 0.0;
   double ld_20 = EMPTY_VALUE;
   int li_28 = 0;
   int li_unused_32 = 0;
   int li_unused_36 = 0;
   double ld_40 = 0.0;
   int li_unused_48 = 0;
   int li_unused_52 = 0;
   int li_unused_56 = 0;
   string l_text_60 = "";
   int li_unused_72 = 0;
   int li_unused_76 = GetGMTHr(BrokerTimeZone);
   string ls_80 = "";
   int li_unused_88 = 0;
   double ld_92 = 0;
   double ld_100 = 0;
   double ld_108 = 0;
   double ld_116 = 0;
   double ld_124 = 0;
   double ld_132 = 0;
   double ld_140 = 0;
   double ld_220 = 0;
   double ld_unused_228 = 0;
   double ld_236 = 0;
   double ld_244 = 0;
   double ld_252 = 0;
   double ld_260 = 0;
   double ld_268 = 0;
   double ld_276 = 0;
   double ld_284 = 0;
   double ld_292 = 0;
   bool li_300 = FALSE;
   bool li_304 = FALSE;
   int l_day_of_year_308 = 0;
   int li_312 = 0;
   int li_316 = 0;
   int li_320 = 0;
   int li_324 = 0;
   double ld_328 = 0;
   double ld_336 = 0;
   double ld_344 = 0;
   double ld_352 = 0;
   double ld_360 = 0;
   double ld_368 = 0;
   double ld_376 = 0;
   double ld_384 = 0;
   double ld_392 = 0;
   double ld_400 = 0;
   double ld_408 = 0;
   double ld_416 = 0;
   double l_imacd_424 = 0;
   double l_iadx_432 = 0;
   double l_iadx_440 = 0;
   double l_iadx_448 = 0;
   double l_icci_456 = 0;
   double l_ichimoku_464 = 0;
   double l_irsi_472 = 0;
   double l_iwpr_480 = 0;
   string ls_unused_488 = "";
   string ls_unused_496 = "";
   double ld_504 = 0.0;
   double ld_512 = 0.0;
   double ld_520 = 0.0;
   int l_y_532 = 12;
   int l_fontsize_536 = 7;
   color l_color_540 = LightGray;
   int l_corner_544 = 0;
   string l_text_548 = "";
   if (BrokerTimeZone > 23 || BrokerTimeZone < -23) {
      Alert("TimeZone Invalid (", BrokerTimeZone, ")");
      return (0);
   }
   if (li_0 > 0) li_0--;
   li_28 = Bars - li_0;
   l_index_8 = li_4;
   ld_12 = 0;
   ld_20 = EMPTY_VALUE;
   li_300 = FALSE;
   li_304 = FALSE;
   while (!li_304 && l_day_of_year_308 != TimeDayOfYear(Time[l_index_8])) {
      if (!li_300 && TimeDayOfYear(Time[li_4]) - TimeDayOfYear(Time[l_index_8]) > 0) {
         li_300 = TRUE;
         li_312 = l_index_8;
         ld_244 = Close[l_index_8];
      }
      if (!li_304 && li_300 && TimeDayOfYear(Time[l_index_8]) - TimeDayOfYear(Time[l_index_8 + 1]) > 0 && TimeDayOfWeek(Time[l_index_8]) != 0) {
         li_304 = TRUE;
         li_316 = l_index_8;
         l_day_of_year_308 = TimeDayOfYear(Time[l_index_8]);
      }
      l_index_8++;
   }
   ld_252 = Open[li_312 - 1];
   for (l_index_8 = li_312; l_index_8 <= li_316; l_index_8++) {
      if (TakeHLSunday || (!TakeHLSunday && TimeDayOfWeek(Time[l_index_8]) != 0)) {
         if (High[l_index_8] > ld_12) {
            ld_12 = High[l_index_8];
            li_320 = l_index_8;
         }
         if (Low[l_index_8] < ld_20) {
            ld_20 = Low[l_index_8];
            li_324 = l_index_8;
         }
      }
   }
   ld_220 = ld_12;
   ld_236 = ld_20;
   ld_520 = (ld_252 + ld_220 + ld_236 + ld_244) / 4.0;
   ld_92 = (ld_220 + ld_236 + ld_244) / 3.0;
   ld_100 = 2.0 * ld_92 - ld_236;
   ld_124 = 2.0 * ld_92 - ld_220;
   ld_108 = ld_92 + (ld_220 - ld_236);
   ld_116 = ld_220 + 2.0 * (-ld_236);
   ld_132 = ld_92 - (ld_220 - ld_236);
   ld_140 = ld_236 - 2.0 * (ld_220 - ld_92);
   double ld_148 = ld_220 - ld_236;
   double ld_156 = 23.6 * ld_148 / 100.0 + ld_236;
   double ld_164 = 38.2 * ld_148 / 100.0 + ld_236;
   double ld_172 = 50.0 * ld_148 / 100.0 + ld_236;
   double ld_180 = 61.8 * ld_148 / 100.0 + ld_236;
   double ld_188 = ld_92 - 22.0 * Point;
   double ld_196 = ld_92 + 22.0 * Point;
   double ld_204 = ld_188 - 15.0 * Point;
   double ld_212 = ld_196 + 15.0 * Point;
   ld_328 = ld_220 - ld_236;
   ld_336 = ld_328 / 2.0;
   ld_344 = ld_336 * gd_200 / 100.0 + ld_236 - 0.0011;
   ld_352 = ld_336 * gd_208 / 100.0 + ld_236 - 0.0011;
   ld_360 = ld_336 * gd_216 / 100.0 + ld_236 - 0.0011;
   ld_368 = ld_336 * gd_224 / 100.0 + ld_236 - 0.0011;
   ld_376 = ld_336 * gd_232 / 100.0 + ld_236 - 0.0011;
   ld_384 = MathAbs(ld_336 * gd_240 / 100.0 - ld_220 - 0.0011);
   ld_392 = MathAbs(ld_336 * gd_248 / 100.0 - ld_220 - 0.0011);
   ld_400 = MathAbs(ld_336 * gd_256 / 100.0 - ld_220 - 0.0011);
   ld_408 = MathAbs(ld_336 * gd_264 / 100.0 - ld_220 - 0.0011);
   ld_416 = MathAbs(ld_336 * gd_272 / 100.0 - ld_220 - 0.0011);
   ld_260 = 0;
   ld_268 = EMPTY_VALUE;
   for (l_index_8 = 0; l_index_8 < li_312 - 1; l_index_8++) {
      if (High[l_index_8] > ld_260) ld_260 = High[l_index_8];
      if (Low[l_index_8] < ld_268) ld_268 = Low[l_index_8];
   }
   if (ld_244 < ld_252) ld_276 = ld_220 + ld_236 + ld_244 + ld_236;
   if (ld_244 > ld_252) ld_276 = ld_220 + ld_236 + ld_244 + ld_220;
   if (ld_244 == ld_252) ld_276 = ld_220 + ld_236 + ld_244 + ld_244;
   ld_284 = ld_276 / 2.0 - ld_236;
   ld_292 = ld_276 / 2.0 - ld_220;
   g_ibuf_328[li_4] = ld_220;
   g_ibuf_332[li_4] = ld_236;
   if (ls_80 != "LongArea " + Symbol() + Period() + li_4 && gi_336 != Time[0]) {
      ls_80 = "LongArea " + Symbol() + Period() + li_4;
      ObjectsDeleteAll();
      gi_336 = Time[0];
   }
   if (gi_164) {
      MoveObject("StartDay " + Symbol() + Period() + li_4, OBJ_VLINE, Time[li_312 - 1], ld_40, Time[li_312 - 1], ld_40, DarkGreen, gi_96, STYLE_DOT);
      MoveObject("StartLastDay " + Symbol() + Period() + li_4, OBJ_VLINE, Time[li_316], ld_40, Time[li_316], ld_40, DarkGreen, gi_96, STYLE_DOT);
   }
   if (gi_168) {
      MoveObject("YesterdayH " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_320], ld_220, Time[0], ld_220, DarkGreen, gi_96, STYLE_DOT);
      MoveObject("YesterdayL " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_324], ld_236, Time[0], ld_236, DarkGreen, gi_96, STYLE_DOT);
      if (gi_172) {
         SetObjectText("YHtxt" + Symbol() + Period() + li_4, "[Yesterday High] " + DoubleToStr(ld_220, 4), "Arial", 7, Silver);
         MoveObject("YHtxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[li_312 + 11], ld_220, Time[0], ld_220, Silver);
         SetObjectText("YLtxt" + Symbol() + Period() + li_4, "[Yesterday Low] " + DoubleToStr(ld_236, 4), "Arial", 7, Silver);
         MoveObject("YLtxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[li_312 + 11], ld_236, Time[0], ld_236, Silver);
      }
   }
   if (gi_176) {
      MoveObject("PreH " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_284, Time[0], ld_284, DarkGreen, 3, STYLE_DOT);
      MoveObject("PreL " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_292, Time[0], ld_292, Maroon, 3, STYLE_DOT);
      if (gi_180) {
         SetObjectText("PYHtxt" + Symbol() + Period() + li_4, "[Reversal prediction High] " + DoubleToStr(ld_284, 4), "Arial", 7, Silver);
         MoveObject("PYHtxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[li_312 + 8], ld_284, Time[li_312 + 8], ld_284, Silver);
         SetObjectText("PYLtxt" + Symbol() + Period() + li_4, "[Reversal prediction Low] " + DoubleToStr(ld_292, 4), "Arial", 7, Silver);
         MoveObject("PYLtxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[li_312 + 8], ld_292, Time[li_312 + 8], ld_292, Silver);
      }
   }
   if (gi_184) {
      MoveObject("TR5 " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_376, Time[0], ld_376, DarkGreen, 3, STYLE_DOT);
      MoveObject("TS5 " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_416, Time[0], ld_416, Maroon, 3, STYLE_DOT);
      if (gi_188) {
         SetObjectText("TR5txt" + Symbol() + Period() + li_4, "[Danger! STOP BUY HERE] " + DoubleToStr(ld_376, 4), "Arial", 7, Silver);
         MoveObject("TR5txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_376, Time[0], ld_376, Silver);
         SetObjectText("TS5txt" + Symbol() + Period() + li_4, "[Danger! STOP SELL HERE] " + DoubleToStr(ld_416, 4), "Arial", 7, Silver);
         MoveObject("TS5txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_416, Time[0], ld_416, Silver);
      }
   }
   if (gi_192) {
      ls_unused_488 = "TR4";
      ld_504 = ld_368;
      if (ld_344 > ld_212 + 8.0 * Point) {
         ls_unused_488 = "TR1";
         ld_504 = ld_344;
      } else {
         if (ld_352 > ld_212 + 8.0 * Point) {
            ls_unused_488 = "TR2";
            ld_504 = ld_352;
         } else {
            if (ld_360 > ld_212 + 8.0 * Point) {
               ls_unused_488 = "TR3";
               ld_504 = ld_360;
            } else {
               if (ld_368 > ld_212 + 8.0 * Point) {
                  ls_unused_488 = "TR4";
                  ld_504 = ld_368;
               } else {
                  if (ld_376 > ld_212 + 8.0 * Point) {
                     ls_unused_488 = "TR5";
                     ld_504 = ld_376;
                  }
               }
            }
         }
      }
      ls_unused_496 = ld_408;
      ld_512 = ld_408;
      if (ld_384 < ld_204 - 8.0 * Point) {
         ls_unused_496 = "TS1";
         ld_512 = ld_384;
      } else {
         if (ld_392 < ld_204 - 8.0 * Point) {
            ls_unused_496 = "TS2";
            ld_512 = ld_392;
         } else {
            if (ld_400 < ld_204 - 8.0 * Point) {
               ls_unused_496 = "TS3";
               ld_512 = ld_400;
            } else {
               if (ld_408 < ld_204 - 8.0 * Point) {
                  ls_unused_496 = "TS4";
                  ld_512 = ld_408;
               } else {
                  if (ld_416 < ld_204 - 8.0 * Point) {
                     ls_unused_496 = "TS5";
                     ld_512 = ld_416;
                  }
               }
            }
         }
      }
      MoveObject("TPR " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_504, Time[0], ld_504, DarkGreen, 3, STYLE_DOT);
      MoveObject("TPS " + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_512, Time[0], ld_512, Maroon, 3, STYLE_DOT);
      if (gi_196) {
         SetObjectText("TPRtxt" + Symbol() + Period() + li_4, "[take profit target] " + DoubleToStr(ld_504, 4), "Arial", 7, Silver);
         MoveObject("TPRtxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_504, Time[0], ld_504, Silver);
         SetObjectText("TPStxt" + Symbol() + Period() + li_4, "take profit target] " + DoubleToStr(ld_512, 4), "Arial", 7, Silver);
         MoveObject("TPStxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_512, Time[0], ld_512, Silver);
      }
   }
   if (gi_156) {
      MoveObject("f23" + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_156, Time[0], ld_156, gi_92, gi_96, STYLE_DASHDOT);
      MoveObject("f38" + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_164, Time[0], ld_164, gi_92, gi_96, STYLE_DASHDOT);
      MoveObject("f50" + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_172, Time[0], ld_172, gi_92, gi_96, STYLE_DASHDOT);
      MoveObject("f61" + Symbol() + Period() + li_4, OBJ_TREND, Time[li_312 - 1], ld_180, Time[0], ld_180, gi_92, gi_96, STYLE_DASHDOT);
      if (gi_160) {
         SetObjectText("f23txt" + Symbol() + Period() + li_4, "23.6%", "Arial", 7, gi_92);
         MoveObject("f23txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_156, Time[0], ld_156, gi_92);
         SetObjectText("f38txt" + Symbol() + Period() + li_4, "38.2%", "Arial", 7, gi_92);
         MoveObject("f38txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_164, Time[0], ld_164, gi_92);
         SetObjectText("f50txt" + Symbol() + Period() + li_4, "50.0%", "Arial", 7, gi_92);
         MoveObject("f50txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_172, Time[0], ld_172, gi_92);
         SetObjectText("f61txt" + Symbol() + Period() + li_4, "61.8%", "Arial", 7, gi_92);
         MoveObject("f61txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_180, Time[0], ld_180, gi_92);
      }
   }
   if (gi_100) {
      MoveObject("BuyArea " + Symbol() + Period() + li_4, OBJ_RECTANGLE, Time[li_312 - 1], ld_196, 1577836800, ld_212, gi_108, 1, STYLE_SOLID);
      ObjectSet("BuyArea " + Symbol() + Period() + li_4, OBJPROP_RAY, TRUE);
      if (gi_104) {
         SetObjectText("BuyAreatxt" + Symbol() + Period() + li_4, "[Buy Area] start: " + DoubleToStr(ld_196, 4), "Arial", 7, gi_112);
         MoveObject("BuyAreatxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_196 + 4.0 * Point, Time[0], ld_196 + 4.0 * Point, gi_112);
         SetObjectText("BuyArea2txt" + Symbol() + Period() + li_4, "[Buy Area] end: " + DoubleToStr(ld_212, 4), "Arial", 7, gi_112);
         MoveObject("BuyArea2txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_212, Time[0], ld_212, gi_112);
      }
   }
   if (gi_116) {
      MoveObject("SellArea " + Symbol() + Period() + li_4, OBJ_RECTANGLE, Time[li_312 - 1], ld_188, 1577836800, ld_204, gi_124, 1, STYLE_SOLID);
      ObjectSet("SellArea " + Symbol() + Period() + li_4, OBJPROP_RAY, TRUE);
      if (gi_120) {
         SetObjectText("SellAreatxt" + Symbol() + Period() + li_4, "[Sell Area] start: " + DoubleToStr(ld_188, 4), "Arial", 7, gi_128);
         MoveObject("SellAreatxt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_188, Time[0], ld_188, gi_112);
         SetObjectText("SellArea2txt" + Symbol() + Period() + li_4, "[Sell Area] end: " + DoubleToStr(ld_204, 4), "Arial", 7, gi_128);
         MoveObject("SellArea2txt" + Symbol() + Period() + li_4, OBJ_TEXT, Time[0], ld_204 + 4.0 * Point, Time[0], ld_204 + 4.0 * Point, gi_128);
      }
   }
   l_imacd_424 = iMACD(Symbol(), 0, 5, 9, 9, PRICE_CLOSE, MODE_MAIN, 0);
   l_iadx_432 = iADX(Symbol(), 0, 9, PRICE_CLOSE, MODE_MAIN, 0);
   l_iadx_440 = iADX(Symbol(), 0, 9, PRICE_CLOSE, MODE_PLUSDI, 0);
   l_iadx_448 = iADX(Symbol(), 0, 9, PRICE_CLOSE, MODE_MINUSDI, 0);
   l_icci_456 = iCCI(Symbol(), 0, 22, PRICE_CLOSE, 0);
   l_ichimoku_464 = iIchimoku(Symbol(), 0, 9, 26, 52, MODE_CHINKOUSPAN, 26);
   l_irsi_472 = iRSI(Symbol(), 0, 14, PRICE_CLOSE, 0);
   l_iwpr_480 = iWPR(Symbol(), 0, 22, 0);
   g_ima_280 = iMA(Symbol(), Period(), 9, 0, MODE_SMA, PRICE_CLOSE, 0);
   g_ima_288 = iMA(Symbol(), Period(), 12, 0, MODE_SMA, PRICE_CLOSE, 0);
   if (Close[0] > g_ima_280 && Close[0] > g_ima_288 && g_ima_280 > g_ima_288) gd_296 = 1;
   if (Close[0] < g_ima_280 && Close[0] < g_ima_288 && g_ima_280 < g_ima_288) gd_304 = 1;
   if (l_imacd_424 > 0.0 && l_irsi_472 > 50.0 && Close[0] > ld_92) gd_312 = 1;
   if (l_imacd_424 < 0.0 && l_irsi_472 < 50.0 && Close[0] < ld_92) gd_320 = 1;
   l_text_60 = "--------------------------------------------------------------------------------------------------------";
   ObjectCreate("L1" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L1" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L1" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L1" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   ObjectSet("L1" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   l_text_60 = "POUND SOLUTIONS version " + gs_76;
   ObjectCreate("L2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L2" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   l_text_60 = "--------------------------------------------------------------------------------------------------------";
   ObjectCreate("L3" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L3" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L3" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L3" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L3" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   ObjectCreate("L4" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L4" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L4" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L4" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L4" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   l_text_60 = "--------------------------------------------------------------------------------------------------------";
   ObjectCreate("L5" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L5" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L5" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L5" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L5" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   l_text_60 = "" + Symbol() + " Market Analysis at " + TimeToStr(Time[0]);
   ObjectCreate("L6" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L6" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L6" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L6" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L6" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   l_text_60 = "--------------------------------------------------------------------------------------------------------";
   ObjectCreate("L7" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
   ObjectSetText("L7" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
   ObjectSet("L7" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
   ObjectSet("L7" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   l_y_532 += 10;
   ObjectSet("L7" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
   if (Close[0] <= ld_212 && Close[0] >= ld_196) {
      if (SendAlert) Alert("Signal: BUY at " + DoubleToStr(ld_196, 4) + " to " + DoubleToStr(ld_212, 4) + ", Target: " + DoubleToStr(ld_512, 4) + ", Stop Loss: 400");
   } else {
      if (Close[0] <= ld_188 && Close[0] >= ld_204)
         if (SendAlert) Alert("Signal: SELL at " + DoubleToStr(ld_188, 4) + " to ", DoubleToStr(ld_204, 4) + ", Target: " + DoubleToStr(ld_512, 4) + ", Stop Loss: 400");
   }
   if (ShowComment) {
      l_text_60 = "MACD: ";
      if (l_imacd_424 == 0.0) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      if (l_imacd_424 < 0.0) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      if (l_imacd_424 > 0.0) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      ObjectCreate("L8" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L8" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L8" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L8" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 12;
      ObjectSet("L8" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L8arrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L8arrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L8arrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L8arrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 40);
      ObjectSet("L8arrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "ADX: ";
      if (l_iadx_432 >= 0.0 && l_iadx_432 <= 25.0) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      if (l_iadx_432 > 25.0 && l_iadx_440 > l_iadx_448) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      if (l_iadx_432 > 25.0 && l_iadx_440 < l_iadx_448) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      ObjectCreate("L9" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L9" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L9" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L9" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L9" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L9arrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L9arrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L9arrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L9arrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 40);
      ObjectSet("L9arrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "CCI: ";
      if (l_icci_456 > 100.0) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      if (l_icci_456 < 100.0) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      ObjectCreate("L10" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L10" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L10" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L10" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L10" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L10arrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L10arrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L10arrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L10arrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 40);
      ObjectSet("L10arrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "William percent: ";
      if (l_iwpr_480 >= -75.0) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      if (l_iwpr_480 <= -20.0) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      if (l_iwpr_480 < -75.0 && l_iwpr_480 > -20.0) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      ObjectCreate("L11" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L11" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L11" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L11" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L11" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L11arrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L11arrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L11arrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L11arrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 100);
      ObjectSet("L11arrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "Ichimoku Kinko Hyo: ";
      if (l_ichimoku_464 == ld_92) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      if (l_ichimoku_464 > ld_92) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      if (l_ichimoku_464 < ld_92) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      ObjectCreate("L12" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L12" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L12" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L12arrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12arrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L12arrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12arrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 100);
      ObjectSet("L12arrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "POUND SOLUTIONS Direction: ";
      if (gd_296 < 1.0 && gd_304 < 1.0) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      if (gd_304 > 0.0) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      if (gd_296 > 0.0) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      ObjectCreate("L12a" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12a" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L12a" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12a" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L12a" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L12aarrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12aarrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L12aarrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12aarrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 85);
      ObjectSet("L12aarrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "POUND SOLUTIONS Volatility: ";
      if (gd_312 < 1.0 && gd_320 < 1.0) {
         l_text_548 = "´";
         l_color_528 = SteelBlue;
      }
      if (gd_312 > 0.0) {
         l_text_548 = "Ç";
         l_color_528 = Lime;
      }
      if (gd_320 > 0.0) {
         l_text_548 = "È";
         l_color_528 = Red;
      }
      ObjectCreate("L12b" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12b" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L12b" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12b" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 16;
      ObjectSet("L12b" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      ObjectCreate("L12barrow" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L12barrow" + Symbol() + Period(), l_text_548, 14, "Wingdings 3", l_color_528);
      ObjectSet("L12barrow" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L12barrow" + Symbol() + Period(), OBJPROP_XDISTANCE, 85);
      ObjectSet("L12barrow" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532 - 4);
      l_text_60 = "--------------------------------------------------------------------------------------------------------";
      ObjectCreate("L13" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L13" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L13" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L13" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L13" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Risk Management for Long (Buy) Signal";
      ObjectCreate("L14" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L14" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L14" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L14" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L14" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "--------------------------------------------------------------------------------------------------------";
      ObjectCreate("L15" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L15" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L15" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L15" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L15" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Entry Price: " + DoubleToStr(ld_196, 4);
      ObjectCreate("L16" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L16" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L16" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L16" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L16" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Target: " + DoubleToStr(ld_504, 4);
      ObjectCreate("L16-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L16-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L16-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L16-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L16-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Pip profit: " + DoubleToStr((ld_504 - ld_196) / Point, 0);
      ObjectCreate("L17" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L17" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L17" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L17" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L17" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Pip Loss: -400 PIPs";
      ObjectCreate("L17-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L17-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L17-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L17-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L17-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Profit at target $" + DoubleToStr((ld_504 - ld_196) / Point * Lot * MarketInfo(Symbol(), MODE_TICKVALUE), 2);
      ObjectCreate("L18" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L18" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L18" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L18" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L18" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Loss at Stop: $-" + DoubleToStr(400.0 * Lot * MarketInfo(Symbol(), MODE_TICKVALUE), 2);
      ObjectCreate("L18-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L18-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L18-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L18-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L18-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "%Reward: " + DoubleToStr(100.0 * ((ld_504 - ld_196) / Point * Lot * MarketInfo(Symbol(), MODE_TICKVALUE)) / AccountEquity(), 2);
      ObjectCreate("L19" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L19" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L19" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L19" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L19" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "%Risk: " + DoubleToStr(100.0 * (40.0 * Lot * MarketInfo(Symbol(), MODE_TICKVALUE)) / AccountEquity(), 2);
      ObjectCreate("L19-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L19-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L19-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L19-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L19-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "--------------------------------------------------------------------------------------------------------";
      ObjectCreate("L20" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L20" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L20" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L20" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L20" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "R1/R2/R3 " + DoubleToStr(ld_100, 4) + "/" + DoubleToStr(ld_108, 4) + "/" + DoubleToStr(ld_116, 4);
      ObjectCreate("L21" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L21" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L21" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L21" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L21" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Pivot: " + DoubleToStr(ld_520, 4);
      ObjectCreate("L22" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L22" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L22" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L22" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L22" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "S1/S2/S3 " + DoubleToStr(ld_124, 4) + "/" + DoubleToStr(ld_132, 4) + "/" + DoubleToStr(ld_140, 4);
      ObjectCreate("L23" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L23" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L23" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L23" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L23" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "--------------------------------------------------------------------------------------------------------";
      ObjectCreate("L24" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L24" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L24" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L24" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L24" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Risk Management for Short (Sell) Signal";
      ObjectCreate("L25" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L25" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L25" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L25" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L25" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "--------------------------------------------------------------------------------------------------------";
      ObjectCreate("L26" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L26" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L26" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L26" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L26" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Entry Price: " + DoubleToStr(ld_188, 4);
      ObjectCreate("L27" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L27" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L27" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L27" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L27" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Target: " + DoubleToStr(ld_512, 4);
      ObjectCreate("L27-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L27-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L27-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L27-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L27-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Pip profit: " + DoubleToStr((ld_188 - ld_512) / Point, 0);
      ObjectCreate("L28" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L28" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L28" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L28" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L28" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Pip Loss: -400 PIPs";
      ObjectCreate("L28-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L28-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L28-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L28-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L28-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Profit at target $" + DoubleToStr((ld_188 - ld_512) / Point * Lot * MarketInfo(Symbol(), MODE_TICKVALUE), 2);
      ObjectCreate("L29" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L29" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L29" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L29" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L29" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Loss at Stop: $-" + DoubleToStr(400.0 * Lot * MarketInfo(Symbol(), MODE_TICKVALUE), 2);
      ObjectCreate("L29-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L29-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L29-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L29-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L29-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "%Reward: " + DoubleToStr(100.0 * ((ld_188 - ld_512) / Point * Lot * MarketInfo(Symbol(), MODE_TICKVALUE)) / AccountEquity(), 2);
      ObjectCreate("L30" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L30" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L30" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L30" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L30" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "%Risk: " + DoubleToStr(100.0 * (40.0 * Lot * MarketInfo(Symbol(), MODE_TICKVALUE)) / AccountEquity(), 2);
      ObjectCreate("L30-2" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L30-2" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L30-2" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L30-2" + Symbol() + Period(), OBJPROP_XDISTANCE, 130);
      ObjectSet("L30-2" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_y_532 += 10;
      ObjectSet("L33" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Start trading hours: 22:00 GMT";
      ObjectCreate("L34" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L34" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L34" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L34" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L34" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "End trading hours:  15:00 GMT";
      ObjectCreate("L35" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L35" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L35" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L35" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L49" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "+/-Profit:";
      ObjectCreate("L50" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L50" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L50" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L50" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L50" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Lot: " + DoubleToStr(Lot, 2);
      ObjectCreate("L51" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L51" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L51" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L51" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
      l_y_532 += 10;
      ObjectSet("L51" + Symbol() + Period(), OBJPROP_YDISTANCE, l_y_532);
      l_text_60 = "Spread: " + DoubleToStr(MarketInfo(Symbol(), MODE_SPREAD), 0);
      ObjectCreate("L52" + Symbol() + Period(), OBJ_LABEL, 0, 0, 0);
      ObjectSetText("L52" + Symbol() + Period(), l_text_60, l_fontsize_536, "Arial", l_color_540);
      ObjectSet("L52" + Symbol() + Period(), OBJPROP_CORNER, l_corner_544);
      ObjectSet("L52" + Symbol() + Period(), OBJPROP_XDISTANCE, 7);
   }
   return (0);
}

int MoveObject(string a_name_0, int ai_8, int a_datetime_12, double ad_16, int a_datetime_24 = 0, double ad_28 = 0.0, color a_color_36 = -1, int a_width_40 = 0, int a_style_44 = 0) {
   int li_48;
   if (ObjectFind(a_name_0) != -1) {
      li_48 = ObjectType(a_name_0);
      if (li_48 == 0 || li_48 == 1 || li_48 == 3 || li_48 == 22 || li_48 == 23) return (ObjectMove(a_name_0, 0, a_datetime_12, ad_16));
      if (li_48 == 21) return (ObjectMove(a_name_0, 1, a_datetime_12, ad_16));
      if (li_48 == 7 || li_48 == 8 || li_48 == 9 || li_48 == 10 || li_48 == 11 || li_48 == 12 || li_48 == 13 || li_48 == 16 || li_48 == 18 || li_48 == 20 || li_48 == 2 ||
         li_48 == 6 || li_48 == 4) return (ObjectMove(a_name_0, 0, a_datetime_12, ad_16) && ObjectMove(a_name_0, 1, a_datetime_24, ad_28));
   } else {
      return (ObjectCreate(a_name_0, ai_8, 0, a_datetime_12, ad_16, a_datetime_24, ad_28, 0, 0) && ObjectSet(a_name_0, OBJPROP_COLOR, a_color_36) && ObjectSet(a_name_0, OBJPROP_WIDTH, a_width_40) &&
         ObjectSet(a_name_0, OBJPROP_STYLE, a_style_44));
   }
   return (0);
}

void SetObjectText(string a_name_0, string a_text_8, string a_fontname_16, int a_fontsize_24, color a_color_28) {
   ObjectSetText(a_name_0, a_text_8, a_fontsize_24, a_fontname_16, a_color_28);
}

int GetGMTHr(int ai_0) {
   int li_ret_4 = 0;
   if (ai_0 > 0) {
      li_ret_4 = 0 - ai_0;
      if (li_ret_4 < 0) li_ret_4 = 23 - MathAbs(li_ret_4) + 1.0;
   }
   if (ai_0 < 0) {
      li_ret_4 = (-1 * ai_0) + 0;
      if (li_ret_4 > 23) li_ret_4 -= 23;
   }
   if (ai_0 == 0) li_ret_4 = 0;
   return (li_ret_4);
}

