/******************************************************************
@Name: APTS_ProposalTriggerHandler
@Author: Monika Jayachamaraja
@CreateDate: 1/18/2018.
@Description: Price List field should be auto-populated when creating a Quote/Proposal.
@UsedBy:ProposalTrigger.
******************************************************************/
public  with sharing class APTS_ProposalTriggerHandler {
    /*Method to pass the list*/
    public static void onBeforeInsert(List <Apttus_Proposal__Proposal__c> listProposal){
      try
    {
        APTS_ProposalTriggerHelper.updatePricelist(listProposal);
    }
    catch(Exception e)
    {
         throw new ClsTriggerException(e.getMessage());
    }}
}