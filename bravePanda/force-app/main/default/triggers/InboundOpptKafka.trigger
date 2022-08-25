// Trigger for catching Inbound_Oppt events.
trigger InboundOpptKafka on Inbound_Oppt__e (after insert) {    
    // List to hold all cases to be created.
    List<Case> cases = new List<Case>();
    
    // Get user Id for case owner. Replace username value with a valid value.
    User adminUser = [SELECT Id FROM User WHERE Username='nbabaria@demoorg.com'];
       
    // Iterate through each notification.
    for (Inbound_Oppt__e event : Trigger.New) {
        System.debug('Printer model: ' + event.Plan_Id__c);
        
            // Create Case to order new printer cartridge.
            Case cs = new Case();
            cs.Priority = 'Medium';
            cs.Subject = 'Order new ink cartridge for SN ' + event.Plan_Id__c;
            // Set case owner ID so it is not set to the Automated Process entity.
            cs.OwnerId = adminUser.Id;
            cases.add(cs);
        
    }
    
    // Insert all cases in the list.
    if (cases.size() > 0) {
        insert cases;
    }
}