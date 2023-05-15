({
    doInit : function (component,event, helper) {
         
          
        var action = component.get('c.ObjectNames');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result);
                
                var arrayMapKeys = [];
                for(var key in result) {
                    arrayMapKeys.push({key: key, value: result[key]});
                    console.log(key);
                    console.log( result[key]);
                }
                component.set("v.availableObject", arrayMapKeys);
                console.log(component.get("v.availableObject"));
                
            }
        });
        $A.enqueueAction(action);
    },
    
    
    onSingleSelectChange: function(component,event,helper) {
       
        var selectCmp = component.find("InputSelectSingle");
        var select = selectCmp.get("v.value"); 
        component.set("v.selectedObject", select); 
        console.log(component.get("v.selectedObject"));
        
        var action = component.get('c.fields');
        
        action.setParams({ "selectedObject": component.get("v.selectedObject")});        
        action.setCallback(this, function(response){
             var state = response.getState();
            if (state == "SUCCESS") {
                
            var options = [];
            var fieldMap = response.getReturnValue(); 
            for (var k in fieldMap) {
                options.push({ value:k, label:fieldMap[k]});
            }
            component.set('v.options', options);
            console.log('optiopn----', component.get('v.options'));
            }
        });
        $A.enqueueAction(action);
    },
    
    getSelectedItems : function(component, event, helper) {  
        
        console.log('ordergetrecords ');
        helper.getRecord(component, event, helper);  
    }, 
    
    onSelectChange: function(component, event, helper) {  
        // var page = 1  
        var recordToDisply = component.find("recordSize").get("v.value");  
        console.log('recordToDisply --',recordToDisply);
        component.set('v.recordSizePerPage',recordToDisply);
        helper.getRecord(component, event, helper);  
    },
    
    sortColumn: function(component, event, helper) {
        helper.Sorting(component, event, helper);
    },
        
    
    previousPage: function(component, event, helper) {  
      var recordToDisply = component.find("recordSize").get("v.value"); 
        console.log('recordToDisply ', recordToDisply);
      component.set("v.page", component.get("v.page") - 1);  
      helper.getRecord(component, event, helper);  
    },  
    
    gotoFirstPage : function(component, event, helper) {  
     component.set("v.page",1);  
      var recordToDisply = component.find("recordSize").get("v.value");
        console.log('recordToDisply ', recordToDisply);
      helper.getRecord(component, event, helper);  
    },  
    
   gotoLastPage : function(component, event, helper) {  
      component.set("v.page",component.get("v.LastPage"));  
      var recordToDisply = component.find("recordSize").get("v.value"); 
      console.log('recordToDisply ', recordToDisply);
      helper.getRecord(component, event, helper);    
    }, 
    
    nextPage: function(component, event, helper) {   
      var recordToDisply = component.find("recordSize").get("v.value");  
      console.log('recordToDisply ', recordToDisply);
      component.set("v.page", component.get("v.page") + 1);  
         console.log('page ', component.get("v.page") + 1);
        
      helper.getRecord(component, event, helper);   
    }, 
    
     checkboxSelect: function(component, event, helper) {
         console.log('hello checkbox');
        // on each checkbox selection update the selected record count 
        var selectedRec = event.getSource().get("v.value");
        console.log('selectedRec',selectedRec);
        var getSelectedNumber = component.get("v.selectedCount");
             console.log('getSelectedNumber',getSelectedNumber);
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
            component.find("selectAllId").set("v.value", false);
        }
        component.set("v.selectedCount", getSelectedNumber);
        // if all checkboxes are checked then set header checkbox with true   
        if (getSelectedNumber == component.get("v.totalRecordsCount")) {
            component.find("selectAllId").set("v.value", true);
        }
    },
    
      showSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
     
    hideSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
})