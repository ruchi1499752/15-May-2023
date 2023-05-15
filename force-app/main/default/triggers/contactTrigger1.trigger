trigger contactTrigger1 on Contact (after insert, after delete) {
    
    
    list<Contact> apptsToUpdate=new list<Contact>();
    Set<Id> acctIds = new Set<Id>();
    list<Account> listAccountContact = new list<Account>();
    
    if(Trigger.isInsert){
        for(Contact con : Trigger.new){
            acctIds.add(con.AccountId);
            System.debug(acctIds);
        }
        //Query Related Records : 
        if(acctIds.size() > 0){
            listAccountContact=[SELECT ID, Name, (SELECT Id, LastName, AccountId, Sequence_Number__c FROM Contacts) FROM Account Where Id IN :acctIds];
            system.debug(listAccountContact);
        }
        
        system.debug(listAccountContact.size());
        
        
        if(listAccountContact.size() >0){
            for(Account acc: listAccountContact){
                system.debug(acc);
                decimal sqno = 0;
                system.debug(acc.contacts);
                for(Contact con: acc.contacts){
                    sqno = con.Sequence_Number__c = sqno + 1;
                    System.debug(con.Sequence_Number__c);
                    apptsToUpdate.add(con); 
                    
                    //sqno++;
                }
            }
            System.debug('List to update ' + apptsToUpdate);
            UPDATE apptsToUpdate;
         }
    }
    
    
    
    Map<id,List<Contact>> accConMap = new Map<id,List<Contact>>();
    if(listAccountContact.size() >0){
        for(Account acc :listAccountContact){
            accConMap.put(acc.id,acc.contacts);
        }
    }
    System.debug(accConMap);
    
    
    if(Trigger.isDelete){
        
        for(Contact con : Trigger.old){
            acctIds.add(con.AccountId);
            System.debug(acctIds);
        }
        if(acctIds.size() > 0){
            listAccountContact=[SELECT ID, Name, (SELECT Id, LastName, AccountId, Sequence_Number__c FROM Contacts) FROM Account Where Id IN :acctIds];
            system.debug(listAccountContact);
        }
        if(listAccountContact.size() >0){
            for(Account acc: listAccountContact){
               for(Contact con: acc.contacts){
                   Contact delCon = [Select id, Name, Sequence_Number__c from contact where id in : Trigger.old];
                   System.debug(delcon);
                   if(con.Sequence_Number__c > delCon.Sequence_Number__c){
                       con.Sequence_Number__c = delCon.Sequence_Number__c-1;
                   }
                    
                    apptsToUpdate.add(con); 
                    
                    //sqno++;
                }
            }
            System.debug('List to update ' + apptsToUpdate);
            UPDATE apptsToUpdate;
        }
        
        
        
        
    }
    
}