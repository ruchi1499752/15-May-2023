public class GoogleDriveTest {
   
   public static void getAllFolders(){
       HttpRequest req = new HttpRequest();
       req.setEndPoint('callout:Google_Drive/files');
       req.setMethod('GET');
       Http http = new Http();
       HTTPResponse res = http.send(req);
       //System.debug(res.getBody());
       String result = res.getBody();
       //System.debug('BODY :' + result);
       GoogleDriveTestWrapper.GoogleDriveData ans = (GoogleDriveTestWrapper.GoogleDriveData)JSON.deserialize(result, GoogleDriveTestWrapper.GoogleDriveData.class);
       System.debug('Wrapper Result :' + ans);
       System.debug('Wrapper Result :' + ans.files);
       System.debug('Size :' + ans.files.size());
       System.debug('Wrapper Result :' + ans.files[0].name);
       /*for(GoogleDriveTestWrapper.files r : ans.files){
           //System.debug('ID ::: '+ r.Id);
           System.debug('NAME :::' + r.name);
           //System.debug('mimeType :::' + r.mimeType);
           if(r.mimeType == 'application/vnd.google-apps.folder'){
               
               System.debug('Folder Name :'+ r.name);
           }
       }*/
      /*Map<Id, String> folder = new Map<Id, String>();
       Map<Id, String> file = new Map<Id, String>();
       for(Integer i=0; i<ans.files.size(); i++){
           if(ans.files[i].mimeType == 'application/vnd.google-apps.folder'){
               folder.put(ans.files[i].Id, ans.files[i].name);
               
           }else{
               file.put(ans.files[i].Id, ans.files[i].name);
             
           }
        }*/
       Map<String, String> folder = new Map<String, String>();
       Map<String, String> file = new Map<String, String>();
       for(Integer i=0; i<ans.files.size(); i++){
           if(ans.files[i].mimeType == 'application/vnd.google-apps.folder'){
               folder.put(ans.files[i].Id, ans.files[i].mimeType);
               
           }else{
               file.put(ans.files[i].Id, ans.files[i].mimeType);
             
           }
        }
       
       System.debug('Folder Size :' + folder.size());
       System.debug('Folders :' + folder);
       System.debug('File Size :' + file.size());
   }
}