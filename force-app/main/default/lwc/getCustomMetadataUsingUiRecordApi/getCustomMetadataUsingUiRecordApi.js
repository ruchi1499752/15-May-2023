import { LightningElement,wire,api } from 'lwc';
import {getRecord} from 'lightning/uiRelatedListApi';
//import isActive_Field from '@salesforce/schema/Validation_Control__mdt.';
//import Label from '@salesforce/schema/Validation_Control__mdt.label';
//import MLabel from '@salesforce/schema/Validation_Control__mdt.MasterLabel';
const FIELDS = [
    'Validation_Control__mdt.MasterLabel',
    'Validation_Control__mdt.DeveloperName',
    'Validation_Control__mdt.isActive__c',
    'Validation_Control__mdt.Language',
];


//const FIELDS = [ Label, MLabel];
export default class GetCustomMetadataUsingUiRecordApi extends LightningElement {

    recordId = '2Fm055j000000pFHT';
    @wire(getRecord, {recordId :'$recordId', FIELDS})
    metadataRecord;

    getMetadataValues(){
        console.log('metadataRecords :  ' , this.metadataRecord.data);
    }


}