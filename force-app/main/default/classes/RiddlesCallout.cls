public class RiddlesCallout {
    @AuraEnabled
    public static String makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://riddles-api.vercel.app/random');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        String responseBody = response.getBody();
        Integer statusCode = response.getStatusCode();
        
        if (statusCode == 200) {
            return responseBody;
        } else {
            String errorMessage;
            switch on statusCode {
                when 400 {
                    errorMessage = 'Bad Request';
                }
                when 404 {
                    errorMessage = 'Not Found';
                }
                when 500 {
                    errorMessage = 'Internal Server Error';
                }
                when else {
                    errorMessage = 'Unexpected Error';
                }
            }
            System.debug('Error ' + statusCode + ': ' + errorMessage);
            return '{"error": "' + errorMessage + '"}';
        }
    }
}
