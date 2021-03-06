extern double Lots=0.01,LotExponent=1,Buffer=50;
extern ushort TakeProfit=50,StopLoss=180,BD=3;
int ihl;

int start(){
   if(ihl!=Time[0]){ ihl=Time[0];
      bool lC; // (Local}) Order function checking
      for(char i=OrdersTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0) return 0;
      }
      
      double lS=StopLoss*Point,lL=Lots,lT=TakeProfit*Point; // (Local) Step size, Lot size
      
      for(i=OrdersHistoryTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0,1);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0){
            if(OrderProfit()<0) lL=OrderLots()*2.5;
            break;
         }
      }
      
      if(Bid+Buffer*Point<iBands("",PERIOD_CURRENT,120,BD,0,PRICE_CLOSE,2,0)) lC=OrderSend(Symbol(),0,lL,Ask,5,Ask-lS,Ask+lT);
      
      if(Bid>iBands("",PERIOD_CURRENT,120,BD,0,PRICE_CLOSE,1,0)+Buffer*Point) lC=OrderSend(Symbol(),1,lL,Bid,5,Bid+lS,Bid-lT);
      
   }
   return 0;
}