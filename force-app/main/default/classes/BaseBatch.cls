public abstract class BaseBatch implements Database.Batchable<SObject>, Database.Stateful {
    protected String params;
    protected Id queueRecordId;
    protected Boolean hasError = false;
    protected String errorMessage;

    public BaseBatch(String params, Id queueRecordId) {
        this.params = params;
        this.queueRecordId = queueRecordId;
    }

    // Child classes implement their own start() and execute()

    public virtual void finish(Database.BatchableContext bc) {
        // Update queue record on completion
        BatchQueueService.markJobComplete(queueRecordId, hasError, errorMessage);

        // Trigger orchestrator to pick next job
        BatchOrchestrator orchestrator = new BatchOrchestrator();
        Database.executeBatch(orchestrator, 1);
    }
}