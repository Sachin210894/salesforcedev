/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 01-16-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public class AccContactcreation {
  public static String accmethod(Set<ID> acc_ID) {
    Account acc = [
      SELECT id, Name, Count_of_Contact__c
      FROM Account
      WHERE ID IN :acc_ID
    ];
    List<Contact> lstcont = new List<Contact>();
    Integer numberOfContacts = [
      SELECT COUNT()
      FROM Contact
      WHERE AccountId = :acc.ID
    ];
    Contact con = new contact();

    if (numberOfContacts >= acc.Count_of_Contact__c) {
      con.AccountId = acc.ID;
      con.LastName = 'demo' + numberOfContacts;
      con.Stage__c = 'pending';
    } else {
      // Contact con = new contact();
      con.AccountId = acc.ID;
      con.LastName = 'demo' + numberOfContacts;
      con.Stage__c = 'open';
    }

    lstcont.add(con);

    system.debug('List created' + lstcont);
    if (lstcont.size() > 0) {
      insert lstcont;
    }

    return null;
  }

  public static String accmethod2(Set<ID> acc_ID2) {
    List<contact> conupdate = new List<contact>();
    Account acc = [
      SELECT id, Name, Count_of_Contact__c
      FROM Account
      WHERE ID IN :acc_ID2
    ];

    //update part
    Integer numberOfContacts2 = [
      SELECT COUNT()
      FROM Contact
      WHERE AccountId = :acc_ID2 AND Stage__c = 'Closed'
    ];
    List<Contact> newconlist = [
      SELECT ID, Name, Stage__c
      FROM Contact
      WHERE AccountId = :acc_ID2 AND Stage__c = 'Pending'
    ];
    Integer newvalue =
      numberOfContacts2 - Integer.valueOf(acc.Count_of_Contact__c);
    //update account count value
    acc.Count_of_Contact__c = newvalue;

    System.debug('new value' + acc.Count_of_Contact__c);
    update acc;

    //update contact
    if (newconlist.size() > 0) {
      for (Contact concall : newconlist) {
        concall.Stage__c = ' Open';
        conupdate.add(concall);
      }
    }
    update conupdate;
    return null;
  }
}
