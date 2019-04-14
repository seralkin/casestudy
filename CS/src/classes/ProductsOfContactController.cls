public class ProductsOfContactController {
	
    @AuraEnabled
    public static Contact loadRelatedContact(Id contactId){
        // Get contact of case
        Contact contact = new Contact();
        contact = [SELECT Id, Home_Country__c, Product__c FROM Contact WHERE Id=:contactId];
        return contact;
        
    }
    
}