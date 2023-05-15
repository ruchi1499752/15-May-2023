import { LightningElement,api,wire, track} from 'lwc';
import getData from '@salesforce/apex/CustomAccountController.getData';
import updateAccountData from '@salesforce/apex/CustomAccountController.updateData';
import {getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import CUSTOM_ACCOUNT_OBJECT from '@salesforce/schema/Account_Custom__c';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountChildComponent extends LightningElement {
    @api accId;
    @track industryPicklistValues;
    @track ratingPicklistValues;
    recordTypeId; 
    @api accData;
    @api isEditable;
    updatedRow = {};
    storeAccountData;
    accIds = [];
    
    connectedCallback(){
       this.handleRecords();
    }
    handleRecords(){
        console.log('HEy ACCID ::', this.accId);
       let query = 'SELECT Id,Name, Industry__c,Rating__c,Rating_Date__c FROM Account_Custom__c where Account_Name__c = \'' + this.accId + '\'';
       console.log('Query ::', query);
        getData({qry : query})
        .then(result =>{
            console.log('result =>', result);
            this.accData = result;
            console.log('ACCOUNT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.accData); 
            this.changeRowColor();
        })
        .catch(error =>{
            console.log('ERROR => ', error);
        });

    }
    changeRowColor(event){
        console.log('call changeRowColor');
        console.log('ACCOUNT DATATAAAAAAAAAAAAAAAAAAAAA ::', this.accData); 
            
           // Get today's date
            let today = new Date();
            let TodayDate = today.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
            console.log('TodayDate ::' , TodayDate);

            //Iterate through the rows and add a custom CSS class to the row if the date field is equal to today's date
            this.accData.forEach(row =>{
                var temp = new Date(row.Rating_Date__c);
                console.log('Rating date ::', temp.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' }));
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

    handleFieldChangeValues(event){

        let accField= event.currentTarget.dataset.fld;
        console.log('ID ::' , accField);

        let recID = event.currentTarget.dataset.recId;
        console.log('ID ::' , recID);
        const index = event.target.dataset.index;
        console.log('Index ::', index);

        this.accData[index][accField]= event.target.value;
        console.log('AccData+++++++++++++ :', this.accData); 

        // this.updatedRow[index][accField]= event.target.value;

        // console.log('AccData+++++++++++++ :', this.updatedRow); 

        //********************************************************* */

        // let accId= event.currentTarget.dataset.recId;
        // console.log('ID ::' , accId);

        // const index = event.target.dataset.index;
        // console.log('Index ::', index);

        // const fieldName = event.currentTarget.dataset.fld;
        // console.log('FieldName ::' , fieldName);
        // const value = event.target.value;
        // console.log('value :' , value);
        // this.updatedRow = {...this.updatedRow,[index]: {...this.updatedRow[index], accId,  [fieldName]: value}};
        // console.log('UpdateRow ::' , this.updatedRow); 

       

        
       // this.changeRowColor();    
    }
   
    @api handlesaveData(){
        //alert('Call handlesaveData');
        console.log('Account Data Ruchi::' , this.accData);

       
        updateAccountData({objectName : 'Account_Custom__c', objList : JSON.stringify(this.accData)})
        .then(result =>{
            //console.log('Update Result =>', result);
            this.storeAccountData = result;
            console.log('storeAccountData ::' , this.storeAccountData);
           
          

            
        })
        .catch(error =>{
            console.log('Update Error =>', error);
        })

    }

    @wire(getObjectInfo, { objectApiName: CUSTOM_ACCOUNT_OBJECT })
    objectInfo({ error, data }) {
        if (data) {
            console.log('Object Data :: ' , data);
        this.recordTypeId = data.defaultRecordTypeId;
        console.log('Record Type Id :' , this.recordTypeId);
        } else if (error) {
            console.log('Error =>', error);
        }
    }     
    @wire(getPicklistValuesByRecordType, { objectApiName: CUSTOM_ACCOUNT_OBJECT, recordTypeId: '$recordTypeId' })
    picklistInfo({ error, data }) {
        if (data) {
            this.industryPicklistValues = data.picklistFieldValues.Industry__c.values;
            this.ratingPicklistValues = data.picklistFieldValues.Rating__c.values;
            
        } else if (error) {
            console.log('Error =>', error);
        }
    }   
    handleAddRow(event){
        console.log('Inside HandleAddRow method');
        console.log('DATAAAAAAAAAAAAAAAAAAAAA :' ,  JSON.parse(JSON.stringify(this.accData)));

        // const div = this.template.querySelector('.scrollable');
        // div.scrollTop = div.scrollHeight - div.clientHeight;

        var myObj = {
            "Name" : "",    
            "Industry__c" : "",
            "Rating__c" : "",
            "Rating_Date__c" : "" ,
            "Account_Name__c" : this.accId

        };
         
         var ans = this.accData.concat(myObj);
         console.log('Ans ::' , ans); 
         
         this.accData = ans;
         console.log('NEW DATA :::', this.accData);
        
    }
    handleDeleteRecord(event){
        let recID = event.currentTarget.dataset.recId;
        console.log('ID ::' , recID);
        const index = event.currentTarget.dataset.index;
        console.log('Index:', index);

        if (recID) {
            console.log('Inside delete if');
            console.log('ID exist :: ' , recID);
            deleteRecord(recID)
            .then(result =>{
                console.log('Records Deleted', index);
                this.removeRecord(index,1);
                //this.handleRecords();

            })
            .catch(error =>{
                console.log('Delete Error : ', error);
            })
        } else {
            
            console.log('Inside delet else');
            console.log('ID doesnot exist :: ' , recID);
            console.log('Index:', index);
            console.log('AccDATA:::::::::::::::::::::::', this.accData);

            this.accData = [...this.storeAccountData];
            console.log('combined2 ::', this.accData);
            this.accData.splice(index,1);
            

          
        }
       
    }
    removeRecord(index, count){
        let temp = JSON.parse(JSON.stringify(this.accData));
        console.log('removeRecord ',temp.length);
        temp.splice(index,count);
        this.accData = temp;
        
        console.log('removeRecord after delete ',temp.length);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record deleted',
                variant: 'success'
            })
        );

       // this.contacts = this.contacts.filter(contact => contact.Id !== recordId);
        // this.storeAccountData = this.storeAccountData.filter(account => account.Id ==  this.accData.Id);
        // console.log('storeAccountData ::' , this.storeAccountData);

    }
    // handleScroll(){
    //     const div = this.template.querySelector('.scrollable');
    // if (div.scrollTop !== div.scrollHeight - div.clientHeight) {
    //   // scroll to bottom
    //   div.scrollTop = div.scrollHeight - div.clientHeight;
    // }
    // }

    handleAddCol(event){
        console.log('Inside HandleAddCol method');
        console.log('DATAAAA:' ,  JSON.parse(JSON.stringify(this.accData)));

        // const div = this.template.querySelector('.scrollable');
        // div.scrollTop = div.scrollHeight - div.clientHeight;

        var myObj = {
            "Name" : "",    
            "Industry__c" : "",
            "Rating__c" : "",
            "Rating_Date__c" : "" ,
            "Account_Name__c" : this.accId

        };
         
         var ans = this.accData.concat(myObj);
         console.log('Ans ::' , ans); 
         
         this.accData = ans;
         console.log('NEW DATA :::', this.accData);
    }
    
}