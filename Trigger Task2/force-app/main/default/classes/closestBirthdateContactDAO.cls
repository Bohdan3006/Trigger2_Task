public with sharing class closestBirthdateContactDAO {

    public static Map<Id, Account> getAccountsById(Set<Id> accountIds) {

        Map<Id, Account> accountsWithContacts = new Map<Id, Account>([SELECT Id, CreatedDate, 
                                                            (SELECT Id, LastName, Birthdate FROM Contacts ORDER BY Birthdate DESC) 
                                                            FROM Account WHERE id IN :accountIds]);

        return accountsWithContacts;
    }
}