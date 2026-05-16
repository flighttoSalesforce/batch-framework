public with sharing class BatchFrameworkUtility {
    public static BatchFrameworkUtility instance;
    public BatchFrameworkUtility() {}

    public static BatchFrameworkUtility getInstance(){
        if (instance == null) {
            instance = new BatchFrameworkUtility();
        }
        return instance;
    }

    public DateTime getCurrentDateTime() {
        return System.now();
    }
}