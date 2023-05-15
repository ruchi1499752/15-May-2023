import { api, LightningElement, track } from 'lwc';
import fetchRecord from '@salesforce/apex/MultiSelectComboboxController.fetchRecord';
import searchData from '@salesforce/apex/MultiSelectComboboxController.searchData';
export default class MultiSelectComboboxChild extends LightningElement {
    

    @api payload;
    @track multiSelect = false;
    @track dropdownData;
    //================
    @api options;
    //@api name;
    @api selectedValue;
    @api selectedValues = [];
    @api label;
    @api disabled = false;
   // @api multiSelect = false;

    @api minChar = 2;
    @track value;
    @track values = [];
    //@track optionData;
    @track searchString;
    @track Message;
    @track showDropdown = false;
    @track temp;
  
    connectedCallback() {
       
        
        

        this.showDropdown = false;
        fetchRecord()
        .then(result =>{
            let res = [];
            console.log('Record is :', result);
            for(var i=0; i<result.length; i++){
                res.push({value : result[i].Id , label : result[i].Name} );
            }
            this.optionData = res;
        })
        .catch(error =>{
            console.log('Fetch record Error :', error);
        });

        var optionData = this.options ? (JSON.parse(JSON.stringify(this.options))) : null;
        console.log('Option Data :' , optionData);

        var value = this.selectedValue ? (JSON.parse(JSON.stringify(this.selectedValue))) : null;
        console.log('Single Select Value :', value);
        var values = this.selectedValues ? (JSON.parse(JSON.stringify(this.selectedValues))) : null;
        console.log('Multiselect Values:', values);

        // if(value || values) {
            var searchString;
            var count = 0;
            console.log('Multiselect :', this.multiSelect);

            for(var i = 0; i < optionData.length; i++) {
                if(this.multiSelect) {
                    if(values.includes(optionData[i].value)) {
                        optionData[i].selected = true;
                        count++;
                    }  
                } else {
                    if(optionData[i].value == value) {
                        searchString = optionData[i].label;
                        console.log('Search String :', searchString);
                    }
                }
            }
            if(this.multiSelect){
                //this.searchString = count + ' Option(s) Selected';
            }
                //this.searchString = count + ' Option(s) Selected';
            else{
                this.searchString = searchString;
            }
                
       // }
        this.value = value;
        console.log('value :' , value);
        this.values = values;
        console.log('value :' , values);
        this.optionData = optionData;
        this.temp =this.optionData;
    }
  
    filterOptions(event) {
        this.searchString = event.target.value;
        //let rec = this.optionData;
        searchData({chr : this.searchString})
        .then(result =>{
            console.log('Search Data :', result);
            this.optionData = result;
            let res = [];
            
            for(var i=0; i<result.length; i++){
                res.push({value : result[i].Id , label : result[i].Name} );
            }
            this.optionData = res;
            
            
        })
        .catch(error =>{
            console.log('error');
        })


        
        //this.optionData = temp;
        // console.log('Search String :', this.searchString);
        // if( this.searchString && this.searchString.length > 0 ) {
        //     this.Message = '';
        //     if(this.searchString.length >= 2) {
                
        //         let filterData = this.optionData.filter(opt => opt.label.toLowerCase().trim().startsWith(this.searchString.toLowerCase().trim()));
        //         this.optionData = filterData;
        //         // var flag = true;
        //         // for(var i = 0; i < this.optionData.length; i++) {
        //         //     if(this.optionData[i].label.toLowerCase().trim().startsWith(this.searchString.toLowerCase().trim())) {
        //         //         this.optionData[i].isVisible = true;
        //         //         flag = false;
        //         //     } else {
        //         //         this.optionData[i].isVisible = false;
        //         //     }
        //         // }
        //         // if(flag) {
        //         //     this.Message = "No results found for '" + this.searchString + "'";
        //         // }
        //     }
            this.showDropdown = true;
        // } 
        // else {
        //     this.Message = "No results found for '" + this.searchString + "'";
        //     // for(var i = 0; i < this.optionData.length; i++) {
        //     //     this.optionData[i].Visible = true;
        //     // }
        //     this.showDropdown = false;
        // }
    }
  
    selectItem(event) {
        var selectedVal = event.currentTarget.dataset.id;
        if(selectedVal) {
            var count = 0;
            var options = JSON.parse(JSON.stringify(this.optionData));
            for(var i = 0; i < options.length; i++) {
                if(options[i].value === selectedVal) {
                    if(this.multiSelect) {
                        if(this.values.includes(options[i].value)) {
                            this.values.splice(this.values.indexOf(options[i].value), 1);
                        } else {
                            this.values.push(options[i].value);
                        }
                        options[i].selected = options[i].selected ? false : true;   
                    } else {
                        this.value = options[i].value;
                        this.searchString = options[i].label;
                    }
                }
                if(options[i].selected) {
                    count++;
                }
            }
            this.optionData = options;


            if(this.multiSelect){
                this.searchString = count + ' Option(s) Selected';
 
                let ev = new CustomEvent('selectoption', {detail:this.values});
                this.dispatchEvent(ev);
            }
                 
 
            if(!this.multiSelect){
                let ev = new CustomEvent('selectoption', {detail:this.value});
                this.dispatchEvent(ev);
            }
 
            if(this.multiSelect)
                event.preventDefault();
            else
                this.showDropdown = false;
        }
    }
  
    showOptions() {
        this.showDropdown= true;
        console.log('Hii from showOptions');
       // if(this.disabled == false && this.options) {
            console.log('Hii from showOptions');
            
            this.Message = '';
            this.searchString = '';
            var options = JSON.parse(JSON.stringify(this.optionData));
            console.log('Options :', options);
            for(var i = 0; i < options.length; i++) {
                options[i].isVisible = true;
            }
            if(options.length > 0) {
                this.showDropdown = true;
            }
            this.optionData = options;
        //}
    }
  
    closePill(event) {
        var value = event.currentTarget.name;
        var count = 0;
        var options = JSON.parse(JSON.stringify(this.optionData));
        for(var i = 0; i < options.length; i++) {
            if(options[i].value === value) {
                options[i].selected = false;
                this.values.splice(this.values.indexOf(options[i].value), 1);
            }
            if(options[i].selected) {
                count++;
            }
        }
        this.optionData = options;
        if(this.multiSelect){
            this.searchString = count + ' Option(s) Selected';
             
            let ev = new CustomEvent('selectoption', {detail:this.values});
            this.dispatchEvent(ev);
        }
    }
  
    handleBlur() {
        var previousLabel;
        var count = 0;
 
        for(var i = 0; i < this.optionData.length; i++) {
            if(this.optionData[i].value === this.value) {
                previousLabel = this.optionData[i].label;
            }
            if(this.optionData[i].selected) {
                count++;
            }
        }
 
        if(this.multiSelect){
            this.searchString = count + ' Option(s) Selected';
        }else{
            this.searchString = previousLabel;
        }
 
        this.showDropdown = false;
        
    }
 
    // handleMouseOut(){
    //     //this.showDropdown = false;
    // }
 
    // handleMouseIn(){
    //     this.showDropdown = true;
    // }
    // get radioOption() {
    //     return [
    //         { label: 'Single Select', value: true },
    //         { label: 'Multi Select', value: false },
    //     ];
    // }

}