trigger beforeInsertAccountRec on Account(before insert){
    AccountHandlerClass.beforeInsertAccount(Trigger.New);
    /*for(Account acc : Trigger.New){
        if(acc.Name == 'Ruchi'){
            acc.Phone = '123456789';
        }
    }*/
}