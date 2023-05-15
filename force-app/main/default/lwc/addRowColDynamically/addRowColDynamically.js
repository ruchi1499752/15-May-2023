import { LightningElement } from 'lwc';

export default class AddRowColDynamically extends LightningElement {
    // data = [];

    // addRow() {
    //     this.data.push({"name" : "Ruchi"});
    // }

    // addColumn() {
    //     this.columns.push({
    //         label: 'New Column',
    //         fieldName: 'newColumn',
    //         type: 'text'
    //     });
    // }

    data = [];
    connectedCallback() {
        // Initialize the data array with default values
        this.data = [
            { column1: 'A1', column2: 'B1', column3: 'C1' },
            { column1: 'A2', column2: 'B2', column3: 'C2' },
            { column1: 'A3', column2: 'B3', column3: 'C3' }
        ];
        // Call the method to update the table
        //this.updateTable();
    }
    

addRow() {
    // Create a new row object with default values
    let newRow = {
        column1: '',
        column2: '',
        column3: ''
    };
    // Push the new row object to the data array
    this.data.push(newRow);
    // Call the method to update the table
    //this.updateTable();
}

addColumn() {
    // Get a reference to the table
    let table = document.getElementById('myTable');
    // Create a new column header
    let newHeader = document.createElement('th');
    newHeader.innerText = 'New Column';
    // Add the new header to the table
    table.querySelector('thead tr').appendChild(newHeader);
    // Loop through the data and add a new property to each row object
    for (let i = 0; i < this.data.length; i++) {
        this.data[i]['newColumn'] = '';
        console.log('data ::' , this.data);
    }
    // Call the method to update the table
   // this.updateTable();
}

// updateTable() {
//     // Get a reference to the table body
//     let tbody = document.querySelector('#myTable tbody');
//     // Clear the existing rows
//     tbody.innerHTML = '';
//     // Loop through the data and add a new row for each object
//     for (let i = 0; i < this.data.length; i++) {
//         let row = document.createElement('tr');
//         row.innerHTML = `
//             <td>${this.data[i].column1}</td>
//             <td>${this.data[i].column2}</td>
//             <td>${this.data[i].column3}</td>
//         `;
//         tbody.appendChild(row);
//     }
// }

    
}