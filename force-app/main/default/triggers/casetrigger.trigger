trigger casetrigger on Case (after insert, after update) {
        Set<Id> conIds = new Set<Id>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for (Case c: trigger.new) {
            conIds.add(c.OwnerId);
        }
        Map<Id, user> conMap = new Map<Id, user>([SELECT Id, Name, Email, Phone, MobilePhone FROM user WHERE Id In :conIds]);
        
        
        for (Case c : [SELECT Id, OwnerId, Status,Email__c, CaseNumber,	 Account.Name FROM Case WHERE Id IN:trigger.new]) {
            if (c.status == 'Response Received') {
                User relatedCaseContact = conMap.get(c.OwnerId);
                system.debug('Mydebug' + c.Account.Name + relatedCaseContact.name + relatedCaseContact.email + relatedCaseContact.Phone + relatedCaseContact.MobilePhone);
                
                Messaging.SingleEmailMessage CaseNotificationmail = new Messaging.SingleEmailMessage();  
                CaseNotificationmail.setToAddresses(new List<String> { c.Email__c });
                CaseNotificationmail.setReplyTo('sachin.shah@volansys.com');
                CaseNotificationmail.setSenderDisplayName('Salesforce');            
                
                CaseNotificationmail.setSubject(' Case Status updation : ' + 'Changed to ' + c.status + '. Case Number:' + c.CaseNumber);
                CaseNotificationmail.setHtmlBody(
                    'Your case Status for Case Number: ' + c.CaseNumber +' has been updated'+
                    'owner Name = '+relatedCaseContact.name+'<p/>'+
                    'owner Email= '+c.Email__c+'<p/>'+
                    'Account Name= '+c.Account.Name+'<p/>'); 
                mails.add(CaseNotificationmail); 
            }
        }
        Messaging.sendEmail(mails);
    }