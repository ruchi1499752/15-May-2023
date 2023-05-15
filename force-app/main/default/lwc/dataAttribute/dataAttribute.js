import { LightningElement , track} from 'lwc';

export default class DataAttribute extends LightningElement {
    val;
    nm;
    dataName ;
    


    handleOnClick(event){
        console.log('INSIDE HANDLECLICK');
       this.val = event.target.value;
        //this.username = event.currentTarget.dataset.name;
        console.log('username : ', this.val);
        this.nm = event.target.name;
        console.log('NM : ', this.nm);

        this.dataName = event.currentTarget.dataset.ruh;
        console.log('Data Name :' , this.dataName);
        console.log('event.target.dataset ::', JSON.stringify(event.target.dataset));
        console.log('event.target.dataset ::', JSON.stringify(event.target.dataset.ruh));

        console.log('Event.currentTarget.dataset :' , JSON.stringify(event.target.dataset));









    }
}