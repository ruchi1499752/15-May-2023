({
    getRecord : function(component, event, helper) {
         helper.showSpinner(component);
        console.log('herliug');
        var abc =  component.get("v.selectedFields");
        component.set('v.columns', abc);
        var col = component.get('v.columns');
        console.log('abc---',abc);
        var obje = component.get("v.selectedObject");
        console.log('obje--', obje);
        var sortfield = component.get("v.selectedTabsoft");  
       var order = component.get("v.isAsc");
      console.log('sortfield ', sortfield);
       console.log('order ', order);
          var sizeOfRecord = component.get("v.recordSizePerPage");
           console.log('sizeOfRecord ', sizeOfRecord);
          var pageNumber = component.get("v.page");
           console.log('pageNumber ', pageNumber);
        var action = component.get('c.getfields');
        action.setParams({
            ObjName: obje,
            selectedfields: abc,
            pageNumber: pageNumber,
            recordToDisply: sizeOfRecord,
            sortField: sortfield,
            isAsc: order
        });
 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                var result = response.getReturnValue();
                console.log('result-----',result);
                  helper.hideSpinner(component);
                
               var objectValue = result.sObjectData;
               
               var fieldList = result.fieldList;
                
                var pagination = result.pagination;
                var paginationValue = pagination['0'];
                console.log('paginationValue----',paginationValue);
                component.set("v.page", paginationValue.page); 
                console.log('page  --', paginationValue.page);
                component.set("v.total", paginationValue.total);
                console.log('total  --', paginationValue.total);
                component.set("v.LastPage", Math.ceil(paginationValue.total / sizeOfRecord));  
                console.log('LastPage  --', Math.ceil(paginationValue.total / sizeOfRecord));
                 
                var allrecordlist = Object.keys(objectValue[0]);
                console.log('objectValue----',objectValue);
                console.log('allrecordlist----',allrecordlist);
              
                var pageination = result.pagination;
                console.log('fieldList---------',fieldList);
                console.log('pageination----',pageination);
                var objlist = [];
              
                        for(var j=0; j < objectValue.length; j++) {
                           var recordlist =[];
                           
                            for (var i=0; i <  fieldList.length; i++) {
                              
                                recordlist.push(objectValue[j][fieldList[i].apiName]);
                               //console.log('recordlist',recordlist);
                                
                            }
                           objlist.push(recordlist);
                        }
                    
                 console.log('recordlist',recordlist);
                 console.log('objlist',objlist);
                 component.set('v.records',objlist);
                 var rec =component.get('v.records');
                 console.log('rec---',rec);
                 
                var sObjectDataTableHeader = [];
                 //Create table Header
                for (var i=0; i <  fieldList.length; i++) {
                    sObjectDataTableHeader.push({key: fieldList[i].label , value: fieldList[i].apiName});
                }
                console.log('sObjectDataTableHeader',sObjectDataTableHeader);
                component.set('v.header',sObjectDataTableHeader);
        }
        });
        $A.enqueueAction(action);
    }, 
    
    
     Sorting : function(component, event, helper) {
         
     var fieldkeyValue = event.currentTarget.dataset.recordId;
        console.log('fieldkeyValue',fieldkeyValue);
        var sortFieldName = fieldkeyValue.substr(fieldkeyValue.lastIndexOf(",")+1);
        console.log('sortFieldName',sortFieldName);
        
        component.set("v.selectedTabsoft", sortFieldName);  
        console.log('chaliuuu');
        var currentDir = component.get("v.arrowDirection"); 
        console.log('currentDir --', currentDir);
        if (currentDir == 'arrowdown') {  
            console.log('if');
            component.set("v.arrowDirection", 'arrowup');  
            component.set("v.isAsc", true);  
        } else {  
            console.log('else');
            component.set("v.arrowDirection", 'arrowdown');  
            component.set("v.isAsc", false);  
        }  
        helper.getRecord(component, event, helper);  
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