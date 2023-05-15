import { LightningElement,track } from 'lwc';

export default class ParentComponentComm extends LightningElement {
    @track searchValue;
    handleSerachValue(event){
        this.searchValue = event.detail;
        console.log('Parent : SearchValue', this.searchValue);
    }
}