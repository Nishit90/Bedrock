trigger OppTrigger on Opportunity (after update, after insert, before update, before insert) {

    system.debug('trigger: '+trigger.new);
    system.debug('triggerOLD: '+trigger.oldMap);
    String res = trigger.new[0].TextField__c;
}