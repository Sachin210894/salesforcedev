/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 03-13-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public without sharing class Sobjectist {
  @AuraEnabled(cacheable=true)
  public static List<String> getSObjectNames() {
    List<String> sObjectNames = new List<String>();

    // Retrieve all SObjects
    Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
    System.debug('globalDescribe' + globalDescribe);
    System.debug('globalDescribe' + globalDescribe.keySet());

    // Loop through the map to get SObject names
    for (Schema.SObjectType objectName : globalDescribe.values()) {
      sObjectNames.add(String.valueof(objectName));
    }
    System.debug('List of Object' + sObjectNames);
    return sObjectNames;
  }
}
