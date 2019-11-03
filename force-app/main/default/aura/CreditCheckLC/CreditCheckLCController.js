({
	doInit : function(component, event, helper) {
		
	
	},

	handleSave: function(component,event,helper) {

		var action = component.get("c.openCaseExist");

		var recId = component.get("v.recordId");
		
		var creditOptionSelected = component.find("CreditCheck").get("v.value");
		action.setParams({
			accID: recId,
			CreditCheck: creditOptionSelected
		});
		
		action.setCallback(this, function(response) {
			var state = response.getState();
            
            if (state === "SUCCESS") {
				var caseExists = response.getReturnValue();
				if (caseExists == true) {
					var resultsToast = $A.get("e.force:showToast");
				
					resultsToast.setParams({
							"title": "Open case Already exists!",
							"message": "An open case has already been submitted and its pending resolutions."
					});
					
					resultsToast.fire();
					$A.get("e.force:closeQuickAction").fire();
				} else {
					var resultsToast = $A.get("e.force:showToast");
				
					resultsToast.setParams({
							"title": "Case was created on current account.",
							"message": "Case was added to the account" 
					});
					
					resultsToast.fire();
					$A.get("e.force:closeQuickAction").fire();
				}
            }
        
            else if (state === "INCOMPLETE") {
              
            }
     
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }			
			
		});
		$A.enqueueAction(action); 
		
		
	}

})