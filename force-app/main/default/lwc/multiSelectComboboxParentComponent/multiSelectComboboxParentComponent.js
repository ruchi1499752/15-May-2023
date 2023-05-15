import { LightningElement, track } from 'lwc';


export default class MultiSelectComboboxParentComponent extends LightningElement {
    @track payload ={
        "icon":"standard:account",
        "object":"account",
        "fields":"name,phone,website",
        "seperator":":",
        "multiselect":true,
        "isSearch":true,
        "noOfRecords":"15",
        "searchField":"name",
        "TitleField" : "Name",
        "search" : "ruchi",
        "options":["One","Two","Three"]
    };
    @track selectedValue;

    handleSelectOptionList(event){
        //console.log(event.detail.value);
        this.selectedValue = event.detail;
        console.log('single Select value !!!!!!!!!!!!!!!:', (this.selectedValue));

    }
    
}