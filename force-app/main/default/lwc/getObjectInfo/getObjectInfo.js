import { LightningElement, wire,api } from 'lwc';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class GetObjectInfo extends LightningElement {
    @api recordId;
    @wire(getObjectInfo, {objectApiName : ACCOUNT_OBJECT})
    accountObject({error, data}){
        if(data){
            console.log('Account Data :' , data);
            console.log('Account Data :::::::::::::' , data.apiName);
            console.log('Account Fields :' , data.fields.AccountNumber);
        }else{
            console.log(error);
        }
    }
    // @wire(getPicklistValues, { recordTypeId: recordId, fieldApiName: INDUSTRY_FIELD })
    // picklistVal({error, data}){
    //     if(data){
    //         console.log('PickList Values:' , data);
    //     }
    //     else{
    //         console.log(error);
    //     }
    // }

}