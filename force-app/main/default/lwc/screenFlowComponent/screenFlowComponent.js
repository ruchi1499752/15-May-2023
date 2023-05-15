import { LightningElement , track,api} from 'lwc';
import getCase from '@salesforce/apex/ScreenFlowController.getCase';
//import updateCaseRecord from '@salesforce/apex/ScreenFlowController.updateCaseRecord';
import getCaseOrigin from '@salesforce/apex/ScreenFlowController.getCaseOrigin';

const columns = [
    // { label: 'Case Id', fieldName: 'Id', type:'text' },
    { label: 'Case Number', fieldName: 'CaseURL' ,sortable: true, type:'url',  typeAttributes : { label: { fieldName: 'CaseNumber' },target: '_blank'}},
    { label: 'Subject', fieldName: 'Subject', type:'text'},
    { label: 'Parent Case', fieldName: 'ParentId'},
    { label: 'Web Email', fieldName: 'SuppliedEmail', type:'email'},
    { label: 'Case Origin', fieldName: 'Origin', editable: true},
    
];
export default class ScreenFlowComponent extends LightningElement {
    @api recordId;
    @api caseRecord;
    @api parentRecord = [];
    @api parentOrigin;
    @api ParentWebEmail;
    @api updateCaseOrigin;
    @api selectedRow;
    @api isSelect;
    @api parentCaseNumber;
    
    @track checkParent ;
    @track data = [];
    @track columns = columns;

    connectedCallback(){
        console.log('Record id :' , this.recordId);
        getCase({recId : this.recordId})
        .then(result =>{
            this.data= result;
            console.log('Records List : ' , JSON.parse(JSON.stringify(this.data)));
            
            let res = [];
            res = this.data;
            res.forEach(b => {
                if(b.Id == this.recordId){
                    let index = res.findIndex(item => item.Id == this.recordId);
                    res.splice(index,1);
                    console.log('RecordId :', b.Id);
                    console.log('Res :' , res);
                }
                this.data = res;
            });

            this.caseRecord = this.data;
            if(this.caseRecord){
                this.caseRecord.forEach(item => item['CaseURL'] ='/lightning/r/Case/' +item['Id'] +'/view');
            }

        })
        .catch(error =>{
            console.log('Error :' , error);
        })
    }

    selectedRows(event){
        var SelectedRows = event.detail.selectedRows;
        console.log('ARRR :', SelectedRows);

        this.selectedRow = SelectedRows;
        console.log('Size :' , this.selectedRow);
        console.log('Length !!!' , this.selectedRow.length);
        if(this.selectedRow.length > 0){
            this.isSelect = true;
        }
        else{
            this.isSelect = false;
        }
        let parentId = JSON.parse(JSON.stringify(SelectedRows));
        console.log('Parent Id :' , parentId[0].Id);
        this.parentRecord = parentId[0].Id;
        this.parentOrigin = parentId[0].Origin;
        this.ParentWebEmail = parentId[0].SuppliedEmail;
        this.parentCaseNumber = parentId[0].CaseNumber;
        let newOrigin = this.updateCaseOrigin;
        console.log('Update case Origin :' , newOrigin);
    }
}

//https://niksdeveloper.com/salesforce/custom-link-in-lwc-datatable/#:~:text=In%20order%20to%20add%20custom,display%20it%20as%20a%20Link.