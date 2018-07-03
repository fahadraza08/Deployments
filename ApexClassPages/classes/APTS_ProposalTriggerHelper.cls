/******************************************************************
@Name: APTS_ProposalTriggerHelper
@Author: Saranya Rajagopal
@CreateDate: 1/18/2018.
@Description: When creating a new Quote/Proposal record from an Opportunity record, the Price List field (lookup) 
should be auto-populated based on the value in the Currency field on the Opportunity.
@UsedBy:ProposalTriggerHandler.
******************************************************************/
public with sharing class APTS_ProposalTriggerHelper
{
/*method for auto populating price list*/
  public static void updatePricelist(List <Apttus_Proposal__Proposal__c> listProposal)
   {
     try
      {
            List<Apttus_Proposal__Proposal__c> proposalListToUpdate = new List< Apttus_Proposal__Proposal__c > ();
            Set <Id> setOpportunityId = new Set <Id> ();
            Map <String,Id> currencyCodeToPriceListIdMap = new Map <String,Id> ();
            Map< Id, String> propIdToCurrencyMap= new Map < Id, String> ();
            
            //Get Pricelist Ids for each CurrencyISOCode
            for(Apttus_Config2__PriceList__c Pricelist : [SELECT id,name,CurrencyIsoCode FROM Apttus_Config2__PriceList__c where (NOT (Name LIKE 'Legacy%'))limit 50000])
            {
                currencyCodeToPriceListIdMap.put(Pricelist.CurrencyIsoCode,Pricelist.id);
            }
            //Query Currency for each proposal
            for(Apttus_Proposal__Proposal__c prop:  [SELECT id,Opportunity_Currency__c FROM Apttus_Proposal__Proposal__c WHERE Id IN : listProposal])
            {
                propIdToCurrencyMap.put(prop.id,prop.Opportunity_Currency__c);
            }   
            //Update Pricelists to Proposals
            for(Apttus_Proposal__Proposal__c parObj : listProposal) 
            {
                Apttus_Proposal__Proposal__c propToUpdate = new Apttus_Proposal__Proposal__c();
                propToUpdate.id = parObj.id;

                propToUpdate.Apttus_QPConfig__PriceListId__c = currencyCodeToPriceListIdMap.get(propIdToCurrencyMap.get(parObj.id));
                update propToUpdate;
                
            }
            
        }
      
      catch(Exception e)
       { 
           throw new ClsTriggerException(e.getMessage());
       }
    }
}