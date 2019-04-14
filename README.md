# casestudy

Case Study for interview process.

For the case 1 :
* Created Language__c (Picklist) and Survey_Date__c (Date/Time) fields on Contact.
* Created SendEmailBatch Class. 
    This class does the following;
     * Retrieves Contacts which has Survey_Date__c less than now.
     * Sends email to those contacts in different languages according to Language__c value on Contact.
     * Updates Survey_Date__c of processed Contacts to null.
* Created ScheduleSendEmailBatch class to schedule this class once in a day at 23:59. 
This class will invoke SendEmilBatch class and make it process 200 records at a time.
* Created Test Class for SchedulerClass (TestScheduleSendEmailBatch).


For the Case 2:
* Created Country__c custom object to keep country records (DE, FR, ES, IT, UK).
* Used standard Product2 object to keep product records (Standard, Black and Metal).
* Created County_Product__c junction object to keep Product, Country, Fee and Product Family information. 
    See URL for sample screen 
      https://ibb.co/RzGnyVh
      https://ibb.co/NtG3tfZ
* Created Home_Country__c field on account object.
* Created ProductsOfContact Lightning Component and its apex controller class (ProductOfContactController).
* Created DisplayProducts Lightning Component and its apex controller class (DisplayProductsController).
     Those two components do the following;
     * ProductsOfContact retrieve Contact information from Case and pass it to the DisplayProducts component.
     * DisplayProduct component retrieves matching product information according to Home_Country__c and Product values on contact.
* Created test class for their apex controller classes and created some sample data in them (TestProductOfContactController and TestDisplayProductsController)
* Added ProductsOfContact to the Case Page Layout

Screenshot for the ProductsOfContact component that works on Case Page layout can be found below.
![case](https://user-images.githubusercontent.com/49560853/56093059-b2f12c00-5ecc-11e9-9265-172d1f66314e.png)
