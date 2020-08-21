/*
trigger UpdateDescription on Contact (before insert) {
    
    for(Contact con: Trigger.new) {
        con.Description = 'Contact created by Hermy';
    }

}
*/

/*
trigger UpdateContactDescription on Contact (before update) {
    for(Contact con: Trigger.new) {
        con.Description = 'Contact updated by ' +userInfo.getUserName();
    }

}
*/

trigger UpdateContactDescription on Contact (before insert, before update) {
    for(Contact con: Trigger.new) {
        if(trigger.isInsert) {
        	con.Description = 'New Contact created by ' +userInfo.getFirstName();
        } else if(trigger.isUpdate) {
            con.Description = 'Contact updated by ' +userInfo.getUserName();
        }
        
    }

}