import { LightningElement, track } from 'lwc';
    let options = [
                    {'label':'HTML','value':'HTML'},
                    {'label':'Css','value':'Css'},
                    {'label':'JavaScript','value':'JavaScript'},
                    {'label':'Bootstrap','value':'Bootstrap'}
                ];

    let payload ={
        "icon":"standard:account",
        "object":"account",
        "fields":"lastname,phone,website",
        "seperator":":",
        "multiselect":true,
        "isSearch":true,
        "noOfRecords":10,
        "searchField":"name",
        "options":"one,two,three"
    };
 

export default class MultiSelectCombobox extends LightningElement {
    @track payload = payload;
    @track selectedValue;
    @track selectedValueList = [];
    @track options = options;
    @track radioOption = [];
    @track val;
    @track singleSelect = true;

    connectedCallback(){
        
        
        this.radioOption.push({label : 'Single Select', value : 'SingleSelect'},
                              {label : 'Multi Select', value : 'MultiSelect'});

        this.val = 'SingleSelect';
        
    }
    handleRadio(event){
        let temp = event.target.value;
        console.log('By Default Value is :', temp);
        if(temp == 'SingleSelect'){
            this.singleSelect = true;
        }
        else{
            this.singleSelect = false;
        }
    }
     //for single select picklist
    handleSelectOption(event){
        //console.log(event.detail.value);
        this.selectedValue = event.detail;
        console.log('single Select value :', (this.selectedValue));

    }
    //for multiselect picklist
    handleSelectOptionList(event){
        console.log(event.detail);
        //console.log(event.detail.value);
        this.selectedValueList = event.detail;
        console.log(this.selectedValueList);
        console.log('multi Select value :', (this.selectedValueList));

    }

    
}