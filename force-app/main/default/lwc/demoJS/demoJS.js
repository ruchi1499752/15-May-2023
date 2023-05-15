import { LightningElement } from 'lwc';

export default class Demo extends LightningElement {
    //text = 'This text is come from js prop';
    text = '';
    handleChange(event){
        this.text = event.target.value;
     }
}