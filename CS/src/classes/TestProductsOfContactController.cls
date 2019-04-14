@IsTest
public class TestProductsOfContactController {
    
    static testMethod void myUnitTest() {
        createSampleData();
    }
    
    private static void createSampleData(){
        
       List<Product2> products = new List<Product2>{
            new Product2(Name = 'Standard', isActive = true),
            new Product2(Name = 'Black', isActive = true),
            new Product2(Name = 'Metal', isActive = true)
       };
       insert products;
        
       List<Country__c> countries = new List<Country__c>{
            new Country__c(Name = 'DE'),
            new Country__c(Name = 'FR'),
            new Country__c(Name = 'ES'),
            new Country__c(Name = 'IT'),
            new Country__c(Name = 'UK')      
        };
        insert countries;
        
        // Test data for Standard and Black (Cost per Calendar Month and ATM Fee in other currencies)
        List<Country_Product__c> countryProducts = new List<Country_Product__c>{
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(0).Id, Fee__c = '€ 0', Product_Family__c = 'Cost per Calendar Month' ),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(1).Id, Fee__c = '€ 0', Product_Family__c = 'Cost per Calendar Month' ),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(2).Id, Fee__c = '€ 0', Product_Family__c = 'Cost per Calendar Month' ),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(3).Id, Fee__c = '€ 0', Product_Family__c = 'Cost per Calendar Month' ),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(4).Id, Fee__c = '£ 0', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(0).Id, Fee__c = '€ 9,90', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(1).Id, Fee__c = '€ 9,90', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(2).Id, Fee__c = '€ 9,90', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(3).Id, Fee__c = '€ 9,90', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(4).Id, Fee__c = 'N/a', Product_Family__c = 'Cost per Calendar Month'),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(0).Id, Fee__c = '1.7%', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(1).Id, Fee__c = '1.7%', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(2).Id, Fee__c = '1.7%', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(3).Id, Fee__c = '1.7%', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(0).Id, Country__c = countries.get(4).Id, Fee__c = '1.7%', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(0).Id, Fee__c = 'Free', Product_Family__c = 'ATM Fee in other currencies'),    
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(1).Id, Fee__c = 'Free', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(2).Id, Fee__c = 'Free', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(3).Id, Fee__c = 'Free', Product_Family__c = 'ATM Fee in other currencies'),
            new Country_Product__c(Product__c = products.get(1).Id, Country__c = countries.get(4).Id, Fee__c = 'Free', Product_Family__c = 'ATM Fee in other currencies')
        };
        insert countryProducts;
        
        system.debug('cascas' + countryProducts);
        
        Contact contact = new Contact();
        contact.FirstName='First Name';
        contact.LastName = 'Last Name ';
        contact.Email = 'test@test.com';
        contact.Phone = '34343434';
        contact.Product__c = products.get(0).Id;
        contact.Home_Country__c = countries.get(0).Id;
        contact.Language__c = 'DE';
        insert contact;
        
        Case caseTest = new Case();
        caseTest.Status = 'New';
        caseTest.Origin = 'Phone';
        caseTest.ContactId = contact.Id;
        insert caseTest;
        
        Contact contactResult = ProductsOfContactController.loadRelatedContact(caseTest.ContactId);
        List<Country_Product__c> countryProductResult = DisplayProductsController.loadProducts(contactResult);
        system.debug('contact' + contact);
        system.debug('contactResult' + contactResult);
        system.debug('countryProductResult' + countryProductResult);
        system.debug('countryProducts' + countryProducts);
        if(contactResult!=null)
      	  System.assertEquals(contactResult.Id,contact.Id);
   		if(!countryProductResult.isEmpty())
          System.assertEquals(countryProductResult.get(0).Id, countryProducts.get(0).Id);
        
        
        
    }

}