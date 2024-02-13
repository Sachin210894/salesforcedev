/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class Sobjectist {
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjectNames() {
        List<String> sObjectNames = new List<String>();

        // Retrieve all SObjects
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();

        // Loop through the map to get SObject names
        for (String objectName : globalDescribe.keySet()) {
            sObjectNames.add(objectName);
        }
System.debug('List of Object'+sObjectNames);
        return sObjectNames;
    }
}