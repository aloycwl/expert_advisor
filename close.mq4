int start(){
   
   Print("1");
      
   for(int i=OrdersTotal()-1;i>=0;i--){
      Print(OrderTicket());
      if(!OrderClose(OrderTicket(),OrderLots(),OrderType()==OP_BUY?Bid:Ask,5))Print(GetLastError());
   }
    
      
      
      
   return 0;   

}