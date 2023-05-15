import { LightningElement,api,track } from 'lwc';
import fetchRecord from '@salesforce/apex/MultiSelectComboboxController.fetchRecord';
import searchData from '@salesforce/apex/MultiSelectComboboxController.searchData';
export default class MultiSelectComboboxChildComponent extends LightningElement {
    @api payload;
    @track multiSelect = false;
    @track dropdownData;
    @track dropdownopt = [];
    @track value;
    @track selectedValue;
    @track showDropdown = false;
    @track singleSelect;
    @track searchString;
    @track show = false;
    @track selectItemCount;
   
    connectedCallback(){
       // this.searchString = ' 0 Option Selected';
        this.showDropdown= false;
        console.log('Payload :', this.payload.options);
        if(this.payload.isSearch == true && this.payload.multiselect == true){
            fetchRecord(
                {qry : 'SELECT ' + this.payload.fields + ' FROM ' + this.payload.object + ' LIMIT ' + this.payload.noOfRecords }
                //+ ' WHERE ' + this.payload.searchField + ' LIKE \'' + this.payload.search + '\'' +' LIMIT ' + this.payload.noOfRecords
                
            )
            .then(result =>{
                console.log('Result is :', result);
                console.log('NAme is :', result.Name);
                let res =[];
                for(var i=0; i<result.length; i++){
                    res.push({ label : result[i].Name, value : result[i].Name } );
                }
                this.dropdownopt = res;
            })
            .catch(error =>{
                console.log('Fetch Record Error :', error);
            });

        }else{
            this.dropdownopt= [{label : this.payload.options[0] , value : this.payload.options[0]},
                {label : this.payload.options[1] , value : this.payload.options[1]},
                {label : this.payload.options[2] , value : this.payload.options[2]},
            ];
            this.value = this.payload.options[0];                
            console.log('Dropdown options :', this.dropdownopt);
            //console.log("No Record Found");
        }


    }
    showOptions(){
        console.log('hii from showOptions');   
        //this.searchString = '';
        //this.searchString = ' 0 Option Selected';
        var options = JSON.parse(JSON.stringify(this.dropdownopt));
        console.log('Options :', options);
        for(var i = 0; i < options.length; i++) {
            options[i].isVisible = true;
        }
        if(options.length > 0) {
            this.showDropdown = true;
        }
        this.dropdownopt = options;
        
       
    }
   
    selectItem(event){
       
        //this.showDropdown = true;
      
        console.log('Hii from selctItem');
        var selectedVal = event.currentTarget.dataset.id;
        console.log('Selected VAlue :', selectedVal);

        
        let record = this.dropdownopt;
        console.log('Record Value :', record);
        let count = 0;
        for(var i = 0; i < this.dropdownopt.length; i++) {
            if(this.dropdownopt[i].value == selectedVal) {
               this.dropdownopt[i].Selected = true;
            }
            if(this.dropdownopt[i].Selected) {
                count++;
            }
        }
        console.log('Record!!!!!!!!!!', this.dropdownopt);
        let cnt = count;
        console.log('SElected Option count :', cnt);
        this.searchString = count+ " item Selected";
        // this.showDropdown = true;
        console.log('Input String :', this.searchString);

        // Create Event  
        let ev = new CustomEvent('selectoption', {
                detail:selectedVal
        });
        // Dispatches the event.
        this.dispatchEvent(ev);

       
     
    }
    handleBlur(){
        console.log('handleBlur Method called');

       
        if(this.show){
            console.log('if---------');
            this.showDropdown = true;
            const inputBox = this.template.querySelector('lightning-input');
            console.log('Lightning Input !!!!!!!!!!!' , inputBox);
            inputBox.focus();
            
        }else{
            console.log('False---------');
            this.showDropdown = false;
        }
      
    }
    handleMouseOut(){
        console.log('Call MouseOut');
        this.show= false;
        
    }
 
    handleMouseIn(){
        console.log('call mouseIn');
        this.show = true;
    }

    
   

    filterOptions(event){
        console.log('call filterOptions');
        this.searchString = event.target.value;
        console.log('Search String :', this.searchString);
       
        fetchRecord(
            {qry : 'SELECT ' + this.payload.fields + ' FROM ' + this.payload.object + ' WHERE ' + this.payload.searchField + ' LIKE \'' + this.searchString + '%\'' +' LIMIT ' + this.payload.noOfRecords }
            
        )
        .then(result =>{
            console.log('Filter Option REsult :', result);
           this.dropdownopt = result;
           if(this.searchString  && this.searchString.length >0){
                var flag = true;
                let filterList = [];
                for(var i=0; i<result.length; i++){
                    filterList.push({label : result[i].Name, value : result[i].Name });
                }
               
                this.dropdownopt = filterList;
           }
           
            
        })
        .catch(error =>{
            console.log('Filter Option error :', error);
        });

    }

    closePill(event){
        let pillToRemove = event.target.name;
        console.log('Pill to remove :', pillToRemove);
        console.log('Selected item length :', this.dropdownopt.length);
        for(var i=0; i<this.dropdownopt.length; i++){
            console.log('for part');
            console.log('Dropdown Options!!!!!!', this.dropdownopt[i].value);
            if(this.dropdownopt[i].value == pillToRemove){
                console.log('if---');
                this.dropdownopt[i].Selected = false;
                this.dropdownopt.splice(this.dropdownopt.indexOf(pillToRemove),1);
            
                
            }
           
            // if(this.dropdownopt[i].Selected) {
            //     count++;
            // }
        }
        

        // this.searchString = count+ " item Selected";
        // console.log('Input String :', this.searchString);

    }
     
    handleChange(event){

        // var selectedVal = event.currentTarget.dataset.id;
        // this.selectedValue = selectedVal;
        console.log('Single select combobox !!!!!!!!!!!!!!!!!!!!!!!1');
    }
}



 // handleMouseOut(){
    //     this.showDropdown = false;
    // }
 
    // handleMouseIn(){
    //     this.showDropdown = true;
    // }

    // handleChange(event){

    //     var selectedVal = event.currentTarget.dataset.id;
    //     this.selectedValue = selectedVal;
    //     console.log('Value :', val);
    // }