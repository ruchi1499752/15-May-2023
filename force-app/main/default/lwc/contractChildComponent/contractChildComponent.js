import { LightningElement, api, track, wire } from 'lwc';
import getData from '@salesforce/apex/CustomAccountController.getData';
import updateContractData from '@salesforce/apex/CustomAccountController.updateData';
import {getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import CUSTOM_CONTRACT_OBJECT from '@salesforce/schema/Contract_Custom__c';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ContactId from '@salesforce/schema/Case.ContactId';


export default class ContractChildComponent extends LightningElement {
    @api contractId;
    @track contractData;
    recordTypeId;
    @api isEditable;
    @track statusPicklistValues;


    connectedCallback(){
        let query = 'SELECT Id,Name, Status__c,Description__c, Activated_Date__c FROM Contract_Custom__c where Account_Name__c = \'' + this.contractId + '\'';
        getData({qry : query})
        .then(result =>{
            console.log('result =>', result);
            this.contractData = result;
            console.log('CONTRACT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.contractData);
            this.changeRowColor();
            
        })
        .catch(error =>{
            console.log('ERROR => ', error);
        });


    //     console.log('Get Records from Parent(CASE) ::' , this.records);
    //     this.contractData = this.records[0].Contract_Customs__r;
    //     console.log('Data RRRRRRRRRRRRRRRRRRRRRRRR :', this.contractData);

    //     let tempData = JSON.parse(JSON.stringify(this.contractData));
    //     // Get today's date
    //     let today = new Date();
    //     let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
    //     console.log('Today date : ', TodayDate);

    //     // Iterate through the rows and add a custom CSS class to the row if the date field is equal to today's date
    //     tempData.forEach(row =>{
    //         var temp = new Date(row.Activated_Date__c);
    //         console.log('Contract Activated_Date__c ::', temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }));
    //         if(temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }) === TodayDate){
    //             console.log('Inside If ');
    //             row.rowClass ='greenRow';
    //         }
    //         else{
    //             console.log('Inside Else ');
    //             //row.rowClass = 'whiteRow';
    //         }
    //     });

    //    this.contractData = tempData;
        
        
    }

    changeRowColor(event){
        console.log('call changeRowColor');
        console.log('ACCOUNT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.contractData); 
            
           // Get today's date
            let today = new Date();
            let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
            console.log('TodayDate ::' , TodayDate);

            //Iterate through the rows and add a custom CSS class to the row if the date field is equal to today's date
            this.contractData.forEach(row =>{
                var temp = new Date(row.Activated_Date__c);
                console.log('Activated_Date__c date ::', temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }));
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

    @wire(getObjectInfo, { objectApiName: CUSTOM_CONTRACT_OBJECT })
    objectInfo({ error, data }) {
        if (data) {
            console.log('Object Data :: ' , data);
        this.recordTypeId = data.defaultRecordTypeId;
        console.log('Record Type Id :' , this.recordTypeId);
        } else if (error) {
            console.log('Error =>', error);
        }
    }     
    @wire(getPicklistValuesByRecordType, { objectApiName: CUSTOM_CONTRACT_OBJECT, recordTypeId: '$recordTypeId' })
    picklistInfo({ error, data }) {
        if (data) {
            this.statusPicklistValues = data.picklistFieldValues.Status__c.values;
            console.log('statusPicklistValues :', this.statusPicklistValues);
            
            
        } else if (error) {
            console.log('Error =>', error);
        }
    }   

    handleFieldChange(event){
        let contractField= event.currentTarget.dataset.fld;
        console.log('ID ::' , contractField);

        let recID = event.currentTarget.dataset.recId;
        console.log('ID ::' , recID);
        const index = event.target.dataset.index;
        console.log('Index ::', index);

        this.contractData[index][contractField]= event.target.value;
        console.log('ContractData+++++++++++++ :', this.contractData);

        this.changeRowColor();
    }
    @api handlesaveData(){
        //alert('Call handlesaveData');
        console.log('contract Data Ruchi::' , this.contractData);

        updateContractData({objectName : 'Contract_Custom__c', objList : JSON.stringify(this.contractData)})
        .then(result =>{
            console.log('Contract Update Result =>', result);
            
        })
        .catch(error =>{
            console.log('Contract Update Error =>', error);
        })

    }

   
    handleAddRow(event){
        alert('Call Contract AddNEWROW MEthod');
        console.log('Inside HandleAddRow method');
        console.log('DATAAAAAAAAAAAAAAAAAAAAA :' ,  JSON.parse(JSON.stringify(this.contractData)));
        var myObj = {
            // "name" : "",    
            "Status__c" : "",
            "Activated_Date__c" : "",
            "Description__c" : "" ,
            "Account_Name__c" : this.contractId
        };
         
         var ans = this.contractData.concat(myObj);
         console.log('Ans ::' , ans); 
         
         this.contractData = ans;
         console.log('NEW DATA :::', this.contractData);
        
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
        let temp = JSON.parse(JSON.stringify(this.contractData));
        console.log('removeRecord ',temp.length);
        temp.splice(index,count);
        this.contractData = temp;
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