trigger activecon on Contact(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isBefore) { 
    system.debug('message trigger');
  } else if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      List<String> accountIdList = new List<String>();
      for (Contact contact : Trigger.new) {
        if (contact.AccountId != Trigger.newMap.get(contact.Id).AccountId) {
          accountIdList.add(contact.AccountId);
        }
      }
      List<Contact> relatedContacts = [
        SELECT Id, AccountId
        FROM Contact
        WHERE AccountId IN :accountIdList
      ];
      for (Contact contact : relatedContacts) {
        contact.addError(
          'You cannot insert or update a contact with a duplicate email.'
        );
      }
    }
  }
}