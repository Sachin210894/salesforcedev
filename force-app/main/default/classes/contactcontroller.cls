public with sharing class contactcontroller {
    public contactcontroller() {

    }

    @AuraEnabled
    public static list<contact> searchcontacts(){
        return [Select Id, Name, Phone from Contact Limit 30];
    }
    
    @AuraEnabled
    public static list<contact> searchbyquery(string searchquery){
        string name = '%'+ searchquery + '%';
        return [Select Id, name, Phone from Contact where name Like:name Limit 30];
    }
    
    @AuraEnabled
    public static contact findbyid(string contactId){
        return[Select Id, name, phone, mobilephone, title, Account.Name from Contact Where Id=:contactId];
    }
}