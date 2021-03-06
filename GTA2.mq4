extern double Lots=0.01,LotExponent=1,TakeProfit=50;
extern short PipStep=180;
bool gb_rhl;
char gi_hd=2,gi_5d,gi_6d;
int ihl,i15,i16;

int start(){
   if(ihl!=Time[0])
     {
      ihl=Time[0];
      bool c;
      char gi=LorC(0,false);
      double dP=PipStep*(gi+1)*Point,dL=LorC();
      if(gi==0)
        {
         gi_hd=2;
         gb_rhl=false;
        }

      if(gi==0||(gi_hd==0&&dL-Ask>=dP)||(gi_hd==1&&Bid-dL>=dP)||gb_rhl)
        {
         if((gi==0&&iHigh(Symbol(),0,1)>iLow(Symbol(),0,2)&&iRSI(0,60,14,0,1)>30)||gi_hd==1)
           {
            c=OrderSend(Symbol(),1,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Bid,5,0,0);
            gi_hd=1;
           }
         else
           {
            c=OrderSend(Symbol(),0,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Ask,5,0,0);
            gi_hd=0;
           }
         modify();
        }
      /**/if(i15!=Time[0])
        {
         i15=Time[0];
         gi=LorC(1,false);
         dL=LorC(1);
         gi_5d=gi==0?0:gi_5d;
         if(gi==0||(gi_5d==1&&dL-Ask>=dP)||(gi_5d==2&&Bid-dL>=dP))
           {
            if(gi_5d==2||(iClose(Symbol(),0,2)>iClose(Symbol(),0,1)&&gi==0))
              {
               c=OrderSend(Symbol(),1,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Bid,5,0,0,"",1);
               gi_5d=2;
              }
            else
              {
               c=OrderSend(Symbol(),0,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Ask,5,0,0,"",1);
               gi_5d=1;
              }
            modify(1);
           }
        }
      if(i16!=Time[0])
        {
         i16=Time[0];
         gi=LorC(2,false);
         dL=LorC(2);
         gi_6d=gi==0?0:gi_6d;
         if(gi==0||(gi_6d==1&&dL-Ask>=dP)||(gi_6d==2&&Bid-dL>=dP))
           {
            if(gi_6d==2||(gi==0&&iClose(Symbol(),0,2)>iClose(Symbol(),0,1)&&iRSI(0,60,14,0,1)>30))
              {
               c=OrderSend(Symbol(),1,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Bid,5,0,0,"",2);
               gi_6d=2;
              }
            else
              {
               c=OrderSend(Symbol(),0,NormalizeDouble(Lots*MathPow(LotExponent,gi),2),Ask,5,0,0,"",2);
               gi_6d=1;
              }
            modify(2);
           }
        }/**/
     }
   return 0;
  }

double LorC(char a=0, bool b=true){
   char cFC,i;
   bool c; //Last Price or Count
   for(i=OrdersTotal()-1; i>=0; i--)
     {
      c=OrderSelect(i,0);
      if(OrderSymbol()==Symbol()&&OrderMagicNumber()==a)
         if(!b)
            cFC++;
         else
            return OrderOpenPrice();
     }
   return cFC;
  }

void modify(char a=0){
   double dP,dO;
   char i;
   bool c;
   for(i=OrdersTotal()-1; i>=0; i--)
     {
      c=OrderSelect(i,0);
      if(OrderSymbol()==Symbol()&&OrderMagicNumber()==a)
        {
         dP+=OrderOpenPrice()*OrderLots();
         dO+=OrderLots();
        }
     }
   dP=NormalizeDouble(dP/dO,Digits);
   for(i=OrdersTotal()-1; i>=0; i--)
     {
      c=OrderSelect(i,0);
      if(OrderSymbol()==Symbol()&&OrderMagicNumber()==a)
         c=OrderModify(OrderTicket(),dP,OrderStopLoss(),OrderType()==0?dP+TakeProfit*Point:dP-TakeProfit*Point,0);
     }
  }