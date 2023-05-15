public with sharing class DropboxMockClass implements HttpCalloutMock{

    public HTTPResponse respond(HTTPRequest req) {
        //String method = req.getMethod();
        //System.debug('Method is ' + method);
        //String endPoint = req.getEndpoint();
        // Optionally, only send a mock response for a specific endpoint and method.

         // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        //req.setBody('{"example" : "test"}');

        if(req.getEndpoint() == 'https://api.dropboxapi.com/oauth2/token'){
            System.debug('call Mock Class');
           	res.setBody('{"example" : "test"}');
            res.setStatusCode(200);
			//String body = ('{"code" : "8NyoAAAAAAAAAXIGYdYrFVw5J_coeVIuDkoo", "client_id" : "td2c997d9rausam", "client_secret": "m1vkd6gkwwgdy2g", "redirect_uri" : "https://drive-integration-developer-edition.ap27.force.com/s/dropbox","grant_type":"authorization_code"}');
       }
        else if(req.getEndpoint() == 'https://api.dropboxapi.com/oauth2/token'){
           	//String body= ('{"refresh_token" : "OGs86qhHlYcAAAAAAAAAAWQBYFt5LGnQpp7LQFxbtYyyp5EIwb8JeWJkPxzqoDe3","client_id" : "td2c997d9rausam", "client_secret" : "m1vkd6gkwwgdy2g", "grant_type" :"refresh_token"}');
            //res.setBody(body);
            res.setBody('{"example" : "test"}');
            res.setStatusCode(200);
            
           
        }
        else if(req.getEndpoint() == 'https://api.dropboxapi.com/2/files/list_folder'){
            res.setBody('{"entries": [{".tag": "folder", "name": "Images", "path_lower": "/images", "path_display": "/Images", "id": "id:rc4S8MISSMAAAAAAAAAABw"}, {".tag": "folder", "name": "Lightshot", "path_lower": "/lightshot", "path_display": "/Lightshot", "id": "id:rc4S8MISSMAAAAAAAAAADg"}]}');
            res.setStatusCode(200);
        }
        else if(req.getEndpoint() == 'https://api.dropboxapi.com/2/files/create_folder'){
            res.setBody('{"name": "LWC", "path_lower": "/lwc", "path_display": "/LWC", "id": "id:rc4S8MISSMAAAAAAAAAAVw"}');
            res.setStatusCode(200);
        }
        else if(req.getEndpoint() == 'https://api.dropboxapi.com/2/files/delete_v2'){
            res.setBody('{"metadata": {".tag": "folder", "name": "LWC", "path_lower": "/lwc", "path_display": "/LWC", "id": "id:rc4S8MISSMAAAAAAAAAAVw"}}');
            res.setStatusCode(200);
        }
        else if(req.getEndpoint() == 'https://api.dropboxapi.com/2/files/get_temporary_link'){
            res.setBody('{"metadata": {"name": "flower2.jpg", "path_lower": "/flower2.jpg", "path_display": "/flower2.jpg", "id": "id:rc4S8MISSMAAAAAAAAAAUg", "client_modified": "2022-06-30T06:39:31Z", "server_modified": "2022-06-30T06:39:31Z", "rev": "015e2a4883f2b840000000270067f50", "size": 5391, "is_downloadable": true, "content_hash": "56faa06dbebe7d248d3db326f0de4ab210288118607c93c187a2840a240ba4f4"}, "link": "https://ucc7f8291c8868af0c4071128e2c.dl.dropboxusercontent.com/cd/0/get/BoLYZr_lwGLnwEO6VPI0W9wFCem-36y32FfGH4cqJk-ooSMR_AECx7VaH2GpVWZnqosW2NbVWriNHNzgQXn-UD-ZfWURNNbikkkVe7aQREVUF3K3uRm51o_Pec8tElkzk5UpS0PFhgkuHnH1n9M2ZaP3LNGsljJ2wkZaAGFoGyhuQq0lCDlK5YhAIB4CpN4WSe8/file"}');
            res.setStatusCode(200);
        }   
        else if(req.getEndpoint() == 'https://content.dropboxapi.com/2/files/upload'){
            res.setBody('{"name": "Screenshot_2.png", "path_lower": "/screenshot_2.png", "path_display": "/Screenshot_2.png", "id": "id:rc4S8MISSMAAAAAAAAAAgw", "client_modified": "2022-07-03T05:28:46Z", "server_modified": "2022-07-03T05:28:46Z", "rev": "015e2dfe4c106460000000270067f50", "size": 24125, "is_downloadable": true, "content_hash": "1c72e7d77c2cdbea8b6e7238689366ee6ac2186e14f6b49a2a36946521669cb5"}');
        	res.setStatusCode(200);
        }
        System.debug('res??'+res);
        return res;

    }

}