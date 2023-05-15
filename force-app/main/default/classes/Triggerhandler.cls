public class Triggerhandler{
   
    public static Boolean isFirstTime = true;
 	/** 
    * ********************************************************
    * Method to Handle Insert Cases
    * ********************************************************
    **/    

    public static void handelInsertCases(List<Contact> newConRecord){
       
       	Set<id> accIds = new Set<id>();	
        for(Contact con : newConRecord){
            accIds.add(con.AccountId);
        }
        //List<Contact> allContacts = [Select Accountid, Id, LastName,Sequence_Number__c FROM contact where AccountId in : accIds];
        //System.debug('All Contacts :' + allContacts);
        
		List<Contact> newContactList = [Select AccountId, Id,LastName, Sequence_Number__c FROM contact where Id In : newConRecord]; 
        System.debug('New Contact List : ' + newContactList);
        
        List<Contact> oldContactList = [select id, AccountId, lastname, Sequence_Number__c from contact where id NOT In: newContactList AND AccountId in : accIds];
        System.debug('old contact List : ' + oldContactList);
        
        List<Contact> validContactList = new List<Contact>();
        List<Contact> invalidContactList = new List<Contact>();
        
       	        
        integer range = oldContactList.size() + newContactList.size() ;
        System.debug('range is :' + range);
        
   
       
        // checkValidity : 
        for(Id ids : accIds){
            //System.debug(ids);
            for(Contact con : newContactList){
               // System.debug(con);
                if(con.AccountId == ids){
                    if(con.Sequence_Number__c == null || con.Sequence_Number__c <= 0 || con.Sequence_Number__c > range){
                        invalidContactList.add(con);
                        System.debug('Invalid : ' + invalidContactList);
                    }else{
                        ValidContactList.add(con);
                        System.debug('Valid : ' + validContactList);
                    }
                }
                
            }
        }
        TriggerHelper.processContact(accIds,ValidContactList,oldContactList,invalidContactList);
        
       
    }
   
	/** 
    * ********************************************************
    * Method to Handle Delete Cases
    * ********************************************************
    **/     
    public static void handelDeleteCase(List<Contact> oldConRecords){
        
      	
        Set<Id> accIds = new Set<Id>();
        
        //To store parent ids
        for(Contact delCon : oldConRecords){
            accIds.add(delCon.AccountID);
        }
        
        //Collecting all child records related to Parent records
        List<Contact> conList = [Select id, lastname,AccountId, Sequence_Number__c from Contact where Accountid in : accIds ORDER BY Sequence_Number__c];
        System.debug('Del'+conList);
        System.debug('Del'+ conList.size());
        
        for(Id ids : accIds){
            for(Contact con : conList){
                if(con.AccountId == ids){
                    con.Sequence_Number__c = 1;
               	}    
            }
           
        }
        List<Contact> tempList = new List<Contact>();
		TriggerHelper.processContact(accIds,tempList,conList,tempList);        
     }
    
    
	/** 
    * ********************************************************
    * Method to Handle Undelete Cases
    * ********************************************************
    **/
    public static void handelUndeleteCase(List<Contact> unDelRecords){
        set<id> accIds = new Set<id>();
        
        for(Contact c: unDelRecords){
            accIds.add(c.AccountId);
        }
        
        List<Contact> unDeleteList = [Select id, lastname,AccountId, Sequence_Number__c from Contact where Accountid IN : accIds AND id IN : unDelRecords ORDER BY Sequence_Number__c];
        System.debug('Del'+unDeleteList);
        
        
        List<Contact> oldContactList = [select id, AccountId, lastname, Sequence_Number__c from contact where id NOT In: unDelRecords AND AccountId in : accIds ORDER BY Sequence_Number__c];
        
       for(Id ids : accIds){
            for(Contact con : unDeleteList){
                if(con.AccountId == ids){
                    con.Sequence_Number__c = 0;
               	}    
            }
           
        }
        List<Contact> tempList = new List<Contact>();
		TriggerHelper.processContact(accIds,tempList,oldContactList,unDeleteList);
		
    }
    
    /** 
    * ********************************************************
    * Method to Handle Update Cases
    * ********************************************************
    **/
    public static void handelUpdateCase(List<Contact> newList, List<Contact>OldList, Map<Id,Contact> oldListMap){
        Set<Id> AccIds = new set<Id>();
        
        for(Contact newCon : newList){
            AccIds.add(newCon.AccountId);
             System.debug(newCon);

        }
         
        for(Contact oldCon : OldList){
            AccIds.add(oldCon.AccountId);
             System.debug(oldCon);

        }
        
        
        List<Contact> newConList = [Select id, AccountId, Sequence_Number__c from Contact where Id IN : newList ORDER BY Sequence_Number__c];
        System.debug('New List : ' + newConList);
        System.debug('Size of New List : ' + newConList.size() );
        
        List<Contact> OldConList = [select id, AccountId, lastname, Sequence_Number__c from contact where id NOT In: newList AND AccountId in : AccIds ORDER BY Sequence_Number__c];
        System.debug('Old List : ' + OldConList);
        System.debug('Size of Old List : ' + OldConList.size() );
        
        
        List<Contact> validContactList = new List<Contact>();
        List<Contact> invalidContactList = new List<Contact>();
        
       	
       integer range = OldConList.size() + newConList.size() ;
       System.debug('range is :' + range);
        
   
       
        // checkValidity : 
        for(Id ids : AccIds){
            //System.debug(ids);
            for(Contact con : newConList){
               // System.debug(con);
                if(con.AccountId == ids){
                    if(con.AccountId != oldListMap.get(con.Id).AccountId){
                    	 invalidContactList.add(con);      
                              
                    }
                    else{
                         if(con.Sequence_Number__c == null || con.Sequence_Number__c <= 0 || con.Sequence_Number__c > range){
                        	invalidContactList.add(con);
                        	System.debug('Invalid : ' + invalidContactList);
                    	}
                    
                    	else{
                       		 ValidContactList.add(con);
                        	System.debug('Valid : ' + validContactList);
                 
                    	}
                    }
                   
                }
                
            }
       		for(Contact c : OldConList){
                if(c.AccountId == ids){
                    c.Sequence_Number__c = 0;
               	}  
            }
        
        } 
        
        
        TriggerHelper.processContact(accIds,validContactList,OldConList,invalidContactList);
        
        
    }
    
    
}