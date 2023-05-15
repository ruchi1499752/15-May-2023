({
    fireComponentEvent : function(component, event, helper) {
        var cEvent = component.getEvent("cmpEvent");
        cEvent.setParams({
            "message" : "A Component Event Fired"
        });
        cEvent.fire();

    },
    doInit : function(component, event, helper) {
        console.log("Call");
        let data = component.get("v.childValue");
        console.log(data);
      //  let data = JSON.parse(component.get("v.childValue"));
        console.log(component.get("v.msg"));
        console.log(data.objectName);
        
    }    

})