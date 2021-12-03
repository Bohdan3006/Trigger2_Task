public with sharing class closestBirthdateContactTriggerHandler {
    
    public static void processContacts(List<Contact> contactsFromTrigger){
        Set<Id> accountIds = new Set<Id>();
        for(Contact cont : contactsFromTrigger){
            if(cont.AccountId != null){
                accountIds.add(cont.AccountId);
            }
        }
    
        Map<Id, Account> accountsWithContacts = closestBirthdateContactDAO.getAccountsById(accountIds);
       
        List<Account> accToUpdate = new List<Account>();
       
        for(Account acc : accountsWithContacts.values()){
            Integer accYear = acc.CreatedDate.year();
            Integer accMonth = acc.CreatedDate.month();
            Integer accDay = acc.CreatedDate.day();
            DateTime accCreatedDateGMT = DateTime.newInstanceGmt(accYear, accMonth, accDay);
            Long accCreatedDateGMTLong = accCreatedDateGMT.getTime();
            Id contactId = null;
            Long closestDate = 0;
            for(Contact cont : acc.Contacts){
                Integer contYear = cont.Birthdate.year();
                Integer contMonth = cont.Birthdate.month();
                INteger contDay = cont.Birthdate.day();
                if(contactId == null){
                    contactId = cont.Id;
                    DateTime contClosest = DateTime.newInstanceGmt(contYear, contMonth, contDay);
                    Long contClosestLong = contClosest.getTime();
                    closestDate = Math.abs(contClosestLong - accCreatedDateGMTLong);
                    continue;
                }
                Long closestDateTemp = Math.abs(DateTime.newInstanceGmt(contYear, contMonth, contDay).getTime() - accCreatedDateGMTLong);
                if(closestDate > closestDateTemp){
                    contactId = cont.Id;
                    closestDate = closestDateTemp;
                } 
            }
            acc.closestBirthdateContact__c = contactId;
            accToUpdate.add(acc);
        }
            if(accToUpdate != null){
                update accToUpdate;
            }
    }

    public static void insertContact(List<Contact> insertedContacts){
        processContacts(insertedContacts);
    } 

    public static void updateContact(List<Contact> updatedContacts){
        processContacts(updatedContacts);
    }

    public static void deleteContact(List<Contact> deletedContacts){
        processContacts(deletedContacts);
    }

    public static void undeleteContact(List<Contact> undeletedContacts){ 
        processContacts(undeletedContacts);
    }

}