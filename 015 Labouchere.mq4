extern double Lots=0.01;
double gad[50];

int start(){
      bool lC;
      for(char i=OrdersTotal()-1;i>=0;i--){     //SKIP if have existing trade
         lC=OrderSelect(i,0); if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0)return 0; }
      
      double firstNum,lastNum,lS=20*Point,lT=30*Point,lD=0,betSize;
      
      for(i=OrdersHistoryTotal()-1;i>=0;i--){
         lC=OrderSelect(i,0,1);
         if(OrderSymbol()==Symbol()&&OrderMagicNumber()==0)
            if(OrderProfit()<0){                //[LOSE] adding in the array
               for(i=ArraySize(gad)-1;i!=0;i--){
                  if(gad[i]!=0){
                     gad[i+1]=OrderLots();
                     break;
                  }
               }
               lD=OrderType()==0?1:0;
            }else{                              //[WIN] removing first and last array
               for(i=0;i<ArraySize(gad);i++){
                  if(gad[i]>0){
                     gad[i]=0;
                     break;
                  }
               }
               for(i=ArraySize(gad)-1;i!=0;i--){
                  if(gad[i]>0){
                     gad[i]=0;
                     break;
                  }
               }
               lD=OrderType();
            }
            break;
      }
      
      for(i=0;i<ArraySize(gad);i++){
         if(gad[i]>0){
            firstNum=gad[i];
            break;
         }
      }
      for(i=ArraySize(gad)-1;i!=0;i--){
         if(gad[i]>0){
            lastNum=gad[i];
            break;
         }
      }
      
      if(firstNum==0){                             //ran out of array
         gad[0]=0.01;
         gad[1]=0.02;
         gad[2]=0.03;
         firstNum=gad[0];
         lastNum=gad[2];
      }
      if(firstNum==lastNum)betSize=firstNum+0.01;  //bet size
      else betSize=firstNum+lastNum;               //use first and last num
      
      string p;
      for(i=0;i<ArraySize(gad);i++)StringAdd(p,gad[i]+",");
      Print(p);
      
      if(lD==0)lC=OrderSend(Symbol(),0,betSize,Ask,5,Ask-lS,Ask+lT);
      else lC=OrderSend(Symbol(),1,betSize,Bid,5,Bid+lS,Bid-lT);
      
   return 0;
}


/**************  TO DO **************
Shift back the array if there is 0 infront
*/