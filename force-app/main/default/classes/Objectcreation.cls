public with sharing class Objectcreation {
  public static void creatObj() {
    MetadataService.MetadataPort metadataservice = new MetadataService.MetadataPort();
    metadataservice.SessionHeader = new MetadataService.SessionHeader_element();
    metadataservice.SessionHeader.sessionId = UserInfo.getSessionId();
    List<MetadataService.Metadata> fields = new List<MetadataService.Metadata>();
    MetadataService.CustomObject customobject = new MetadataService.CustomObject();
    customobject.fullName = 'SalesCC_Order__c';
    customobject.label = 'SalesCC Order';
    customobject.pluralLabel = 'SalesCC Orders';
    customObject.nameField = new MetadataService.CustomField();
    customobject.nameField.type_x = 'Text';
    customobject.nameField.label = 'Order';
    customobject.deploymentStatus = 'Deployed';
    customObject.sharingModel = 'ReadWrite';
    fields.add(customobject); // Creating Custom Object

    fields.add(
      setFieldData(
        'Sales_Order__c.Sales_Order_Number__c',
        'Sales Order Number',
        'Text',
        10
      )
    ); //Creating Sales Order Number Field (Text, 10 characters)
    fields.add(setFieldData('Sales_Order__c.Date__c', 'Date', 'Date', 0)); //Creating Date (Date) Field
    fields.add(
      setFieldData('Sales_Order__c.Account_Name__c', 'Account Name', 'Text', 50)
    ); //Creating Account Name Field (Text, 50 characters)
    fields.add(
      setFieldData('Sales_Order__c.Contact_Name__c', 'Contact Name', 'Text', 50)
    ); //Creating Contact Name Field(Text, 50 characters)
    fields.add(
      setFieldData(
        'Sales_Order__c.Opportunity_Name__c',
        'Opportunity Name',
        'Text',
        100
      )
    ); //Creating Opportunity Name Field(Text, 100 characters)
    fields.add(
      setFieldDataForCurrencyField(
        'Sales_Order__c.Sales_Order_Amount__c',
        'Sales Order Amount',
        'Currency',
        18,
        0
      )
    ); //Creating Sales Order Amount Field (Currency)
    try {
      metadataservice.createMetadata(fields); // Creating Custom Fields
    } catch (DmlException e) {
      System.debug('The following exception has occurred: ' + e.getMessage());
    }
  }

  /*********************************************************************************************************
   * @methodname   setFieldData()
   * @description  This method is used to pass required parameters from base class to
   * 				Create 'Sales Order Number', 'Date', 'Opp Name', 'Acc Name', 'Contact Name' Fields
   /***********************************************************************************************************/
  public static MetadataService.CustomField setFieldData(
    string fName,
    string label,
    string fType,
    integer fLength
  ) {
    MetadataService.CustomField fieldMeta = new MetadataService.CustomField();
    fieldMeta.fullName = fName;
    fieldMeta.label = label;
    fieldMeta.type_x = fType;
    if (fLength != 0) {
      fieldMeta.length = fLength;
    }

    return fieldMeta;
  }

  /*********************************************************************************************************
   * @methodname   setFieldDataForCurrencyField()
   * @description  This method is used to pass required parameters from base class to
   * 				Create 'Currency' Field which needs extra parameters like precision and scale
   /***********************************************************************************************************/
  public static MetadataService.CustomField setFieldDataForCurrencyField(
    string fName,
    string label,
    string fCurrency,
    integer fprecision,
    integer fscale
  ) {
    MetadataService.CustomField fieldMeta = new MetadataService.CustomField();
    fieldMeta.fullName = fName;
    fieldMeta.label = label;
    fieldMeta.type_x = fCurrency;
    fieldMeta.scale = fscale;
    if (fprecision != 0) {
      fieldMeta.precision = fprecision;
    }
    return fieldMeta;
  }
}
