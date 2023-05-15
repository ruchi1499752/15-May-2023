public class TriggerHelper {
    public static void  processContact(Set<id> accIds ,List<Contact> ValidContactList, List<Contact>oldContactList, List<Contact>invalidContactList){
        
         List<Contact> contactsToUpdate = new List<Contact>();
         List<Contact> allContacts = [Select Accountid, Id, LastName,Sequence_Number__c FROM contact where AccountId in : accIds ORDER BY Sequence_Number__c];
         System.debug('Size of oldContactList '+ oldContactList.size());
        
        for(Id ids : accIds){
            
            Map<Decimal, Contact> contactMap = new Map<Decimal, Contact>();
            
            for(Contact con : ValidContactList){
                if(con.AccountId == ids){
                    if(contactMap.containsKey(con.Sequence_Number__c)){
                        Contact tempcon = con;	//2nd contact : con2, 3rd contact : con 3
                        System.debug(tempcon);
                        
                        for(integer i =(integer) con.Sequence_Number__c ; i<=allContacts.size(); i++){
                            System.debug(i);
                            if(contactMap.containsKey(i)){
                                Contact temp = contactMap.get(i);	//	1,con1,|| 2,con2
                                system.debug(temp);
                            	temp.Sequence_Number__c +=1;		//con1,seq = 2 || con2,seq = 3||
                            	contactMap.put(i,tempcon);			// 1,con2, seq = 1||2, con1, seq= 2 ||
                                System.debug(contactMap);
                           		tempcon = temp;						// tempcon = con1,seq= 2;
                                system.debug(tempcon);
                            }
                            else{
                                contactMap.put(i,tempcon);
                                System.debug(contactMap);
                                break;
                            }
                        }
                        
                       //shifting
                     }else{
                        contactMap.put(con.Sequence_Number__c,con);
                    }
                }
            }
            for(Contact oldCon : oldContactList){
                if(oldCon.AccountId == ids){
                    decimal seq = oldCon.Sequence_Number__c;
                    if(seq == null || seq == 0){
                        seq = 1;
                        oldCon.Sequence_Number__c = seq;
                        
                    }
                    //System.debug('--' + seq);
                    if(contactMap.containsKey(seq)){
                        //System.debug('Seq number for del ' + seq);
                        while(contactMap.containsKey(seq)){
                            seq++;
                           // System.debug(seq);
                            
                        }
                        oldCon.Sequence_Number__c = seq;
                        contactMap.put(oldCon.Sequence_Number__c, oldCon);
                        
                    }else{
                        contactMap.put(oldCon.Sequence_Number__c, oldCon);
                    }
                }
            }
            for(Contact invalidCon : invalidContactList){
                //System.debug('undelete Seq ' + invalidCon.Sequence_Number__c);
                 if(invalidCon.AccountId == ids){
                     decimal seq =  1;
                     invalidCon.Sequence_Number__c = seq;
                     if(contactMap.containsKey(invalidCon.Sequence_Number__c)){
                         //put on vacant place in map
                         while(contactMap.containsKey(seq)){
                             seq++;
                         }
                         invalidCon.Sequence_Number__c = seq;
                         contactMap.put(invalidCon.Sequence_Number__c, invalidCon);
                      	 System.debug(contactMap);
                        
                     }
                    else{
                        contactMap.put(invalidCon.Sequence_Number__c, invalidCon);
                        System.debug(contactMap);
                    }
                }
            }

           /* for(Decimal c :contactMap.keySet()){
                contactsToUpdate.addAll(contactMap.get(c));
                System.debug(contactsToUpdate);
            }*/            
            contactsToUpdate.addAll(contactMap.values());
            update contactsToUpdate;
           	contactMap.clear();
            contactsToUpdate.clear();
            
        }
        
    }
}