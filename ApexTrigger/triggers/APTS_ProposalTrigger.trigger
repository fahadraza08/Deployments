/******************************************************************
@Name: APTS_ProposalTrigger
@Author: Monika Jayachamaraja
@CreateDate: 1/18/2018.
@Description: Price List field should be auto-populated when creating a Quote/Proposal.
@UsedBy:Apttus_Proposal__Proposal__c.
******************************************************************/

trigger APTS_ProposalTrigger on Apttus_Proposal__Proposal__c (after insert) {
    if(trigger.isAfter){
        APTS_ProposalTriggerHandler.onBeforeInsert(trigger.new);
    }
}