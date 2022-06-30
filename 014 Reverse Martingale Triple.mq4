extern double Lots=0.01;

int start(){
      bool lC;
      for(char i=OrdersTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0) return 0;
      }
      
      double num=100*Point,lS=num,lL=Lots,lT=num,lD=0;
      
      for(i=OrdersHistoryTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0,1);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0)
            if(OrderProfit()>0&&OrderLots()<0.03){
               lL=OrderLots()*2.2;
               lD=OrderType();
            }else if(OrderProfit()>0)lD=OrderType();
            else lD=OrderType()==0?1:0;
            break;
      }
      
      if(lD==0)lC=OrderSend(Symbol(),0,lL,Ask,5,Ask-lS,Ask+lT);
      else lC=OrderSend(Symbol(),1,lL,Bid,5,Bid+lS,Bid-lT);
      
   return 0;
}