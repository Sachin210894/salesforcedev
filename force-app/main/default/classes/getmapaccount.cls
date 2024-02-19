/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 02-19-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class getmapaccount {
  @AuraEnabled(cacheable=true)
  public static List<Account> fetchAccounts() {
    return [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingState,
        BillingPostalCode,
        BillingCountry
      FROM Account
      WHERE BillingCity != '' AND BillingCountry != ''
      LIMIT 10
    ];
  }
}
