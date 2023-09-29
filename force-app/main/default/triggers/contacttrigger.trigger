trigger contacttrigger on Contact (after insert,after  update) {
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
    
}