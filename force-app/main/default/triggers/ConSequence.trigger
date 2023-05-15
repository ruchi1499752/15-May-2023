trigger ConSequence on Contact (after insert, after delete, after undelete, after update){  // Specifying the event
    
    if(Trigger.isAfter){            // context variables
        if(Trigger.isInsert){       // context variables
            Triggerhandler.handelInsertCases(Trigger.new);  //calling apex class method
        }
        if(Trigger.isDelete){
            Triggerhandler.handelDeleteCase(Trigger.old);
        }
        if(Trigger.isUndelete){
            Triggerhandler.handelUndeleteCase(Trigger.new);
        }
        if(Trigger.isUpdate){
            if(Triggerhandler.isFirstTime){
                Triggerhandler.isFirstTime = false;
                Triggerhandler.handelUpdateCase(Trigger.new,Trigger.old, Trigger.oldMap);
            }
            
        }
    }    
    
    
}