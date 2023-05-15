({
	handleClick : function(component, event, helper) {
        console.log("Hello");
		var btnClick = event.getSource();
        
        var btnMessage = btnClick.get("v.label");
        component.set("v.message", btnMessage);
        console.log("Hello");
        console.log(btnMessage);
	},
    
     one : function(component, event, helper) {
       
       var a = event.getSource().getLocalId();  
       component.set("v.whichButton", a);  
	}
})