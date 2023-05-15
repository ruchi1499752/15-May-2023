({
    /*
     * This finction defined column header
     * and calls getAccounts helper method for column data
     * editable:'true' will make the column editable
     * */
	doInit : function(component, event, helper) { 
        let thelabel = component.get("v.label");
        console.log("Button Label "+thelabel);
        /*component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Active', fieldName: 'Active__c', type: 'text'},
            {label: 'Custom Field', fieldName: 'My_Custom_Field__c', type: 'text'}
        ]);
        
        helper.getAccounts(component, helper);*/
    },
    
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getAccounts(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getAccounts(component, helper);
    },
    
  
})