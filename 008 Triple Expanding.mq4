extern double Lots=0.01,MaxLots=0.5,LotExponent=1,Multiplier=1.5;
extern uchar TakeProfit=50,StopLoss=180;
int ihl,iM=1,TradeLost,ExpandingCount=0;

int start(){
   //if(ihl!=Time[0]){ ihl=Time[0];
      bool lC; // (Local}) Order function checking
      char lI=LorC(0,false); // (Local) Count trade
      if(lI!=0) return 0; // Cancel off trade and reset
      
      double lS=StopLoss*Point,lL=Lots,lD=0,lT=TakeProfit*Point; // (Local) Step size, Lot size, Direction [0=Buy,1=Sell]
      
      if(ExpandingCount<5){
         ExpandingCount++;
         lL=NormalizeDouble(Lots*MathPow(LotExponent,ExpandingCount),2);
         lS*=ExpandingCount;
         lT*=ExpandingCount;
      }else{
         ExpandingCount=0;
      }
      
      for(int i=OrdersHistoryTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0,1);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0){
            if(OrderType()==0)lD=1;
            else lD=0;
            break;
         }
      }
      if(lD==1) lC=OrderSend(Symbol(),1,lL,Bid,5,Bid+lS,Bid-lT); else lC=OrderSend(Symbol(),0,lL,Ask,5,Ask-lS,Ask+lT);
   //}
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