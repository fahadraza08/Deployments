/* *****************************************************
@Name: APTS_OpportunityToProposalControllerTest
@Author: Rajesh Patel
@CreateDate: 13/03/2018.
@Description: Test class for Opportunity to proposal creation controller class.
@UsedBy: APTS_OpportunityToProposalController .
******************************************************* */
@isTest(SeeAllData=true)
Private class APTS_OpportunityToProposalControllerTest {

/* Create Opportunity and account,after redirect according to record type selection */  
static testMethod void validateButtons() {  
          User[] usr=TestUtility.createTsetUser (1,null,null,True);
          system.runAs(usr[0])
           {  
                Account[] acunt =TestUtility.createTestAccounts(1,True);
                Opportunity[] opp=TestUtility.createOpportunity(1,acunt[0],True);
               
                
                PageReference pageRef = Page.OpportunityToProposalCreation;
                Test.setCurrentPage(pageRef);
                ApexPages.StandardController stdcontroller = new ApexPages.standardController(opp[0]);
                APTS_OpportunityToProposalController testController = new APTS_OpportunityToProposalController(stdcontroller);
              
                test.startTest();
                testController.reset();
                testController.save();
                testController.cancel();
                testController.changeStageName();
                test.stopTest();
                
                    }
                } 
    
}