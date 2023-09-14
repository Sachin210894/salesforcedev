public class OwnersUpdateForAccountBatch implements Database.Batchable<sObject>, Database.Stateful {
    // Create an integer which would keep track of the total number of accounts which have updated
    public Integer numberOfAccountsProcessed=0;
    private String oldUserId;
    private String newUserId;
    
    // Constructor which takes the argument as UserIds.
    // oldUserId: Id of the User/AccountOwner which needs to be changed for accounts
    // newUserId: Id of the User/AccountOwner to which accounts need to be updated
    public OwnersUpdateForAccountBatch(String oldUserId, String newUserId) {
        this.oldUserId = oldUserId;
        this.newUserId = newUserId;
    }
    
    // Start method which would query all the accounts for oldUserId
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id From Account Where OwnerId= \'' + oldUserId + '\'');
    }
    
    // Update operation on AccountOwner/OwnerId field for all the queried accounts
    public void execute(Database.BatchableContext bc, List<Account> listOfAccounts) {
        for(Account acc : listOfAccounts) {
            acc.OwnerId = newUserId;
            numberOfAccountsProcessed++;
        }
        update listOfAccounts;
    }
    
    // Send email to the new user
    public void finish(Database.BatchableContext bc) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String> {newUserId});
        email.setSubject('Total Accounts Updated');
        email.setPlainTextBody('Below is the total number of Accounts whose new Owner is you:\n' + numberOfAccountsProcessed);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {email});
    }
}