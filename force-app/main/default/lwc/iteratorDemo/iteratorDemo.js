import { LightningElement } from 'lwc';

export default class IteratorDemo extends LightningElement {
    contacts = [
        {
            id : 1,
            name : 'Ruchi',
            email : 'abc@gmail.com'
        },
        {
            id : 2,
            name : 'Nisha',
            email : 'xyz@gmail.com'
        },
        {
            id : 3,
            name : 'Ronak',
            email : 'rcb@gmail.com'
        }
    ];
}