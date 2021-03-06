// if(Cross(2, ) //Price crosses below Bollinger Bands
// if(Cross(3, ) //Price crosses above Bollinger Bands
  
extern double Lots=0.01,MaxLots=0.5,LotExponent=1,Buffer=50;;
extern uchar TakeProfit=50,StopLoss=180;
int ihl;

int start(){

   if(ihl!=Time[0]){ ihl=Time[0];
      bool lC; // (Local}) Order function checking
      char lI=LorC(0,false); // (Local) Count trade
      short gS[]={1,0,1,0,1,1,0};
      if(lI>0) return 0; // Cancel off trade and reset
      double lS=StopLoss*Point,lP=LorC(),lL=Lots,lD=0,lT=TakeProfit*Point; // (Local) Step size, Last price, Lot size, Direction [0=Buy,1=Sell]
      
      if(iLow(Symbol(), 0, 1) < iBands(NULL, PERIOD_CURRENT, 120, 3, 0, PRICE_CLOSE, MODE_LOWER, 0)){
         lC=OrderSend(Symbol(),0,lL,Ask,5,Ask-lS,Ask+lT);
         
      }
      
      if(iHigh(Symbol(), 0, 1) > iBands(NULL, PERIOD_CURRENT, 120, 3, 0, PRICE_CLOSE, MODE_UPPER, 0)+Buffer*Point){
         lC=OrderSend(Symbol(),1,lL,Bid,5,Bid+lS,Bid-lT);
      }
      
   }
   return 0;
}
double LorC(char a=0, bool b=true){ //Last Price or Count
   char cFC,i;
   bool c; 
   
   for(i=OrdersTotal()-1;i>=0;i--){
      c=OrderSelect(i,0);
      if(OrderSymbol()==Symbol()&&OrderMagicNumber()==a)
         if(!b)cFC++;
         else return OrderOpenPrice();
   }
   return cFC;
}

