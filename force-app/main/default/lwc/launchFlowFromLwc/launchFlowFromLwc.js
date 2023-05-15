import { LightningElement } from 'lwc';
import getAccountData from '@salesforce/apex/AccController.getAccountData';

export default class LaunchFlowFromLwc extends LightningElement {
    singleAccount;
    connectedCallback() {
        getAccountData()
            .then((result) => {
                console.log('result', result);
                //this.singleAccount = result;
            })
            .catch((error) => {
                console.log(error);
            });
    }
    get inputVariables() {
        return [
            {
                name: 'account',
                type: 'SObject',
                value: this.singleAccount
            }
        ];
    }

    handleStatusChange(event) {
        console.log('handleStatusChange', event.detail);
    }
}