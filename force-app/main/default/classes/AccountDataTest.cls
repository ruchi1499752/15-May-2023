@isTest
public with sharing class AccountDataTest {
    public AccountDataTest() {

    }
    @isTest static void AccountDataTest(){
        Account acc = new Account(Name = 'Acc1');
        Insert acc;
        List<Account> result = AccountRecords.AccountData();
        System.debug('result' + result);
        System.assertEquals(result[0].Id, acc.Id);

    }
}