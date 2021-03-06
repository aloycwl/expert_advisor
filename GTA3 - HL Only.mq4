extern double Lots=0.01,LotExponent=1.667;
extern short PipStep=180,TakeProfit=70;
int ihl;
int start() {
   if(ihl!=Time[0]) { // Not trading in the same candle
      ihl=Time[0];
      bool c; // Local variables
      char li,i,id=2;
      double dP=PipStep*Point,dL,dT,dO;
      
      for(i=OrdersTotal()-1; i>=0; i--) { // To select number of orders and last price (if any)
         c=OrderSelect(i,0);
         if(OrderSymbol()==Symbol()){
            if(dL==0) dL=OrderOpenPrice();
            li++;
           }
        }
      for(i=OrdersTotal()-1; i>=0; i--) { // Select the previous Order direction
         c=OrderSelect(i,0);
         if(OrderSymbol()==Symbol()){
            id=OrderType();
            break;
           }
        }

      if(li==0||(id==0&&dL-Ask>=dP)||(id==1&&Bid-dL>=dP)) { // Entering the trade
         if((li==0&&iHigh(Symbol(),0,1)>iLow(Symbol(),0,2)&&iRSI(0,60,14,0,1)>30)||id==1)
            c=OrderSend(Symbol(),1,NormalizeDouble(Lots*MathPow(LotExponent,li),2),Bid,3,0,0);
         else
            c=OrderSend(Symbol(),0,NormalizeDouble(Lots*MathPow(LotExponent,li),2),Ask,3,0,0);

         for(i=OrdersTotal()-1; i>=0; i--) { // Recalculating the price to take profit
            c=OrderSelect(i,0);
            if(OrderSymbol()==Symbol()) {
               dT+=OrderOpenPrice()*OrderLots();
               dO+=OrderLots();
              }
           }
         dT=NormalizeDouble(dT/dO,Digits);
         for(i=OrdersTotal()-1; i>=0; i--) { // Modifying all orders
            c=OrderSelect(i,0);
            if(OrderSymbol()==Symbol())
               c=OrderModify(OrderTicket(),dT,OrderStopLoss(),OrderType()==0?dT+TakeProfit*Point:dT-TakeProfit*Point,0);
           }
        }
     }
   return 0;
  }