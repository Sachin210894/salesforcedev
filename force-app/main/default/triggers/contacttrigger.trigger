trigger contacttrigger on Contact (before insert, before update) {
    Set<Id> accountIds = new Set<Id>();
    Map<Id, Integer> accountContactCounts = new Map<Id, Integer>();
    
    // Step 1: Collect Account IDs and their respective Contact counts
    for (Contact newContact : Trigger.new) {
        if (newContact.AccountId != null) {
            accountIds.add(newContact.AccountId);
        }
    }
    
    // Query for Account Contact_count values
    for (AggregateResult aggregate : [SELECT AccountId, COUNT(Id) contactCount
                                     FROM Contact
                                     WHERE AccountId IN :accountIds
                                     GROUP BY AccountId]) {
        Id accountId = (Id)aggregate.get('AccountId');
        Integer contactCount = (Integer)aggregate.get('contactCount');
        accountContactCounts.put(accountId, contactCount);
    }
    
    // Step 2: Update Contact stages based on Contact_count
    for (Contact newContact : Trigger.new) {
        if (newContact.AccountId != null) {
            Integer contactCount = accountContactCounts.get(newContact.AccountId);
            Integer contactCountThreshold = Integer.valueOf(newContact.Account.Count_of_Contact__c);
            system.debug('display ===>'+contactCount +'threshold' +contactCountThreshold );
            if (contactCount < contactCountThreshold) {
                newContact.Stage__c = 'Open';
            } else {
                newContact.Stage__c = 'Pending';
            }
        }
    }
}


/*trigger contacttrigger on Contact (after insert,after  update) {
    Set<ID> accid = new Set<ID>();
    
    if (trigger.isAfter && trigger.IsInsert) {
        if(RecursiveTriggerHandler.isFirstTime){
            RecursiveTriggerHandler.isFirstTime = false;
            for(Contact con: Trigger.new)
            {
                accid.add(con.AccountId);
            }
            AccContactcreation.accmethod(accid);
        }
    }
    
    if (trigger.isAfter && trigger.IsUpdate) {
        //ID conID;
        System.debug('RecursiveTriggerHandler.isFirstTime==>'+RecursiveTriggerHandler.isFirstTime);
        if(RecursiveTriggerHandler.isFirstTime){
            RecursiveTriggerHandler.isFirstTime = false;
            for(Contact con: Trigger.new)
            {
                accid.add(con.AccountId);
                //conID= con.ID;
            }
            
            AccContactcreation.accmethod2(accid);
        }
    }
    
}*/