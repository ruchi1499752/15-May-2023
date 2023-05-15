import { LightningElement , api, track, wire} from 'lwc';
import getData from '@salesforce/apex/CustomAccountController.getData';
import updateContactData from '@salesforce/apex/CustomAccountController.updateData';
import {getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import CUSTOM_CONTACT_OBJECT from '@salesforce/schema/Contact_Custom__c';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactChildComponent extends LightningElement {
    @api contactId;
    recordTypeId;
    @api contactData;
    @api isEditable;
    @track statusPicklistValues;

    connectedCallback(){

        console.log('CONID ::', this.contactId);
        let query = 'SELECT Id,Name, Status__c,Birthdate__c FROM Contact_Custom__c where Account_Name__c = \'' + this.contactId + '\'';
        getData({qry : query})
        .then(result =>{
            console.log('result =>', result);
            this.contactData = result;
            console.log('CONTACT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.contactData);
            this.changeRowColor();
        })
        .catch(error =>{
            console.log('ERROR => ', error);
        });
    }
    changeRowColor(event){
        console.log('call changeRowColor');
        console.log('CONTACT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.contactData);
            
            let today = new Date();
            let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit'});
            console.log('Today date : ', TodayDate);

            this.contactData.forEach(row => {
                console.log('ROW ::' , row);
                console.log('Birthday ::' , row.Birthdate__c);
                if(row.Birthdate__c == TodayDate){
                    row.rowClass ='greenRow';
                    console.log('inside If');
                }
                else{
                    console.log('inside else');
                }

            });   
    }
    handleFieldChange(event){
        let conField= event.currentTarget.dataset.fld;
        console.log('ID ::' , conField);

        let recID = event.currentTarget.dataset.recId;
        console.log('ID ::' , recID);
        const index = event.target.dataset.index;
        console.log('Index ::', index);

        let today = new Date();
        let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit'});
        console.log('Today date : ', TodayDate);

        this.contactData[index][conField]= event.target.value;
        console.log('ConData+++++++++++++ :', this.contactData);
        this.changeRowColor();
    }

    @api handlesaveData(){
       // alert('Call handlesaveData');
        console.log('Contact Data Ruchi::' , this.contactData);

        updateContactData({objectName : 'Contact_Custom__c', objList : JSON.stringify(this.contactData)})
        .then(result =>{
            console.log('Contact Update Result =>', result);
            
        })
        .catch(error =>{
            console.log('Update Error =>', error);
        })

    }
    @wire(getObjectInfo, { objectApiName: CUSTOM_CONTACT_OBJECT })
    objectInfo({ error, data }) {
        if (data) {
            console.log('Object Data :: ' , data);
            this.recordTypeId = data.defaultRecordTypeId;
        console.log('Contact Record Type Id :' , this.recordTypeId);
        } else if (error) {
            console.log('Error =>', error);
        }
    }     
    @wire(getPicklistValuesByRecordType, { objectApiName: CUSTOM_CONTACT_OBJECT, recordTypeId: '$recordTypeId' })
    picklistInfo({ error, data }) {
        if (data) {
            this.statusPicklistValues = data.picklistFieldValues.Status__c.values;
            console.log('Status Picklist Values  ::' , this.statusPicklistValues);
          
            
        } else if (error) {
            console.log('Error =>', error);
        }
    }  

    handleAddRow(event){
        console.log('Inside HandleAddRow method');
        console.log('DATAAAAAAAAAAAAAAAAAAAAA :' ,  JSON.parse(JSON.stringify(this.contactData)));
        var myObj = {
            "name" : "",    
            "Industry__c" : "",
            "Rating__c" : "",
            "Rating_Date__c" : "",
            "Account_Name__c" : this.contactId 
        };
         
         var ans = this.contactData.concat(myObj);
         console.log('Ans ::' , ans); 
         
         this.contactData = ans;
         console.log('NEW DATA :::', this.contactData);
        
    }

    handleDeleteRecord(event){
        alert('Call delete');
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
        let temp = JSON.parse(JSON.stringify(this.contactData));
        console.log('removeRecord ',temp.length);
        temp.splice(index,count);
        this.contactData = temp;
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