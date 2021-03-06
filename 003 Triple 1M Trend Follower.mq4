extern double Lots=0.01,MaxLots=0.5,LotExponent=1,Multiplier=1.5;
extern uchar TakeProfit=50,StopLoss=180;
int ihl;

int start(){
   if(ihl!=Time[0]){ ihl=Time[0];
      bool lC,trade; // (Local}) Order function checking
      char lI=LorC(0,false); // (Local) Count trade
      short gS[]={1,0,1,0,1,1,0};
      //if(lI!=0) return 0; // Cancel off trade and reset
      double lS=StopLoss*Point,lP=LorC(),lL=Lots,lD=0,lT=TakeProfit*Point; // (Local) Step size, Last price, Lot size, Direction [0=Buy,1=Sell]
      
      if(
      iClose(Symbol(),0,8)>=iClose(Symbol(),0,7)&&
      iClose(Symbol(),0,7)>=iClose(Symbol(),0,6)&&
      iClose(Symbol(),0,6)>=iClose(Symbol(),0,5)&&
      iClose(Symbol(),0,5)>=iClose(Symbol(),0,4)&&
      iClose(Symbol(),0,4)>=iClose(Symbol(),0,3)&&
      iClose(Symbol(),0,3)>=iClose(Symbol(),0,2)&&
      iClose(Symbol(),0,2)>=iClose(Symbol(),0,1)
      ){
         lD=0;trade=true;
      }
      
      if(
      iClose(Symbol(),0,8)<=iClose(Symbol(),0,7)&&
      iClose(Symbol(),0,7)<=iClose(Symbol(),0,6)&&
      iClose(Symbol(),0,6)<=iClose(Symbol(),0,5)&&
      iClose(Symbol(),0,5)<=iClose(Symbol(),0,4)&&
      iClose(Symbol(),0,4)<=iClose(Symbol(),0,3)&&
      iClose(Symbol(),0,3)<=iClose(Symbol(),0,2)&&
      iClose(Symbol(),0,2)<=iClose(Symbol(),0,1)
      ){
         lD=1;trade=true;
      }
      
      if(trade){     
         if(lD==1) lC=OrderSend(Symbol(),1,lL,Bid,5,Bid+lS,Bid-lT); else lC=OrderSend(Symbol(),0,lL,Ask,5,Ask-lS,Ask+lT);
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

