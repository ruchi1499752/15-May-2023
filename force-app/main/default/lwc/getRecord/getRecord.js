import { LightningElement, api, wire } from 'lwc';
import getData from '@salesforce/apex/ContactController1.contactList';

import { getRecord } from 'lightning/uiRecordApi'; //Import getRecord function of the uiRecordApi

export default class GetRecord extends LightningElement {

    @api recordId; // This property store the ID of particular record

    @wire(getRecord, { recordId: '$recordId', layoutTypes: ['Compact', 'Full'], modes: ['View', 'Edit', 'Create'] })

    viewRecord({ data, error }) {

        if (data) {

            console.log('Record Data===', data); // This data contains the Record info of particular record

        }

        if (error) {

            console.log('error===' + error);

        }

    }
    connectedCallback(){
        getData()
        .then(data =>{
            console.log('Result =>'  , data);
        })
        .catch(err =>{
            console.log('Error =>', err);
        })
    }

}