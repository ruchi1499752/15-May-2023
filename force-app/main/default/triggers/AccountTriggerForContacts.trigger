trigger AccountTriggerForContacts on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        System.debug('Trigger Run');
        System.enqueueJob(new ContactCreationQueueable(Trigger.New));
    }	
}