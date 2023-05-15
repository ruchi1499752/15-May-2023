import { api, LightningElement } from 'lwc';

export default class PassValueFromFlowToLWC extends LightningElement {
    @api inputValue;
    @api strArray;
    @api name = 'Ruchi Chourasia' ;
}