import { LightningElement } from 'lwc';

export default class LwcLifeCycle extends LightningElement {
    connectedCallback(){
        console.log('Inside connectedCallback');
    }
    renderedCallback(){
        console.log('Inside renderedCallback');
    }
    
}