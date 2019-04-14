({
	fetchContact : function(component, event, helper) {
        // Fetch related contact from server
		var action = component.get("c.loadRelatedContact");
        var contactId = component.get("v.record").ContactId;
        action.setParams({
            contactId: contactId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') { 
                var contact = response.getReturnValue();
                console.log("*** CONTACT" + contact);
                component.set("v.contactRecord",contact);
            }
            else {   
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(action);
           
	}
})