trigger closestBirthdateContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter){
        if( trigger.isInsert){
            closestBirthdateContactTriggerHandler.insertContact(trigger.new);
        }
        if(trigger.isUpdate){
            closestBirthdateContactTriggerHandler.updateContact(trigger.new);
        }
        if(trigger.isDelete){
            closestBirthdateContactTriggerHandler.deleteContact(trigger.old);
        }

        if(trigger.isUndelete){
            closestBirthdateContactTriggerHandler.undeleteContact(trigger.new);
        }
    }
}