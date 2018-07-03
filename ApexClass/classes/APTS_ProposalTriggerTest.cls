/******************************************************************
@Name: APTS_ProposalTriggerTestClass
@Author: Monika Jayachamaraja
@CreateDate: 1/18/2018.
@Description:Test Class on Proposal Trigger to check Price List field auto-population when creating a Quote/Proposal.
@UsedBy:ProposalTrigger.
******************************************************************/
@isTest(SeeAllData=false)
 Private class APTS_ProposalTriggerTest 
{
 /*Validate the trigger*/
  static testMethod void validateUpdatePricelist()
    {
        User[] usr=TestUtility.createTsetUser (1,null,null,True);
        system.runAs(usr[0])
            {
            
                Apttus_Config2__PriceList__c[] pricelist=TestUtility.createTestPriceList(1,True);
                Account[] acc =TestUtility.createTestAccounts(1,True);
                Opportunity[] opp=TestUtility.createTestOpportunity(1,acc[0],True);
                Apttus_Proposal__Proposal__c[] proposal=TestUtility.createTestProposal(1,opp[0],True); 
                Apttus_Config2__PriceList__c price=[Select id from Apttus_Config2__PriceList__c  where id= :pricelist[0].id limit 5];
                Test.startTest();
                proposal[0].Apttus_QPConfig__PriceListId__c=price.id;
                Test.stopTest(); 
                System.assertEquals(proposal[0].Apttus_QPConfig__PriceListId__c,price.id);
                }
               
             } 
       
       static testMethod void validateUpdatePricelist1()
    {
        User[] usr=TestUtility.createTsetUser (1,null,null,True);
        system.runAs(usr[0])
            {
            try
            {
                Apttus_Config2__PriceList__c[] pricelist=TestUtility.createTestPriceList(1,True);
                Account[] acc =TestUtility.createTestAccounts(1,True);
                Opportunity[] opp=TestUtility.createTestOpportunity(1,acc[0],True);
                Apttus_Proposal__Proposal__c[] proposal=TestUtility.createTestProposal(1,opp[0],True); 
                Apttus_Config2__PriceList__c price=[Select id from Apttus_Config2__PriceList__c  where id= :pricelist[0].id limit 5];
                Test.startTest();
                proposal[0].Apttus_QPConfig__PriceListId__c=null;
                               //System.assertEquals(proposal[0].Apttus_QPConfig__PriceListId__c,price.id);
                               Test.stopTest(); 
                }
                catch(Exception e)
                 {
                    Boolean expectedExceptionThrown =  e.getMessage().contains('Valid Price List not found. Please contact system administrator') ? true : false;
                    System.assertEquals(expectedExceptionThrown, true);
                     

                 }
                 
             } 
       }
  }