({
    doInit : function(component, event, helper) {
        var action = component.get("c.getsAllObjects");
        action.setCallback(this, function(response){
            component.set("v.objList", response.getReturnValue());
        })
        $A.enqueueAction(action);
        /*var action = component.get("c.getCountries");
        action.setParams({fname :"ABC"});
        action.setCallback(this, function(response){
            //var allValues = response.getReturnValue();
            component.set("v.countries", response.getReturnValue());
        })
        $A.enqueueAction(action);*/
    },
    getString : function(component, event) {
        var action = component.get("c.getStringArray");
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
        var stringItems = response.getReturnValue();
        component.set("v.favoriteColors", stringItems);
        }
        });
        $A.enqueueAction(action);
        }
        
     
})