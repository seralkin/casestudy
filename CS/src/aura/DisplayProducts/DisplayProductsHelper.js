({
	fetchProducts : function(component, event, helper) {
        // Fetch matching products
		var action = component.get("c.loadProducts");
        var contact = component.get("v.contactRecord");
        action.setParams({
            contact: contact
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') { 
                var productList = response.getReturnValue();
                component.set("v.products",productList);
            }
            else {   
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(action);
          
	}
})