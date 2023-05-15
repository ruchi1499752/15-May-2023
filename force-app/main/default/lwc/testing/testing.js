import { api, LightningElement } from 'lwc';

export default class Testing extends LightningElement {
    @api title;
    @api text = 'ronak';
    @api name = 'Miss Ruchi Chourasia';
    @api leadRecord = {};
    
    companies = [
        {
            "label": "Apple",
            "value": "Apple"
        },
    ];
    handleClick(){
        alert();
        console.log('Title :' , this.title);
        console.log('Text :' + this.text);
    }
}