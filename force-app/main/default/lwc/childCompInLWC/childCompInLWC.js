import { api, LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';

export default class ChildComp extends LightningElement {
    @api name = 'Ruchi chourasia';
    @wire (getAccountList) accounts;
    @track message ='Hello World' ;

    @api contacts =[
        {
            id : '1234444444444444',
            Name : 'abc'
        },
        {
            id : '1234444444444444',
            Name : 'xyz'
        },
        {
            id : '1234444444444444',
            Name : 'rst'
        }
    ];
}