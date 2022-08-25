global with sharing class PLG_FetchOppLineItems {
    global class opptWrapper {
        @InvocableVariable(required=true)
        global String opptId;
    }
   
    @InvocableMethod
    global static void fetchLineItems(opptWrapper[] oppts) {
        opptWrapper oppt = oppts[0];
        Opportunity opp = [Select Id,Name, (Select Id, OpportunityId, Description from OpportunityLineItems) From Opportunity where Id =: oppt.opptId];
        
        String jsonString = JSON.serialize(opp);
        System.debug('jsonString: '+jsonString);
        createPlatformEvent(opp, jsonString);
     }
   
    global static void createPlatformEvent(Opportunity opp, String jsonString) {
        // Create an instance of the event and store it in the newsEvent variable
		Opportunity_Sync__e oppEvent = new Opportunity_Sync__e(
           Opportunity_Details__c = jsonString,
           Opportunity_Name__c=opp.Name);
          
        // Call method to publish events
        Database.SaveResult sr = EventBus.publish(oppEvent);
        String eventId = EventBus.getOperationId(sr);
        System.debug('eventId: '+eventId);
        // Inspect publishing result
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' +
                             err.getStatusCode() +
                             ' - ' +
                             err.getMessage());
            }
        }
    }
}