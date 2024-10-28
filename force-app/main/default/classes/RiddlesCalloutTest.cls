@isTest
private class RiddlesCalloutTest {
    
    @isTest
    static void testGetCalloutSuccess() {
        Test.setMock(HttpCalloutMock.class, new RiddlesHttpCalloutMock(200));
        String response = RiddlesCallout.makeGetCallout();
        
        String expectedValue = '{"riddle": "What relation would your father\'s sister\'s sister-in-law be to you?","answer": "This person would be your mother"}';
        Assert.areEqual(expectedValue, response, 'The body response must match the expected value');
    }
    
    @isTest
    static void testGetCalloutBadRequest() {
        Test.setMock(HttpCalloutMock.class, new RiddlesHttpCalloutMock(400));
        String response = RiddlesCallout.makeGetCallout();
        
        String expectedError = '{"error": "Bad Request"}';
        Assert.areEqual(expectedError, response, 'The body response must be a bad request error');
    }
    
    @isTest
    static void testGetCalloutNotFound() {
        Test.setMock(HttpCalloutMock.class, new RiddlesHttpCalloutMock(404));
        String response = RiddlesCallout.makeGetCallout();
        
        String expectedError = '{"error": "Not Found"}';
        Assert.areEqual(expectedError, response, 'The body response must be a not found error');
    }
    
    @isTest
    static void testGetCalloutInternalServerError() {
        Test.setMock(HttpCalloutMock.class, new RiddlesHttpCalloutMock(500));
        String response = RiddlesCallout.makeGetCallout();
        
        String expectedError = '{"error": "Internal Server Error"}';
        Assert.areEqual(expectedError, response, 'The body response must be an internal server error');
    }
    
    @isTest
    static void testGetCalloutUnexpectedError() {
        Test.setMock(HttpCalloutMock.class, new RiddlesHttpCalloutMock(105));
        String response = RiddlesCallout.makeGetCallout();
        
        String expectedError = '{"error": "Unexpected Error"}';
        Assert.areEqual(expectedError, response, 'The body response should indicate an unexpected error');
    }
}