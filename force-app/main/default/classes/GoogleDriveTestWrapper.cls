public class GoogleDriveTestWrapper {
    public class GoogleDriveData{
        @AuraEnabled public List<files> files;
    }
	 public class files{
        @auraEnabled public String Id;	
        @auraEnabled public String name;
        @auraEnabled public String mimeType;
        
	}
}