public class CreditCheckAC {
	@AuraEnabled
    public static void updateCreditCheck(){
        
    }

    @AuraEnabled
    public static boolean createNewCaseForAccount(ID accID){
        return false;
    }

    @AuraEnabled
    public static boolean openCaseExist(string accID){
        Id devRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Credit Check').getRecordTypeId();
        List<Case> currentAccountCases = [SELECT Status FROM Case WHERE RecordTypeId = :devRecordTypeId AND AccountId = :accID AND Status != 'Closed'];

        if(currentAccountCases==NULL){
                return false;
        }
        if(currentAccountCases.isEmpty()){
            return false;
        } else {
            return true;
        }        
    }
}