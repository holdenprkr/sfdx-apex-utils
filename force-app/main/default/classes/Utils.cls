public with sharing class Utils {

    public static Id[] covertIdSetToList(Set<Id> idSet) {
        return new List<Id>(idSet);
    }

    public static Id[] getLookupFieldIdsFromRecords(SObject[] records, String lookupField) {
        Id[] recordIds = new Id[]{};
        for (SObject record : records) {
            Id recordId = (Id) record.get(lookupField);
            if (recordId != null) recordIds.add(recordId);
        }
        return recordIds;
    }

    public static Id[] getSObjectIds(SObject[] records) {
        Id[] recordIds = new Id[]{};
        for (SObject record : records) {
            Id recordId = (Id) record.get('Id');
            if (recordId != null) recordIds.add(recordId);
        }
        return recordIds;
    }

    public static void sendEmailMessage(Messaging.SingleEmailMessage message) {
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ message });
    }

}