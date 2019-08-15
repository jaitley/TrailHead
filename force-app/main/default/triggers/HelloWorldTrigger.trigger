trigger HelloWorldTrigger on Account (before insert) {
    integer i = 1;
    for (Account a : Trigger.New) {
        a.Description = 'New description for ' + i;
        i++;
    }
}