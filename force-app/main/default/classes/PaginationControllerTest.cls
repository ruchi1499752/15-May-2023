@isTest
public class PaginationControllerTest {
    
    
    @isTest static void testFields(){
        PaginationController ob = new PaginationController();
        ob.selectedObject = 'Account';
        ob.fieldNames();
        System.assert(ob.fnsoption.contains(new SelectOption('accountnumber', 'Account Number')));
    }
    @isTest static void testAddFields(){
        PaginationController ob = new PaginationController();
        //ob.sfields= new List<String>();
        ob.selectedObject = 'Account';
        //ob.fieldMap = new Map<String,Schema.SobjectField>();
        ob.fieldNames();
        ob.sfields.add('accountnumber');
        System.debug(ob.sfields);
        ob.addFields();
        System.debug(ob.fsoption);
        System.assert(ob.fsoption.contains(new SelectOption('accountnumber', 'Account Number')));
    }  
    
    @isTest static void testRemoveFields(){
        PaginationController ob = new PaginationController();
        ob.selectedObject = 'Account';
        ob.fieldNames();
        
        ob.rfields.add('accountnumber');
        //system.debug(ob.rfields);
       	ob.removeFields();
        
        System.assert(ob.fnsoption.contains(new SelectOption('accountnumber', 'Account Number')));
        
    }
    
    @isTest static void testResetButton(){
        PaginationController ob = new PaginationController();
        ob.reset();
    }
    
    @isTest static void testShowData(){
        PaginationController ob = new PaginationController();
        ob.showData();
    }
    @isTest static void testDisableAddButton(){
       	PaginationController ob = new PaginationController();	
         ob.fnsoption = new List<SelectOption>();
        
        //Boolean test = ob.getdisableAddButton();
        System.assertEquals(ob.getdisableAddButton(), true);
    }
    @isTest static void testDisableAddButton1(){
       	PaginationController ob = new PaginationController();	
         ob.fnsoption = new List<SelectOption>();
        ob.fnsoption.add(new SelectOption('Name','Name'));
        //Boolean test = ob.getdisableAddButton();
        System.assertEquals(ob.getdisableAddButton(), false);
    }
    
  
    @isTest static void testdisableRemoveButton(){
         PaginationController ob = new PaginationController();	
         System.assertEquals(ob.getdisableRemoveButton(), true);
       
    }
    @isTest static void testdisableRemoveButton1(){
         PaginationController ob = new PaginationController();	
        ob.fsoption = new List<SelectOption>();
        ob.fsoption.add(new SelectOption('Name','Name'));
         System.assertEquals(ob.getdisableRemoveButton(), false);
       
    }
    
    @isTest static void testDisableProcessButton(){
         PaginationController ob = new PaginationController();
         System.assertEquals(ob.getdisableProcessButton(), true);   
    }
    @isTest static void testDisableProcessButton1(){
         PaginationController ob = new PaginationController();
         ob.fsoption = new List<SelectOption>();
        ob.fsoption.add(new SelectOption('Name','Name'));	
         System.assertEquals(ob.getdisableProcessButton(), false);
    }
}