trigger ContactTrigger on Contact(before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if (Trigger.isBefore) {
        
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            List<String> licenseIds = new List<String>();
            for (Contact c : Trigger.new) {
                if (c.ID != null) {
                    licenseIds.add(c.ID);
                }
            }
            if (licenseIds.size() > 0) {
                List<Contact> contacts = [SELECT Id, FROM Contact WHERE License_Id__c IN :licenseIds];
                Map<String, Contact> licenseIdToContactMap = new Map<String, Contact>();
                for (Contact c : contacts) {
                    licenseIdToContactMap.put(c.License_Id__c, c);
                }
                for (Contact c : Trigger.new) {
                    if (licenseIdToContactMap.containsKey(c.License_Id__c)) {
                        c.addError('Contact with the same License ID already exists.');
                    }
                }
            }
        }
    }
}
            