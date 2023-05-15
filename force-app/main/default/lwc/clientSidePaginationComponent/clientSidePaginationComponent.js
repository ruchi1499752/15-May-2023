import { LightningElement, track } from 'lwc';
import getObjectName from '@salesforce/apex/ClientSidePaginationController.getObjectName';
import getFields from '@salesforce/apex/ClientSidePaginationController.getFields';
import getData from '@salesforce/apex/ClientSidePaginationController.getData';

export default class ClientSidePaginationComponent extends LightningElement {
    @track objList = [];
    @track selectedObj;
    @track fieldsList = [];
    @track selectedFields; 
    @track showFields = false;
    @track records;
    @track columns;
    @track displayRecords;
    @track eachSelectedFields = [];
    @track showTable = false;
    //==========================
    @track totalRecords;
    @track totalPages;
    @track pageNumber = 1;
    //===========================
    @track sortedBy;
    @track sortedDirection;
    //===========================
    @track selected = [];
    @track pageList = [];
    @track selectedResult = [];
    @track selectedRecordIds = new Set();
    @track selection;
    //@track selectedIds = [];

    @track recordSize = '10';
    get options() {
        return [
            { label: '10', value: '10' },
            { label: '15', value: '15' },
            { label: '20', value: '20' },
            { label: '25', value: '25' },
        ];
    }

    connectedCallback(){
        getObjectName()
        .then(result =>{
            console.log('Object List :' , result);
            let objs = [];
            for(let key in result){
                objs.push({label : result[key], value : key});
                
            }
            console.log('Object List :',objs);
            this.objList = objs;
         })
        .catch(error =>{
            console.log('Object List Error :', error);
        });
    }
    handleChange(event){
        this.showFields = true;
        let selectObj = event.target.value;
        console.log('Selected Object !!!!!!!!!!!!!!!!:', selectObj);
        this.selectedObj = selectObj;
        
        getFields({obj : this.selectedObj})
        .then(result =>{
            console.log('Fields Name :', result);
            let fieldResult = [];
            for(let fld in result){
                fieldResult.push({label : result[fld], value : fld});
            }
            console.log('Field List :' , fieldResult);
            this.fieldsList = fieldResult;
        })
        .catch(error =>{
            console.log('Fields Name Error :', error);
        });
        
    }
    handleFieldsChange(event){
        this.selectedFields = event.detail.value;
        console.log('Selected values are: ', JSON.parse(JSON.stringify(this.selectedFields)));

        let fieldList = this.selectedFields;
        let allFields =  this.fieldsList;
        let allSelectedFields = [];
        for(var i=0; i<allFields.length; i++){
            for(var j=0; j<fieldList.length; j++){
                if(allFields[i].value == fieldList[j]){
                    allSelectedFields.push(allFields[i]);
                }
            }
        }
        this.eachSelectedFields = allSelectedFields;
        console.log('Each Selected Fields:', JSON.parse(JSON.stringify(this.eachSelectedFields)));

    }

    handleFetchRecords(event){
        console.log('call fetch record method after next button clicked');
        this.showTable = true;
       console.log('Selected object:', this.selectedObj);
       console.log('Selected fields : ',JSON.parse(JSON.stringify(this.selectedFields)));
       console.log('Each Selected Fields:', JSON.parse(JSON.stringify(this.eachSelectedFields)));
       let fieldsColumn = this.eachSelectedFields;
        
       getData({
            objName : this.selectedObj, 
            fieldList : JSON.parse(JSON.stringify(this.selectedFields))
        })
        .then(result =>{
            console.log('Get Data Response :', result);
            this.records = result;
            console.log('Records !!!!!!!!!!!!!!!!!!!!!!!!', this.records);
            var rec = [];
            for(var i = 0; i < Number(this.recordSize); i++) {
                rec.push(result[i]);
            }
            this.displayRecords = rec;
            console.log('Display Records :', this.displayRecords);
            this.totalRecords = result.length;
            console.log('Total Records  :', this.totalRecords);
            console.log('Default Record Size :', this.recordSize);
            this.totalPages = Math.ceil(this.totalRecords/Number(this.recordSize));
            console.log('Total Pages :', this.totalPages);


            var columnList = [];
                for(var j = 0; j < fieldsColumn.length; j++) {
                    columnList.push({ label: fieldsColumn[j].label, fieldName: fieldsColumn[j].value, type: fieldsColumn[j].datatype, sortable : true});
                }
                this.columns = columnList;
                console.log('Columns :' , JSON.parse(JSON.stringify(this.columns)));

        })
        .catch(error =>{
            console.log('Get Data Error :', error);
        });

        this.ProcessButton();
    }

    handleRecordSizeChange(event){
        this.recordSize= event.target.value;
        console.log('Record size :', this.recordSize);
        this.pageNumber = 1;
        this.totalPages = Math.ceil(this.totalRecords/Number(this.recordSize));
        
        this.processRecord();
        this.ProcessButton();
       // this.handleFetchRecords();
    }

// Button Navigations:
    handleNavigation(event){
        // this.template.querySelector(
        //     '[data-id="datarow"]'
        //   ).selectedRows = this.selection;
        let buttonName = event.target.name;
        if(buttonName == 'First'){
            this.pageNumber = 1;
        }else if(buttonName == 'Previous'){
           this.pageNumber = this.pageNumber > 1 ? this.pageNumber - 1 : 1;
          
           
        }else if(buttonName == 'Next'){
            this.pageNumber = this.pageNumber >= this.totalPages ? this.totalPages : this.pageNumber + 1;
            //this.selectedRows();
            
           
        }else if(buttonName == 'Last'){
            this.pageNumber = this.totalPages;
        }
        
        this.processRecord();
       //this.ProcessButton();
    }

    processRecord(){
        this.template.querySelector(
                '[data-id="datarow"]'
              ).selectedRows = this.selection;

        console.log('SELCTION!!!:', this.selection);

        console.log('Hii from process record!!!!!!!!');
        let res = [];
        let startIndex = ((this.pageNumber - 1) * Number(this.recordSize));
        let endIndex = (this.pageNumber * Number(this.recordSize) >= this.totalRecords) ? this.totalRecords : this.pageNumber * Number(this.recordSize);
        for(var i = startIndex ; i< endIndex ; i++){
            res.push(JSON.parse(JSON.stringify(this.records[i])));
        }
        
        //this.displayRecords = JSON.parse(JSON.stringify(res));

        console.log('All Selected Ids ',this.selectedRecordIds);
        this.selected = this.selectedRecordIds;
        console.log('SELECTED :', this.selected);
       // this.displayRecords = JSON.parse(JSON.stringify(res));

        var pageIds = new Set();
        res.forEach(function(element){
            pageIds.add(element.Id); 
        });
        console.log('Page Ids :', pageIds);

        // pageIds.forEach(function(element) {
        //     if(this.selected.has(element)) {
        //         console.log('Yes');
        //         //res.add(this.selected);
        //        //res.splice(res.indexOf(element),1);
        //        //res.add(this.selectedRecordIds);
        //     } 
        //     else{
        //         console.log('No');
        //     }
        // });
        this.displayRecords = JSON.parse(JSON.stringify(res));

        
    }

    

// Disable Buttons 
    get disablePreviousButtons(){
        if(this.pageNumber == 1){
            return true;
        }   
    }
    get disableNextButtons(){
        if(this.pageNumber == this.totalPages){
            return true;
        }
    }

// Column wise Sorting :

    onSort(event){
        console.log('Hii from onSort');
        this.sortedBy = event.detail.fieldName;;
        console.log('Selected Field :', this.sortedBy);
        this.sortedDirection = event.detail.sortDirection;
        this.sortData(this.sortedBy, this.sortedDirection);
        
    }
    sortData(fieldName, direction){
        console.log('Sort Data Call!!!!!!!!!!!!!!');
        let parseData = JSON.parse(JSON.stringify(this.displayRecords));
        console.log('Parse Data :', parseData);
        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldName];
        };
        // cheking reverse direction
        let isReverse = direction === 'asc' ? 1: -1;
        // sorting data
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ""; // handling null values
            y = keyValue(y) ? keyValue(y) : "";
            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        this.displayRecords = parseData;
    }


    process(event){
        let currentPageNumber = event.target.label;
        console.log('Current Page Number :', currentPageNumber);
        this.pageNumber = currentPageNumber;
        this.processRecord();
        //this.selectedRows();
        this.ProcessButton();
      
    }

//dynamic Page Number :
    ProcessButton(event){
        console.log('Current page Number :', this.pageNumber);
        var tempPageList = [];
        if(this.pageNumber < 4){
            tempPageList.push(1, 2, 3, 4, 5);

        }else if(this.pageNumber > (this.totalPages-4)){
            console.log('Else if part !!!!!');
            console.log('Current Page Number :', this.pageNumber);
            tempPageList.push(this.totalPages-4, this.totalPages-3, this.totalPages-2, this.totalPages-1, this.totalPages);
            console.log('Page List-------------', tempPageList);

        }else{
            console.log('Else part : current Page number :=', this.pageNumber);
            tempPageList.push(this.pageNumber-2, this.pageNumber-1, this.pageNumber, this.pageNumber+1, this.pageNumber+2);
            console.log('Page List !!!!!!!!1', tempPageList);
        }
        
        this.pageList = tempPageList;
        console.log('pageList :', this.pageList);
        //this.selectedRows();
       

    }

// Maintain State Of Checkboxes
    selectedRows(event){
        console.log('Call selectedRows Method');
        var demo = new Set(this.selection);
        console.log('demo===>',demo);
        var pageIds = new Set();
        this.displayRecords.forEach(function(element){
            pageIds.add(element.Id); 
        });
        console.log('Page Ids :', pageIds);

        var SelectedRows = event.detail.selectedRows;
        console.log('ARRR :', SelectedRows);
        let tempId = new Set();
        let selectedIds = new Set();
        
        if(SelectedRows != null && SelectedRows != undefined && SelectedRows.length>0){
            SelectedRows.forEach(function(element){
                tempId.add(element.Id);
                if(!selectedIds.has(element.Id)){
                    selectedIds.add(element.Id);
                }
            })
        }
        console.log('Temp Ids :', tempId);
        console.log('SELected IDs :', selectedIds);
        //let tempSet = new Set();
        for(let item of selectedIds){
            this.selectedRecordIds.add(item);
        }
        console.log('Temp Set :', this.selectedRecordIds);
        

        pageIds.forEach( function(element) {
            console.log('if part------');
            if(selectedIds.add(element) && !tempId.add(element)) {
                selectedIds.clear(selectedIds.indexOf(element),1);
            } 
        });

    }



}