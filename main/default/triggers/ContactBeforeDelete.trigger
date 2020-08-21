trigger ContactBeforeDelete on Contact (before delete) {
	
    for(Contact con: Trigger.old) {
        if(con.AccountId != null) {
            con.addError('This contact is attached to an Account; cannot be deleted');
        }
    }
}