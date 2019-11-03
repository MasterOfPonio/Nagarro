public class CreditCheckAC {
	
    public static void updateCreditCheck(){
        
    }

    @AuraEnabled
    public static void createNewCaseForAccount(ID accID,String CreditCheck,String recId){
        Case c = new Case();
        c.Accountid = accID;
        c.Type = 'ICM';
        c.Origin = 'SHIP';
        c.Status = 'New';
        c.RecordTypeId = recId;
        c.Credit_Check_Status__c = CreditCheck;
        Insert c;   
        Account currentAccount = [SELECT id,Name,Credit_Check_Status__c FROM Account WHERE id = :accID];
        currentAccount.Credit_Check_Status__c = CreditCheck;
        Update currentAccount;
    }

    @AuraEnabled
    public static boolean openCaseExist(string accID,String CreditCheck){
        Id devRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Credit Check').getRecordTypeId();
        List<Case> currentAccountCases = [SELECT Status FROM Case WHERE RecordTypeId = :devRecordTypeId AND AccountId = :accID AND Status != 'Closed'];
   
        if(currentAccountCases==NULL){
                createNewCaseForAccount(accId,CreditCheck,devRecordTypeId);
                return false;
        }
        if(currentAccountCases.isEmpty()){
            createNewCaseForAccount(accId,CreditCheck,devRecordTypeId);
            return false;
        } else {
            return true;
        }        
    }
}
