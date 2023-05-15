@isTest
public with sharing class PaymentGatewayIntegrationController_Test {
    @isTest
    public static void payByCheck_Test(){
        Test.setMock(HttpCalloutMock.class, new PaymentGatewayIntegrationMockClass());
         test.startTest();
         PaymentGatewayWrapper res = PaymentGatewayIntegrationController.payByCheck('021000021', '111111111', 'Demo');
       	 //System.assertEquals(expected, actual)
       	 System.assertEquals(res.transactionResponse.messages[0].description='This transaction has been approved', 'This transaction has been approved');	
        test.stopTest();
    }
     @isTest
    public static void payByCreditCard_Test(){
        Test.setMock(HttpCalloutMock.class, new PaymentGatewayIntegrationMockClass());
        test.startTest();
        PaymentGatewayWrapper res= PaymentGatewayIntegrationController.payByCreditCard('370000000000002', '2023', '01', 'R');
      	System.assertEquals(res.transactionResponse.messages[0].description='This transaction has been approved', 'This transaction has been approved');		  	
      	test.stopTest();
    }
}