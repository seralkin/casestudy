public class DisplayProductsController {
    
    @AuraEnabled
    public static List<Country_Product__c> loadProducts(Contact contact){
        // retrieve matching product information
        List<Country_Product__c> productList = new List<Country_Product__c>();
        productList = [SELECT Id, Country__c, Product__c, Fee__c, Product_Family__c 
                       FROM Country_Product__c WHERE Product__c =:contact.Product__c AND Country__c =: contact.Home_Country__c];
        return productList;
        
    }
    
}