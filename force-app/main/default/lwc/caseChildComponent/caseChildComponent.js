import { LightningElement,api,track,wire } from 'lwc';
import getData from '@salesforce/apex/CustomAccountController.getData';
import updateCaseData from '@salesforce/apex/CustomAccountController.updateData';
import {getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import CUSTOM_CASE_OBJECT from '@salesforce/schema/Case_Custom__c';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseChildComponent extends LightningElement {
    @api caseId;
    @api caseData;
    @track statusPicklistValues;
    recordTypeId;
    @api isEditable;
    @api caseId1;
    @api caseStatus;
    @api caseDesc;
    @api caseDate;

    connectedCallback(){
        let query = 'SELECT Id,Name, Status__c, Description__c, Date_Time_Opened__c FROM Case_Custom__c where Account_Name__c = \'' + this.caseId + '\'';
        getData({qry : query})
        .then(result =>{
            console.log('result =>', result);
            this.caseData = result;
            console.log('Case DATATAAAAAAAAAAAAAAAAAAAAA ::', this.caseData);
            this.changeRowColor();
            
            
        })
        .catch(error =>{
            console.log('ERROR => ', error);
        });

        // console.log('Get Records from Parent(CASE) ::' , this.records);
        // this.caseData = this.records[0].Case_Customs__r;
        // console.log('Data RRRRRRRRRRRRRRRRRRRRRRRR :', this.caseData);

        // let tempData = JSON.parse(JSON.stringify(this.caseData));
        // // Get today's date
        // let today = new Date();
        // let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
        // console.log('Today date : ', TodayDate);

        // // Iterate through the rows and add a custom CSS class to the row if the date field is equal to today's date
        // tempData.forEach(row =>{
        //     var temp = new Date(row.Date_Time_Opened__c);
        //     console.log('Date_Time_Opened__c::', temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }));
        //     if(temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }) === TodayDate){
        //         console.log('Inside Case If ');
        //         row.rowClass ='greenRow';
        //     }
        //     else{
        //         console.log('Inside Else ');
        //     }
        // });

        // this.caseData = tempData;       
    }
    changeRowColor(event){
        console.log('call changeRowColor');
        console.log('ACCOUNT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.caseData); 
            
           // Get today's date
            let today = new Date();
            let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
            console.log('TodayDate ::' , TodayDate);

            //Iterate through the rows and add a custom CSS class to the row if the date field is equal to today's date
            this.caseData.forEach(row =>{
                var temp = new Date(row.Date_Time_Opened__c);
                console.log('Date_Time_Opened__c ::', temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }));
                if(temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }) === TodayDate){
                    console.log('Inside If ');
                    row.rowClass ='greenRow';
                }
                else{
                    console.log('Inside Else ');
                    //row.rowClass = 'whiteRow';
                }
            });
            
    }

    handleFieldChange(event){
        let caseField= event.currentTarget.dataset.fld;
        console.log('Case Field ::' , caseField);

        let recID = event.currentTarget.dataset.recId;
        console.log('Case ID ::' , recID);
        const index = event.target.dataset.index;
        console.log('Case Index ::', index);

        this.caseData[index][caseField]= event.target.value;
        console.log('CaseData+++++++++++++ :', this.caseData);
        this.changeRowColor();
    }
    
    @api handlesaveData(){
        //alert('Call handlesaveData');
        console.log('Case Data Ruchi::' , this.caseData);

        updateCaseData({objectName : 'Case_Custom__c', objList : JSON.stringify(this.caseData)})
        .then(result =>{
            console.log('Case Update Result =>', result);
            
        })
        .catch(error =>{
            console.log('Case Update Error =>', error);
        })

    }
    
    @wire(getObjectInfo, { objectApiName: CUSTOM_CASE_OBJECT })
    objectInfo({ error, data }) {
        if (data) {
            console.log('Object Data :: ' , data);
        this.recordTypeId = data.defaultRecordTypeId;
        console.log('Record Type Id :' , this.recordTypeId);
        } else if (error) {
            console.log('Error =>', error);
        }
    }     
    @wire(getPicklistValuesByRecordType, { objectApiName: CUSTOM_CASE_OBJECT, recordTypeId: '$recordTypeId' })
    picklistInfo({ error, data }) {
        if (data) {
            this.statusPicklistValues = data.picklistFieldValues.Status__c.values;
            console.log('statusPicklistValues :', this.statusPicklistValues);
            
            
        } else if (error) {
            console.log('Error =>', error);
        }
    }   
    handleAddRow(event){
        alert('Call Case handleAddRow');
        console.log('Inside HandleAddRow method of Case');
        console.log('DATAAAAAAAAAAAAAAAAAAAAA :' ,  JSON.parse(JSON.stringify(this.caseData)));
        var myObj = {
            "name" : "",    
            "Status__c" : "",
            "Date_Time_Opened__c" : "",
            "Description__c" : "",
            "Account_Name__c" : this.caseId 
        };
         
         var ans = this.caseData.concat(myObj);
         console.log('Ans ::' , ans); 
         
         this.caseData = ans;
         console.log('NEW DATA :::', this.data);
        
    }

    handleDeleteRecord(event){
        let recID = event.currentTarget.dataset.recId;
        console.log('ID ::' , recID);
        const index = event.currentTarget.dataset.index;
        console.log('Index:', index),recID;
        if (recID) {
            console.log('ID exist :: ' , recID);
            deleteRecord(recID)
            .then(result =>{
                console.log('Records Deleted', index);
                this.removeRecord(index,1);
            })
            .catch(error =>{
                console.log('Delete Error : ', error);
            })
        } else {
            console.log('ID doesnot exist :: ' , recID);
            this.removeRecord(index,1);
        }

        
    }
    
    removeRecord(index, count){
        let temp = JSON.parse(JSON.stringify(this.caseData));
        console.log('removeRecord ',temp.length);
        temp.splice(index,count);
        this.caseData = temp;
        console.log('removeRecord after delete ',temp.length);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record deleted',
                variant: 'success'
            })
        );
    }
}