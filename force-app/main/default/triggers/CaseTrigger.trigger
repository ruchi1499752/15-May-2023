// Trigger Scenario 1 :
//When ever a case is created with origin as email then set status as new and Priority as Medium.
trigger CaseTrigger on Case (after insert) {
 for(case c : trigger.new){
  if(c.origin == 'Email'){
           c.status = 'New';
           c.priority = 'Medium';
          }
      }
}