import { LightningElement, wire , api} from 'lwc';
import getAllCases from '@salesforce/apex/CaseController.getAllCases';

import { getRecord } from 'lightning/uiRecordApi'; //Import getRecord function of the uiRecordApi

export default class WireMethod extends LightningElement {
    @api recordId;
    /*
 
    */ 
   @wire(getAllCases) cases;

   @wire(getRecord, { recordId: '$recordId', layoutTypes: ['Compact', 'Full'], modes: ['View', 'Edit', 'Create'] })

    viewRecord({ data, error }) {

        if (data) {

            console.log('Record Data===', data); // This data contains the Record info of particular record

        }

        if (error) {

            console.log('error===' + error);

        }

}

}