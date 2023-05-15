({
	handleSuccess : function(component, event, helper) {
        component.find("toastCmp").showToastModel("This is success toast.", "success");
	},
    
    handleWarning : function(component, event, helper) {
        component.find("toastCmp").showToastModel("This is warning toast.", "warning");
	},
    
    handleError : function(component, event, helper) {
        component.find("toastCmp").showToastModel("This is error toast.", "error");
	}
})