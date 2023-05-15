import { LightningElement, wire } from 'lwc';
import {getObjectInfo, getPicklistValue} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import RECORDTYPEID from '@salesforce/schema/Account.RecordTypeId'

export default class ObjectInfoApi extends LightningElement {

   @wire(getObjectInfo, {objectApiName : ACCOUNT_OBJECT})
   wiredAccount({data, error}){
    if(data){
        console.log('Object Information :', data);
    }
    if(error){
        console.log('ERROR :' , error);
    }
   }

   @wire(getPicklistValue, {recordTypeId : RECORDTYPEID, fieldApiName : INDUSTRY})
   wiredField({data, error}){
    if(data){
        console.log('Picklist Values :' , data);
    }
    if(error){
        console.log('ERROR :' , Error);
    }
   }
   
   
}