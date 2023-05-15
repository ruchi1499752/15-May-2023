trigger AccountTrigger on Account (before insert) {
     /*if (Trigger.isAfter && Trigger.isInsert) {
        AccountHandler.CreateNewOpportunity(Trigger.New);
    }*/
    //, before update, before
    //delete, after insert, after update, after delete,  after undelete
    //
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.CreateAccounts(Trigger.New);
    }
}