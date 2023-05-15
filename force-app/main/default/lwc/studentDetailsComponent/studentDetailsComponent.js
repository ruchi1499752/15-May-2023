import { LightningElement,track } from 'lwc';
import StudentDetails from '@salesforce/apex/StudentController.StudentDetails';
export default class StudentDetailsComponent extends LightningElement {
    @track index = 1;
    @track records;
    connectedCallback(){
        StudentDetails()
        .then(result =>{
            console.log('Result Is :', result);
            console.log('==>', result[0].Name);
            this.records = result;
        })
        .catch(error =>{
            console.log('Error :' , error);
        });

    }
}