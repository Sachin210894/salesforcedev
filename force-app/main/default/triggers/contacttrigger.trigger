trigger contacttrigger on Contact (after insert,after  update) {
    Set<ID> accid = new Set<ID>();
    
    if (trigger.isAfter && trigger.IsInsert) {
        
        for(Contact con: Trigger.new)
        {
            accid.add(con.AccountId);
        }
        AccContactcreation.accmethod(accid);
        
    }
    
    if (trigger.isAfter && trigger.IsUpdate) {
        
        for(Contact con: Trigger.new)
        {
            accid.add(con.AccountId);
        }
        
        AccContactcreation.accmethod2(accid);
        
    }
    
}