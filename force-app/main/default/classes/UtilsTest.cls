@IsTest
private class UtilsTest {

    @TestSetup
    static void setup() {
        Account account = new Account(
                Name = 'Test Account'
        );
        insert account;

        Contact contact = new Contact(
                FirstName = 'Test',
                LastName = 'Contact',
                AccountId = account.Id
        );
        insert contact;
    }

    @IsTest
    static void testConvertingIdSetToList() {
        Account account = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        Set<Id> idSet = new Set<Id>{ account.Id };
        Test.startTest();
        Id[] idList = Utils.covertIdSetToList(idSet);
        System.assert(idList.size() == idSet.size(), 'ID Set not converted to list as expected!');
        Test.stopTest();
    }

    @IsTest
    static void testGettingLookupFieldIdList() {
        Contact[] contacts = [SELECT Id, AccountId FROM Contact];
        Test.startTest();
        Id[] lookupFieldIds = Utils.getLookupFieldIdsFromRecords(contacts, 'AccountId');
        System.assert(lookupFieldIds[0] == contacts[0].AccountId, 'Lookup field ID list not created as expected!');
        Test.stopTest();
    }

    @IsTest
    static void testGettingIdList() {
        Contact[] contacts = [SELECT Id FROM Contact];
        Test.startTest();
        Id[] recordIds = Utils.getSObjectIds(contacts);
        System.assert(recordIds[0] == contacts[0].Id, 'ID list not created as expected!');
        Test.stopTest();
    }

    @IsTest
    static void testSendingEmailMessage() {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[]{ 'test@test.com.invalid' };
        message.subject = 'Test Send Email';
        message.plainTextBody = 'Test';
        Test.startTest();
        Utils.sendEmailMessage(message);
        Test.stopTest();
    }

}