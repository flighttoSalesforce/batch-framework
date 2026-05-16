public with sharing class BatchFrameworkSelector {
    public static BatchFrameworkSelector instance;
    public BatchFrameworkSelector() {}

    public static BatchFrameworkSelector getInstance(){
        if (intance == null) {
            instance = new BatchFrameworkSelector();
        }
        return instance;
    }

    public List<BatchFramework__c> getValidBatchClassDetails(){
        DateTime currentDateTime = BatchFrameworkUtility.getInstance().getCurrentDateTime();
        return [
            SELECT 
                Id,
                BatchClassName__c
            FROM BatchFramework__c
            WHERE IsActive__c = true
            AND NextExecutionTime__c != null
            AND NextExecutionTime__c <= :currentDateTime
        ];
    }

    public BatchFramework__c getBatchFrameworkRecordById(Id recordId) {
        return [
            SELECT 
                Id,
                BatchClassName__c,
                NextExecutionTime__c
            FROM BatchFramework__c
            WHERE Id = :recordId
            LIMIT 1
        ];
    }
}