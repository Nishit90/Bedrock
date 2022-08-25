trigger OrderEventTrigger on Order_Event__e (after insert) {
   for(Order_Event__e oEvent : Trigger.new) {
       if(oEvent.Has_Shipped__c == true) {
           Task t = new Task();
           t.Priority ='Medium';
           t.Subject = 'Follow up on shipped order ' + oEvent.Order_Number__c;
           t.OwnerId = oEvent.CreatedById;
           insert t;
       }
   }
}