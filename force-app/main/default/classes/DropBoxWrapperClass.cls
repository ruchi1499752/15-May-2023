public with sharing class DropBoxWrapperClass {
    public DropBoxWrapperClass() {

    }
    public class AccessTokenWrapper{
        @auraEnabled public String access_token;
        @auraEnabled public String refresh_token;
        @auraEnabled public Integer expires_in;
        @auraEnabled public String token_type;
        @auraEnabled public String scope;

    }
    public class DropBoxData{
        @AuraEnabled public List<entries> entries;
    }
    public class entries{
        @auraEnabled public String tag;	//folder
        @auraEnabled public String name;	//Images
        @auraEnabled public String path_lower;	///images
        @auraEnabled public String path_display;	///Images
        @auraEnabled public String id;	//id:rc4S8MISSMAAAAAAAAAABw
        @AuraEnabled public boolean is_downloadable;
	}

    public class DownloadFileWrapperClass{
        @AuraEnabled public String link;


    }
    // public class DownloadFileMetadata{
    //     @AuraEnabled public boolean is_downloadable;
    // }
}