import { api, LightningElement } from 'lwc';

export default class MetaData extends LightningElement {
    @api prop;
    @api Name;
    
    connectedCallback(){
        console.log('NAme : ' , this.Name);
    }
}