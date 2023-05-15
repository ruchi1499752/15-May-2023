({
    //for fetching records from apex controller
   
	fetchRecords : function(component,event,flds, query, isPrevious) {
        //let s = component.get("v.tempList");
        //console.log('fetch record id : ' , s);
        
        var setRows = []; 
        
        let action = component.get("c.getRecords");
        action.setParams(
            {'qry' : query}
        );
        action.setCallback(this, function(response){
            if(response.getState()== 'SUCCESS'){
                console.log(JSON.stringify(response.getReturnValue()));
                let result = response.getReturnValue();
                let rec = component.get("v.record");
                let firstId = result[0].Id;
                let lastId = result[result.length-1].Id;
                console.log(' first : ' + firstId);
                console.log(' last : ' + lastId);
                component.set("v.record", response.getReturnValue());
                // component.set("v.isNavigate", false);
                component.set("v.selected", component.get("v.selectedRecordIds"));
                
                
                let displayData = [];
                flds.forEach(fldsValue => {  
                    displayData.push({label : fldsValue, fieldName : fldsValue, sortable : true});
                });    
                component.set("v.field", displayData);

                /*let s = component.get("v.tempList");
                console.log("fetch record : " , s);
                component.set("v.selected", s);   
                console.log("fetch record value : " , component.get("v.selected"));*/
               /* let s = component.get("v.selected");
                for(let i= 0; i<rec.length; i++){
                   if(s[i].Id == rec[i].Id){
                       component.set("v.selected", true);
                   }
                }*/

                   
               //get first and last record id
               /*let rec = component.get("v.record");
                let firstId = rec[0].Id;
                let lastId = rec[rec.length-1].Id; */
                component.set("v.firstRec",firstId);
                component.set("v.lastRec", lastId);

                

                if(isPrevious == true){
                    let tempList = [];
                    let rec = component.get("v.record");
                    for(var i= rec.length-1; i>=0; i--){
                        
                        tempList.push(rec[i]);
                        //console.log("Previous button : " , tempList);

                    }
                    component.set("v.record", tempList);
                    console.log('templist : ' + JSON.stringify(tempList));
                    component.set("v.firstRec",tempList[0].Id);
                	component.set("v.lastRec", tempList[tempList.length-1].Id);
                }
           

            }
            
           // component.set("v.tempList", s); 
        //component.find("maintainState").set("v.selectedRows",component.get("v.selected"));
       
                
          console.log(' first : ' + component.get("v.firstRec"));
          console.log(' last : ' + component.get("v.lastRec"));  
        });
        $A.enqueueAction(action);
    },

    // Method use for disable button functionality
    disableButton :function(component,totalPages){
        if(component.get("v.page")==1){
             component.set("v.hasPrevious", true);
            if(component.get("v.page") != totalPages){
                component.set("v.hasNext", false);
            }
            else{
                component.set("v.hasNext", true);
            }
        }
        else if(component.get("v.page") == totalPages){
            component.set("v.hasNext", true);
            if(component.get("v.page") != 1)
                component.set("v.hasPrevious", false);
        }
        else{
                component.set("v.hasPrevious", false);
                component.set("v.hasNext", false);
            }
    },
    
    sortData: function (component, fieldName, sortDirection) {
        var fname = fieldName;
        console.log("Sort Data Called :" + fname);
        var data = component.get("v.record");
        var reverse = sortDirection !== 'asc';
        console.log("reverse : " + reverse);
        data.sort(this.sortByfield(fieldName, reverse))
        component.set("v.record", data);
    },
    sortByfield: function (field, reverse) {
        var key = function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },

   /* first : function (component, event,helper) {
        let s = component.get("v.tempList");
        console.log("first button id: ", s);
        component.set("v.tempList", s);

        let isPrevious = false;
        component.set("v.page", 1);
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        //let pageNumber = component.get("v.page");
        let recordSize = component.get("v.pageSize");

       

        let query = 'SELECT ' + flds + ' FROM ' + obj + ' ORDER BY ID LIMIT ' + recordSize;

        helper.fetchRecords(component,event,flds, query,isPrevious);
        helper.disableButton(component,component.get("v.totalPages"));
        
    },

    next : function (component, event,helper) {
        let s = component.get("v.tempList");
        console.log("Next button id : ", s);
        component.set("v.tempList", s);
        console.log("selected id in next : " , component.get("v.selected"));

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
    previous : function (component, event,helper) {
        let s = component.get("v.tempList");
        console.log("previous button id : ", s);
        component.set("v.tempList", s);
        
        let isPrevious = true;
        component.set("v.page", component.get("v.page")-1);
        let obj = component.get('v.response.objectName');
        let flds = component.get('v.response.fields');
        let recordSize = component.get("v.pageSize");
        //let pageNumber = component.get("v.page");

        let query = 'SELECT ' + flds + ' FROM ' + obj + ' WHERE ID < \''+ component.get("v.firstRec") + '\' ORDER BY ID DESC LIMIT ' + recordSize ;
        helper.fetchRecords(component,event, flds, query, isPrevious);
        helper.disableButton(component,component.get("v.totalPages"));
    }
    previous : function (component, event,helper) {

    }*/


    
})