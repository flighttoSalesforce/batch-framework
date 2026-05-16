public with sharing class BatchQueueService {
    public static BatchQueueService instance;
    public BatchQueueService() {}

    public static BatchQueueService getInstance(){
        if (instance == null) {
            instance = new BatchQueueService();
        }
        return instance;
    }

    public void enqueueJob () {
        BatchFrameworkSelector selector = BatchFrameworkSelector.getInstance();
        List<BatchFramework__c> batchClassesToRun = selector.getValidBatchClassDetails();

        for (BatchFramework__c batchClass : batchClassesToRun) {
            try {
                Type t = Type.forName(batchClass.BatchClassName__c);
                if (t != null && IBatchJob.class.isAssignableFrom(t)) {
                    IBatchJob batchJobInstance = (IBatchJob) t.newInstance();
                    String params = ''; // Set params as needed
                    Id queueRecordId = batchJobInstance.execute(params);
                    System.debug('Enqueued job with Queue Record Id: ' + queueRecordId);
                } else {
                    System.debug('Class ' + batchClass.BatchClassName__c + ' does not implement IBatchJob');
                }
            } catch (Exception e) {
                System.debug('Error enqueuing job for class ' + batchClass.BatchClassName__c + ': ' + e.getMessage());
            }
        }
    }

    public void calculateNextBatchExecutionTime(Id batchFrameworkRecordId) {
        // Logic to calculate and update the next execution time for the batch job
        // This can be based on a fixed interval, cron expression, or any custom logic
        
    }
}