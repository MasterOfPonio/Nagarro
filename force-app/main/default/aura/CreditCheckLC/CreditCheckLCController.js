({
	doInit : function(component, event, helper) {
		var action = cmp.get("c.CreateNewCase");
        
        action.setCallBack(this, function(response) {
        	var success = response.getReturnValue();
        });
        $A.enqueueAction(action);
	}
})