public class RiddlesHttpCalloutMock implements HttpCalloutMock {
    private Integer statusCode;
    
    public RiddlesHttpCalloutMock(Integer statusCode) {
        this.statusCode = statusCode;
    }

    
    public HttpResponse respond(HttpRequest req) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        
        switch on this.statusCode {
            when 200 {
                response.setBody('{"riddle": "What relation would your father\'s sister\'s sister-in-law be to you?", "answer": "This person would be your mother"}');
            }
            when 400 {
                response.setBody('{"error": "Bad Request"}');
            }
            when 404 {
                response.setBody('{"error": "Not Found"}');
            }
            when 500 {
                response.setBody('{"error": "Internal Server Error"}');
            }
            when else {
                response.setBody('{"error": "Unexpected Error"}');
            }
        }
        
        response.setStatusCode(this.statusCode);
        return response;
    }
}