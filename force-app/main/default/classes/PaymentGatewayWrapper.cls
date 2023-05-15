public with sharing class PaymentGatewayWrapper {
    public PaymentGatewayWrapper() {

    }
    //@auraEnabled public messages msg;
    @auraEnabled public EcheckResponse transactionResponse;
    public class EcheckResponse{
        @auraEnabled public String transId;
        @auraEnabled public List<messages> messages;
        @auraEnabled public List<errors> errors;
    }
    public class messages{
        @auraEnabled public String code;
        @auraEnabled public String description;
    }
    public class errors{
        @auraEnabled public string errorCode;
        @auraEnabled public String errorText;
    }
}