/* *****************************************************
@Name: APTS_OpportunityToProposalController
@Author: Rajesh Patel
@CreateDate: 2/03/2018.
@Description: When user will create opportunity than after that we have to force user for Proposal Creation.
@UsedBy: OpportunityToProposalCreation Visualforce page.
******************************************************* */
/* Opportunity Controller Class*/
public with sharing class APTS_OpportunityToProposalController {

    private final Opportunity opp;
    private transient Map<String, Decimal> probabilityStageNameMap;
    
   
    /* APTS_OpportunityToProposalController constructor */
   public APTS_OpportunityToProposalController(ApexPages.StandardController controller) { 
   this.opp= (Opportunity)controller.getRecord();  
    }

 /* Save Opportunity  */
   public PageReference save() { 
   PageReference pageRef;
       try {
   String oppRecordTpye = System.Label.Opp_Recordtype;
   String proposalUrl = System.Label.Quote_ProposalUrl;
   String proposalAcc = System.Label.Quote_ProposalAccount;
   String propOppUrl = System.Label.OpporunityUrl;
   
   Database.upsert(opp);
   Account oppAccount=[Select name,id from account where Id=: opp.accountID LIMIT 1];
   String oppRecordTypeName = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName();
   if(oppRecordTypeName.equals(oppRecordTpye)) 
      { 
   pageRef = new PageReference(proposalUrl+opp.Name+proposalAcc+oppAccount.Name);
   }
   else { 
   pageRef = new PageReference(propOppUrl); }
   pageRef.setRedirect(true);
   
       } Catch(DmlException msg)    {
           ApexPages.addMessages(msg);
        }
        return pageRef;
   }

   /* Cancel Opportunity  */
   public PageReference cancel() { 
   String cnclOppUrl = System.Label.OpporunityUrl;
   PageReference pageRef = new PageReference(cnclOppUrl);
   pageRef.setRedirect(true);
    return pageRef; 
   }

   /* Reset Opportunity  */
    public PageReference reset() { 
    PageReference newpage = new PageReference(System.currentPageReference().getURL());
    newpage.setRedirect(true);
    return newpage;
    }
    
    /* Opportunity Sales process percentage auto populate  */
    public PageReference changeStageName() {
        try {
    if (probabilityStageNameMap == null) {
        probabilityStageNameMap = new Map<String, Decimal>();
        for (OpportunityStage oppStage : [Select MasterLabel, DefaultProbability
                                       From OpportunityStage LIMIT 20]) {
        probabilityStageNameMap.put(oppStage.MasterLabel, oppStage.DefaultProbability);
            }
                 }
  
        if (probabilityStageNameMap.containsKey(opp.StageName)) {
        opp.Probability = probabilityStageNameMap.get(opp.StageName);
         }
        } Catch(Exception msg)
        {  
            ApexPages.addMessages(msg);
            }
            return null;
       }


}