({
	doInit : function(component, event, helper) {
        let isPrevious = false;
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        let recordSize = component.get("v.pageSize");
        
        // call apex method for fetch total number of records
        let action = component.get("c.getTotalRecords");
        /*action.setParams({
            'objs' : obj
        })*/
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                component.set("v.totalSize", response.getReturnValue());
				let totalRecords = component.get("v.totalSize");
                let total = Math.ceil(totalRecords / recordSize);
                component.set("v.totalPages",total);

                let query = 'SELECT ' + flds + ' FROM ' + obj + ' ORDER BY ID ASC LIMIT ' + recordSize;
				helper.fetchRecords(component, event, flds, query, isPrevious);

        	}else{
                console.log("Error");
            }
        });
        $A.enqueueAction(action);
    },
   
    // method for select record per page dropdown list selection
        onSelectChange : function(component, event, helper){
        let isPrevious = false;
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
    	var selected = component.find("recordPageSize").get("v.value");
        
        component.set('v.pageSize', selected);
        component.set("v.page",1);

        
        let query = 'SELECT ' + flds + ' FROM ' + obj + ' ORDER BY ID LIMIT ' + selected;
        helper.fetchRecords(component,event,flds, query,isPrevious);

        // 1 of Total Pages
        let totalRecords = component.get("v.totalSize");
        let pageSize = component.get("v.pageSize");
        let total = Math.ceil(totalRecords / pageSize);     //use Math.ceil() to Round a number upward to its nearest integer
        component.set("v.totalPages",total);
        helper.disableButton(component,component.get("v.totalPages"));
         
       

    },
    firstButton : function(component, event, helper){
        component.set("v.spinner", true);
     	let isPrevious = false;
        component.set("v.page", 1);
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        //let pageNumber = component.get("v.page");
        let recordSize = component.get("v.pageSize");
		let query = 'SELECT ' + flds + ' FROM ' + obj + ' ORDER BY ID ASC LIMIT ' + recordSize;

        helper.fetchRecords(component,event,flds, query,isPrevious);
        helper.disableButton(component,component.get("v.totalPages"));
        component.set("v.spinner", false);
    },  
    previousButton : function(component, event, helper){
        component.set("v.spinner", true);
        let isPrevious = true;
        component.set("v.page", component.get("v.page")-1);
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        let recordSize = component.get("v.pageSize");
        //let pageNumber = component.get("v.page");
		let query = 'SELECT ' + flds + ' FROM ' + obj + ' WHERE ID < \''+ component.get("v.firstRec") + '\' ORDER BY ID DESC LIMIT ' + recordSize ;
        console.log(query);
        helper.fetchRecords(component,event, flds, query, isPrevious);
        helper.disableButton(component,component.get("v.totalPages"));
	},
    nextButton : function(component, event, helper){
        component.set("v.spinner", true);
        let isPrevious = false;
        component.set("v.hasPrevious", false);
        component.set("v.page", component.get("v.page")+1);
          
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        //let pageNumber = component.get("v.page");
        let recordSize = component.get("v.pageSize");

        let query = 'SELECT ' + flds + ' FROM ' + obj + ' WHERE ID > \''+ component.get("v.lastRec") + '\' ORDER BY ID ASC LIMIT ' + recordSize ;
        helper.fetchRecords(component,event, flds, query,isPrevious);
        helper.disableButton(component,component.get("v.totalPages"));
       

    },
    lastButton :function(component, event, helper){
     
        let isPrevious = false;
        let total = component.get("v.totalPages"); 
        component.set("v.page",total);

        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        let pageNumber = component.get("v.page");
        let recordSize = component.get("v.pageSize");
        let totalRec = component.get("v.totalSize");

       
        console.log("Total REcords :" , totalRec);
        console.log("pagesize :" , recordSize);
       let remainingRec = totalRec % recordSize;
       console.log("Remaining Rec " + remainingRec);

       let query = 'SELECT ' + flds + ' FROM ' + obj + ' ORDER BY ID DESC LIMIT ' + remainingRec;
       helper.fetchRecords(component,event,flds, query,isPrevious);
       helper.disableButton(component,component.get("v.totalPages"));
       
       

	},
    sortColumn :function(component, event, helper){
        //let flds = component.get('v.response.fields');
        var fieldName = event.getParam('fieldName');	//Returns the value of an event’s parameter.
        console.log(fieldName);
        var sortDirection = event.getParam('sortDirection');
        console.log("sort Direction : " + sortDirection);
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);

          
    },

    selectedRecord : function(component, event, helper){
        var pageIds = [];   
        component.get("v.record").forEach(function(element) {
            pageIds.push(element.Id); 
        });
        var tempIds = [];
        console.log('v.selected ::: '+component.get("v.selected"));
        console.log('Selected !!!!!!!!!!!!!!', component.get("v.selected"));
        
        var selectedRows = event.getParam('selectedRows');
        console.log("AllSelectedRows : "  + JSON.stringify(selectedRows));
        
		var selectRecordIds = component.get("v.selectedRecordIds");
        console.log('Selected Record Ids :', selectRecordIds);
        
        if(selectedRows != null && selectedRows != undefined && selectedRows.length > 0) {
            selectedRows.forEach( function(element) {
                tempIds.push(element.Id);
                if(!selectRecordIds.includes(element.Id))
             	 	selectRecordIds.push(element.Id); 
            });
        }
        console.log('pageIds : '+pageIds);
        console.log('TempIds : '+tempIds);
        
        pageIds.forEach( function(element) {
            if(selectRecordIds.includes(element) && !tempIds.includes(element)) {
                selectRecordIds.splice(selectRecordIds.indexOf(element),1);
            } 
        });
        console.log(' selectRecordIds : ' + selectRecordIds);
        component.set("v.",selectRecordIds);
    },
    
    /*buttonClick : function(component, event, helper){
        var source =  event.getSource();
        //alert(clickedBtn);
        if(source.getLocalId() == 'firstButton'){
           helper.first(component,event,helper);

        }else if(source.getLocalId() == 'previousButton'){
            helper.previous(component,event,helper);
        }
        else if(source.getLocalId() == 'nextButton'){
            helper.next(component,event,helper);

        }else if(source.getLocalId() == 'lastButton'){
            helper.last(component,event,helper);
        } 

    }*/
       
})