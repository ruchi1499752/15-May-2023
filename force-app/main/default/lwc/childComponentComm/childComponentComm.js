import { LightningElement } from 'lwc';
//import Detail from '../bikeCard/LWC-Basics-Bike-Selector-Trailhead/detail/detail';

export default class ChildComponentComm extends LightningElement {
    //Pass value from child to parent using custom event
    search;
    handleChange(event){
        this.search = event.target.value;
        console.log('Search Value : ' , this.search);

        //create Event
        const searchEvent = new CustomEvent("getsearchvalue", {detail : this.search});
        //Dispatches the Event
        this.dispatchEvent(searchEvent);

        
    }
}