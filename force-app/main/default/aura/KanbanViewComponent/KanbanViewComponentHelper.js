({
    updateRecord : function(component, recId, pField, pVal) {
        
		let action= component.get("c.updatePickListValue");
        action.setParams({
            "recordId" : recId,
            "PicklistField" : pField,
            "pickListValue" : pVal
            
        });
        action.setCallback(this, function(response){
            var state = response.getState();
           
            if (state === "SUCCESS") {
                //this.picklistFieldChange(component, event);
                console.log(response.getReturnValue());
              	document.getElementById(recordId).style.backgroundColor = "#04844b";
                
            }
        });
        $A.enqueueAction(action);
                           
	},
})