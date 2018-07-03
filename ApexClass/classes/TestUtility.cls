/*******************************************************************************
 * Name             : TestUtility
 * Created By       : Amit Kumar Agrawal(Appirio Offshore)
 * Created Date     : 19 FEB.,2013
 * Purpose          : This class can be called and re-used from other test 
 *                            classes that need an object created with fields values
 * Notes            : THIS IS ONLY FOR KEEPING ALL TEST CLASSES PREREQIUSTE  
                      COMMON FUNCTIONS.PLEASE USE THIS AS LIBRARY SO WE CAN DO 
                      CHANGES AT ONE PLACE
                      
 *                  : If a field value is not currently being populated then go 
                      ahead and add it
 
 //Modifications:
 Amit K A : 08 March,2013 
 ******************************************************************************/
 
@isTest 
public without sharing class TestUtility
{
    public static ID BHId = [SELECT Id 
                             FROM BusinessHours 
                             WHERE IsDefault=True].Id;
        
    //----------------------------------------------------------------------------
    //Create Account Records
  //----------------------------------------------------------------------------
  public static list<Account> createTestAccounts(Integer accountSize,
                                                 Boolean isInsert ) 
  {
    list<Account> accounts = new list<Account>();
    for(Integer i=0;i<accountSize;i++) 
    {
        Account acc          = new Account();
      acc.Name             = 'TestAccount' + i;
      acc.Type             = 'Client'; 
      acc.Account_Area__c  = 'Americas';
      acc.FES_Region__c    = 'NAM';
      acc.Industry         = 'Financial';
      acc.Country_Code__c  = 'US';
      acc.Market__c        = 'Other';
      acc.Segment__c       = 'Other';
      accounts.add(acc);
    }
    if(isInsert)
      insert accounts;
    return accounts;            
  }
    
  //----------------------------------------------------------------------------
  //Create Opportunity Records
  //----------------------------------------------------------------------------
  public static list<Opportunity> createTestOpportunity(Integer opportunitySize, 
                                                        Account account,
                                                        Boolean isInsert )
  {
    list<Opportunity> opps = new list<Opportunity>();
    for(Integer i = 0; i < opportunitySize; i++)
    {
        Opportunity opp = new Opportunity();        
      opp.AccountId   = account.Id;
      opp.Name        = 'testOppty ' + i;
      opp.Industry__c = 'Distribution';
      opp.StageName   = 'Won';
      opp.BidType__c = 'Sole Sourced';
      //Added by Saranya Rajagopal Date :06/02/2018  For proposalTriggerTest 
      opp.CurrencyIsoCode='USD';
      opp.CloseDate   = system.today();
      opp.Amount      = 5 + i;      
      opps.add(opp);
    }   
    if(isInsert)
      insert opps;
    return opps;           
  }
  //Overloading createOpportunity Record
  public static list<Opportunity> createTestOpportunity(Integer opportunitySize,
                                                        Boolean isInsert )
  {
    list<Opportunity> opps = new list<Opportunity>();
    for(Integer i = 0; i < opportunitySize; i++)
    {
      Opportunity opp = new Opportunity();    
      opp.Name        = 'testOppty ' + i;
      opp.Industry__c = 'Distribution';
      opp.StageName   = 'Won';
      opp.BidType__c = 'Sole Sourced';
      opp.CloseDate   = system.today();
      opp.Amount      = 5 + i;      
      opps.add(opp);
    }   
    if(isInsert)
      insert opps;
    return opps;           
  }
  
  
    // //Added by Saranya Rajagopal Date :08/02/2018  For proposalTriggerTest 
  //Create PriceList Records
  //----------------------------------------------------------------------------
   public static list<Apttus_Config2__PriceList__c> createTestPriceList(Integer priceListSize,
                                                        Boolean isInsert )
  {
    list<Apttus_Config2__PriceList__c> pricelist = new list<Apttus_Config2__PriceList__c>();
    for(Integer i = 0; i < priceListSize; i++)
    {
      Apttus_Config2__PriceList__c pl = new Apttus_Config2__PriceList__c();        
      pl.Name        = 'testpricelist ' + i;
      pl.CurrencyIsoCode='USD';
      pl.Apttus_Config2__EffectiveDate__c= system.today();
      pl.Apttus_Config2__ContractNumber__c= 'testcontracted';
          
      pricelist.add(pl);
    }   
    if(isInsert)
      insert pricelist;
    return pricelist;           
  }
   
  // //Added by Saranya Rajagopal Date :08/02/2018  For proposalTriggerTest 
  //Create Proposal Records
  //----------------------------------------------------------------------------
   public static list<Apttus_Proposal__Proposal__c> createTestProposal(Integer ProposalSize,Opportunity opportunity,
                                                        Boolean isInsert )
  {
    list<Apttus_Proposal__Proposal__c> proposal = new list<Apttus_Proposal__Proposal__c>();
    for(Integer i = 0; i < ProposalSize; i++)
    {
      Apttus_Proposal__Proposal__c pro = new Apttus_Proposal__Proposal__c();        
      pro.Apttus_Proposal__Proposal_Name__c= 'testproposal'+ i;
      pro.Apttus_Proposal__Opportunity__c=opportunity.id;
      pro.Apttus_Proposal__Approval_Stage__c= 'Quote';
      
      proposal.add(pro);
    }   
    if(isInsert)
      insert proposal;
    return proposal;           
  }
  
  //----------------------------------------------------------------------------
  //Create Contract Records
  //----------------------------------------------------------------------------
  public static list<Contract> createTestContract(Integer contractSize, 
                                                  Account account,
                                                  String recordTypeName,
                                                  Boolean isInsert )
  {
    list<Contract> contracts = new list<Contract>();
    for(Integer i = 0; i < contractSize; i++)
    {
        Contract contract        = new Contract();
      contract.AccountId       = account.Id;
      contract.RecordTypeId    = getContractRecordTypeId(recordTypeName);     
      contract.Name            = 'test ' + i;
      contract.CurrencyIsoCode = 'USD';
      contract.StartDate       = system.today();
      contract.Status          = 'Open';     
      contracts.add(contract);
    }   
    if(isInsert)
      insert contracts;
    return contracts;           
  }
  
  //----------------------------------------------------------------------------
  //Get Record Type Id for Contract Object of given String
  //----------------------------------------------------------------------------
  private static Id getContractRecordTypeId( String name ) 
  {
    return Schema.SObjectType.Contract.getRecordTypeInfosByName().get(name).getRecordTypeId();
  }
  
  //----------------------------------------------------------------------------
  //Create Support Order Records
  //----------------------------------------------------------------------------
  public static list<Support_Order__c> createTestSupportOrder(Integer supportOrderSize, 
                                                              Opportunity opp ,
                                                              Boolean isInsert )
  {
    list<Support_Order__c> supportOrders = new list<Support_Order__c>();
    for(Integer i = 0; i < supportOrderSize; i++)
    {
      Support_Order__c so           = new Support_Order__c();                     
      so.Opportunity__c             = opp.Id;            
      so.Owner_Expiration_Notice__c = '15 Days';
      so.CurrencyIsoCode            = 'USD';
      so.Current_Term_Start_Date__c = system.today();
      so.Current_Term_End_Date__c   = system.today().addDays(5);
      so.Contract_Date__c           = system.today();
      so.Status__c                  = 'Open';      
      supportOrders.add(so);
    }   
    if(isInsert)
      insert supportOrders;
    return supportOrders;           
  }
  
  //----------------------------------------------------------------------------
  //Create Support Order Records
  //----------------------------------------------------------------------------
  public static list<Support_Order__c> createTestSupportOrder1(Integer supportOrderSize, 
                                                              Opportunity opp ,
                                                              Contract ctr,
                                                              Boolean isInsert )
  {
    list<Support_Order__c> supportOrders = new list<Support_Order__c>();
    for(Integer i = 0; i < supportOrderSize; i++)
    {
      Support_Order__c so           = new Support_Order__c();                     
      so.Opportunity__c             = opp.Id;            
      so.Owner_Expiration_Notice__c = '15 Days';
      so.CurrencyIsoCode            = 'USD';
      so.Current_Term_Start_Date__c = system.today();
      so.Current_Term_End_Date__c   = system.today().addDays(5);
      so.Contract_Date__c           = system.today();
      so.Status__c                  = 'Open'; 
      so.Contract__c                = ctr.Id;   
      supportOrders.add(so);
    }   
    if(isInsert)
      insert supportOrders;
    return supportOrders;           
  }
  
  //----------------------------------------------------------------------------
  //Get Record Type Id for Support_Order__c Object of given String
  //----------------------------------------------------------------------------
  private static ID getSupportOrderRecordTypeId( String name ) 
  {
    return Schema.SObjectType.Support_Order__c.getRecordTypeInfosByName().get(name).getRecordTypeId();
  }
    
  //----------------------------------------------------------------------------
  //Create Contact Records
  //----------------------------------------------------------------------------
  public static list<Contact> createTestContact(Integer contactSize,
                                                String conLastName, 
                                                Account acc, 
                                                Boolean isInsert ) 
  {
    list<Contact> contacts = new list<Contact>();
    for(Integer i = 0; i < contactSize; i++)
    {
       Contact con    = new Contact();
      con.FirstName  = 'Contact First Name';
      con.LastName   = conLastName;
      con.AccountId  = acc.Id;
      con.Email      = 'test@gmail.com';
      con.Phone      = '+68678678768';           
      contacts.add(con);
    }
    if(isInsert) 
      insert contacts;
    return contacts;
  }
  
  //----------------------------------------------------------------------------
  //Create User Records
  //----------------------------------------------------------------------------
  public static list<User> createTsetUser(Integer userSize,
                                          String profile,
                                          String role,
                                          Boolean isInsert ) 
  {
    list<User> users = new list<User>();
    for(Integer i = 0; i < userSize; i++)
    {
      User u1                 = new User();
      u1.firstName            = 'testfirstName' + i;
      u1.LastName             = 'testLastName' + i; 
      u1.Alias                = 'tstAl' + i;
      u1.Email                = 'test' + i + '.test@ventyx.com';  
     /* u1.UserName             = 'test'+ Math.random().format() + 
                                string.valueof(Datetime.now()).replace('-','').
                                replace(':','').replace(' ','') + i +*/
       u1.UserName           = 'user1@ventyx.com';
                                
      u1.ProfileId            = getProfileId(profile);
      u1.CommunityNickname    = u1.firstname + '_' +
                                Math.random().format() +
                                u1.lastName;
      u1.EmailEncodingKey     = 'ISO-8859-1'; 
      u1.LanguageLocaleKey    = 'en_US';
      u1.TimeZoneSidKey       = 'America/New_York';
      u1.LocaleSidKey         = 'en_US';
      String fedId            = i + Math.random().format() + 
                                Datetime.now().format()+'1234567890ABCDEFG';       
      u1.FederationIdentifier = fedId.substring(0,20);  
      u1.UserRoleId           = getUserRoleId(role);
      u1.IsActive             = true;       
      users.add(u1);
    }
    if(isInsert) 
      insert users;
    return users;
  }
  
  //----------------------------------------------------------------------------
  //Get Profile Id for Object of given String
  //----------------------------------------------------------------------------
  private static ID getProfileId( String name ) 
  {
    list<Profile> sysProfile;
    if(name <> null)
    {
        sysProfile = [SELECT id 
                      FROM Profile 
                      WHERE Name =:name limit 1];
        return sysProfile[0].Id;
    }   
    else
    {
        sysProfile = [SELECT id 
                      FROM Profile 
                      WHERE Name = 'System Administrator' limit 1];
        return sysProfile[0].Id;
    }       
  }
  //----------------------------------------------------------------------------
  //Get Role Id for Object of given String
  //----------------------------------------------------------------------------
  private static ID getUserRoleId( String name ) 
  {
    list<UserRole> sysUserRole;
    if(name <> null )
    {
        sysUserRole = [SELECT id 
                       FROM UserRole 
                       WHERE Name =:name limit 1];
        return sysUserRole[0].Id;
    }    
    else
    {
      sysUserRole = [SELECT id 
                     FROM UserRole 
                     WHERE Name = 'Account Management' limit 1];
      return sysUserRole[0].Id;
    }       
  }
  //----------------------------------------------------------------------------
  //Create Support Program Records
  //----------------------------------------------------------------------------
  public static list<ENT_2__Support_Program__c> createTestSupportProgram(Integer supportProgramSize,
                                                                         Account a, 
                                                                         Contract ct,
                                                                         String recordTypeName, 
                                                                         Boolean isInsert )
  {
    list<ENT_2__Support_Program__c> supportPrograms;
    supportPrograms = new list<ENT_2__Support_Program__c>();
    for(Integer i = 0; i < supportProgramSize; i++)
    {
      ENT_2__Support_Program__c sp = new ENT_2__Support_Program__c();                     
      sp.name                           = 'Test Account'+i; 
      sp.ENT_2__Account__c              = a.id; 
      sp.ENT_2__Contract__c             = ct.id; 
      sp.RecordTypeId                   = getSupportProgramRecordTypeId(recordTypeName);                
      sp.ENT_2__P1__c                   = 'P1_'+i;
      sp.ENT_2__P1_Workaround_hours__c  = 1.0;
      sp.ENT_2__P1_Response_hours__c    = 1.0;
      sp.ENT_2__P1_Resolution_hours__c  = 1.0;                
      sp.ENT_2__P2__c                   = 'P2_'+i;
      sp.ENT_2__P2_Workaround_hours__c  = 2.0;
      sp.ENT_2__P2_Response_hours__c    = 2.0;
      sp.ENT_2__P2_Resolution_hours__c  = 2.0;                
      sp.ENT_2__P3__c                   = 'P3_'+i;
      sp.ENT_2__P3_Workaround_hours__c  = 3.0;
      sp.ENT_2__P3_Response_hours__c    = 3.0;
      sp.ENT_2__P3_Resolution_hours__c  = 3.0;                
      sp.ENT_2__P4__c                   = 'P4_'+i;
      sp.ENT_2__P4_Workaround_hours__c  = 4.0;
      sp.ENT_2__P4_Response_hours__c    = 4.0;
      sp.ENT_2__P4_Resolution_hours__c  = 4.0;                
      sp.ENT_2__P5__c                   = 'P5_'+i;
      sp.ENT_2__P5_Workaround_hours__c  = 5.0;
      sp.ENT_2__P5_Response_hours__c    = 5.0;
      sp.ENT_2__P5_Resolution_hours__c  = 5.0;
      
      supportPrograms.add(sp);
    }   
    if(isInsert)
      insert supportPrograms;
    return supportPrograms;           
  }
  //----------------------------------------------------------------------------
  //Get Record Type Id for ENT_2__Support_Program__c Object of given String
  //----------------------------------------------------------------------------
  private static ID getSupportProgramRecordTypeId( String name ) 
  {
    return Schema.SObjectType.ENT_2__Support_Program__c.getRecordTypeInfosByName().get(name).getRecordTypeId();
  }
  //----------------------------------------------------------------------------
  //Create Entitlement Records
  //----------------------------------------------------------------------------
  public static list<ENT_2__Entitlement__c> createTestEntitlement(Integer entitlementSize,
                                                                  Account a,
                                                                  Contract ct,
                                                                  ENT_2__Support_Program__c sprg, 
                                                                  Boolean isInsert ) 
  {
    list<ENT_2__Entitlement__c> entitlements = new list<ENT_2__Entitlement__c>();
    for(Integer i = 0; i < entitlementSize; i++)
    {              
      ENT_2__Entitlement__c ent     = new ENT_2__Entitlement__c();
      ent.name                      = 'Test Ent'+i;
      ent.ENT_2__Start_Date__c      = System.today(); 
      ent.ENT_2__End_Date__c        = System.today(); 
      ent.ENT_2__Business_Hours__c  = BHId;                 
      ent.ENT_2__Support_Program__c = sprg.Id; 
      ent.Account__c                = a.Id;
      ent.Contract__c               = ct.Id;
      ent.Not_Valid__c              = false;     
      entitlements.add(ent);
    }
    if(isInsert) 
      insert entitlements;
    return entitlements;
  }
  
  //----------------------------------------------------------------------------
  //Create BusinessHours Records
  //----------------------------------------------------------------------------
 /* public static list<BusinessHours> createTestBusinessHours(Integer businessHoursSize, 
                                                              Boolean isInsert ) 
  {
    list<BusinessHours> businessHours = new list<BusinessHours>();
    for(Integer i = 0; i < businessHoursSize; i++)
    {              
      businessHours.add(new BusinessHours(
      name= 'TestBH'+i,
      TimeZoneSidKey = 'America/New_York'      
      ));
    }
    if(isInsert) 
      insert businessHours;
    return businessHours;
  } */
  
  //----------------------------------------------------------------------------
  //Create Supported Product  Records
  //----------------------------------------------------------------------------
  public static list<Supported_Product__c> createTestSupportedProduct(Integer supportedProductSize,
                                                                      Support_Order__c so,
                                                                      Product2 product2,
                                                                      Boolean isInsert ) 
  {
    list<Supported_Product__c> supportedProducts = new list<Supported_Product__c>();
    
    for(Integer i = 0; i < supportedProductSize; i++)
    {              
      Supported_Product__c sp = new Supported_Product__c();
      sp.Support_Order__c     = so.Id;
      sp.product__c           = product2.Id; 
      sp.CurrencyIsoCode      = 'USD';                
      supportedProducts.add(sp);
    }
    if(isInsert) 
      insert supportedProducts;
    return supportedProducts;
  }
  //----------------------------------------------------------------------------
  //Create License Order  Records
  //----------------------------------------------------------------------------
  public static list<License_Order__c> createTestLicenseOrder(Integer licenseOrderSize, 
                                                              Contract ct, 
                                                              Boolean isInsert ) 
  {
    list<License_Order__c> licenseOrders = new list<License_Order__c>();
    for(Integer i = 0; i < licenseOrderSize; i++)
    {              
      License_Order__c lo = new License_Order__c();
      lo.CurrencyIsoCode  = 'USD';
      lo.MCA_Contract__c  = ct.Id;                    
      licenseOrders.add(lo);
    }
    if(isInsert) 
      insert licenseOrders;
    return licenseOrders;
  }  
  //----------------------------------------------------------------------------
  //Create License Support Junction Records
  //----------------------------------------------------------------------------
  public static list<License_Support_Junction__c> createTestLicenseSupportJunction(list<License_Order__c> lolist, 
                                                                                   list<Support_Order__c> solist, 
                                                                                   Boolean isInsert) 
  {
    list<License_Support_Junction__c> lstJunction;
    lstJunction = new list<License_Support_Junction__c>();         
    for(License_Order__c lo :lolist){
        for(Support_Order__c so :solist){
            License_Support_Junction__c newJunction = new License_Support_Junction__c();
        newJunction.License_Order__c            = lo.Id;
        newJunction.Support_Order__c            = so.Id;
        lstJunction.add(newJunction);
        }
    }   
    if(isInsert) 
      insert lstJunction;
    return lstJunction;
  }    
  //----------------------------------------------------------------------------
  //Create OpportunityLineItem  Records
  //----------------------------------------------------------------------------
  public static list<OpportunityLineItem> createTestOpportunityLineItem(Integer opportunityLineItemSize, 
                                                                        Opportunity o,
                                                                        String revenueStream, 
                                                                        PricebookEntry entry, 
                                                                        Boolean isInsert ) 
  {
    list<OpportunityLineItem> opportunityLineItems = new list<OpportunityLineItem>();
    for(Integer i = 0; i < opportunityLineItemSize; i++)
    {              
      OpportunityLineItem opplItem = new OpportunityLineItem();
      opplItem.TotalPrice          = 100;
      opplItem.OpportunityId       = o.Id;
      opplItem.Quantity            = 1;
      opplItem.Revenue_Stream__c   = revenueStream;
      opplItem.PricebookEntryId    = entry.Id;  
      opplItem.Start_Date__c = System.today();
      opplItem.End_Date__c = System.today().addDays(10);                  
      opportunityLineItems.add(opplItem);
    }
    if(isInsert) 
      insert opportunityLineItems;
    return opportunityLineItems;
  }
  
  //----------------------------------------------------------------------------
  //Create Products(Product2)  Records
  //----------------------------------------------------------------------------
  public static list<Product2> createTestProduct2(Integer product2Size, 
                                                  Boolean isInsert ) 
  {
    list<Product2> product2s = new list<Product2>();
    for(Integer i = 0; i < product2Size; i++)
    {
        Product2 product    = new Product2();
        product.name        = 'TestProduct' + i;
      product.Family      = 'TestFamily' + i;     
      product.ProductCode = 'TestProduct' + i;     
      product.Description = 'Test Product' + i;
      product.IsActive    = true;            
      product.Incremental_Quantity__c = 2; // added for validation rule for passing divide by zero exception
        product2s.add(product);
    }
    if(isInsert) 
      insert product2s;
    return product2s;
  }
  
  //----------------------------------------------------------------------------
  //Create price book entry (PricebookEntry)  Records
  //----------------------------------------------------------------------------
  public static list<PricebookEntry> createTestPricebookEntry(Integer pricebookEntrySize, 
                                                              Product2 product,
                                                              ID pricebook, 
                                                              Boolean isInsert ) 
  {
    list<PricebookEntry> pricebookEntrys = new list<PricebookEntry>();
    for(Integer i = 0; i < pricebookEntrySize; i++)
    {
      PricebookEntry entry   = new PricebookEntry();
      entry.Product2Id       = product.Id;
      entry.Pricebook2Id     = pricebook;
      entry.UnitPrice        = 100 * (i + 1);
      entry.IsActive         = true;
      entry.CurrencyIsoCode  = 'USD';
      entry.UseStandardPrice = false;
      pricebookEntrys.add(entry);
    }
    if(isInsert) 
      insert pricebookEntrys;
    return pricebookEntrys;
  }
  
  //----------------------------------------------------------------------------
  //Create price book entry (PricebookEntry)  Records
  //----------------------------------------------------------------------------
  public static Pricebook2 getStandardPriceBook() 
  {
    Pricebook2 pb2 = [SELECT Id 
                      FROM Pricebook2 
                      WHERE IsStandard = true];
    return pb2;
  }
  
  //----------------------------------------------------------------------------
  //Create Asset  Records
  //----------------------------------------------------------------------------
  public static list<Asset> createTestAsset(Integer assetSize, 
                                            Account account,                                   
                                            Boolean isInsert ) 
  {
    list<Asset> assets = new list<Asset>();
    for(Integer i = 0; i < assetSize; i++)
    {
        Asset asset     = new Asset();
        asset.Name      = 'Test Asset ' + i;
        asset.Status    = 'Development';
        asset.AccountId = account.Id;
        assets.add(asset);
    }   
    if(isInsert)
      insert assets;
    return assets;  
  }

  //----------------------------------------------------------------------------
  //Create Product Version Records
  //----------------------------------------------------------------------------
  public static list<Product_Version__c> createTestProductVersion(Integer versionSize, 
                                            Product2 product,                                 
                                            Boolean isInsert ) 
  {
    list<Product_Version__c> versions = new list<Product_Version__c>();
    for(Integer i = 0; i < versionSize; i++)
    {
        Product_Version__c version = new Product_Version__c(
          Name = '1.0',                                            // Product Version
          Product__c = product.Id,                                 // Product
          Support_Level__c = 'End of Support',                     // Support Level
          End_of_Support_Date__c = Date.newInstance(2017, 05, 18)  // End of Life/Support Date
        );
        versions.add(version);
    }   
    if(isInsert)
      insert versions;
    return versions;  
  }

  //----------------------------------------------------------------------------
  //Create Product Level 1 Records
  //----------------------------------------------------------------------------
  public static list<Product_Level_1__c> createTestProductL1(Integer prodL1Size,
                                                                                       Product2 prod,
                                                                                       Boolean isInsert)
  {
    list<Product_Level_1__c> prodL1s = new list<Product_Level_1__c>();
    for(Integer i = 0; i < prodL1Size; i++)
    {
      Product_Level_1__c prodL1 = new Product_Level_1__c();
      prodL1.Name               = 'Test Product Level 1_ ' + i;
      prodL1.Product_Name__c    = prod.Id;      
      prodL1s.add(prodL1);
    } 
    if(isInsert)
      insert prodL1s;
    return prodL1s; 
  }
  //----------------------------------------------------------------------------
  //Create Purchased_Product_Level_1__c Records
  //----------------------------------------------------------------------------
  public static list<Purchased_Product_Level_1__c> createTestPurProdL1(Integer purProdL1Size,
                                                                       Product_Level_1__c prodL1,
                                                                       Account a,
                                                                       Asset asset,                                    
                                                                       Boolean isInsert)
  {
    list<Purchased_Product_Level_1__c> purProdL1s = new list<Purchased_Product_Level_1__c>();
    for(Integer i = 0; i < purProdL1Size; i++)
    {
      Purchased_Product_Level_1__c purProdL1 = new Purchased_Product_Level_1__c();
      purProdL1.Account__c                   = a.Id;
      purProdL1.Asset__c                     = asset.Id;
      purProdL1.Product_Level_1__c           = prodL1.Id;     
      purProdL1s.add(purProdL1);
    } 
    if(isInsert)
      insert purProdL1s;
    return purProdL1s; 
  }  
  //----------------------------------------------------------------------------
  //Create Case Records
  //----------------------------------------------------------------------------
  public static list<Case> createTestCase(Integer caseSize,
                                          Asset asset,
                                          Contact contact,
                                          Purchased_Product_Level_1__c purProdL1,
                                          Boolean isInsert)
  {
    list<Case> cases = new list<Case>();
    for(Integer i = 0; i < caseSize; i++)
    {
      Case c                            = new Case();     
      c.AssetId                         = asset.Id;
      c.Purchased_Product_Level_1_ID__c = purProdL1.Id;
      c.Priority                        = 'Low';
      c.Client_Ranking__c               = '';
      c.Status                          = 'New';
      c.Type                            = 'Defect';
      c.Origin                          = 'Phone';  
      c.Subject                         = 'Test Subject';
      c.Description                     = 'Test Description';
      cases.add(c);
    } 
    if(isInsert)
      insert cases;
    return cases; 
  }
  //----------------------------------------------------------------------------
  //Create Ordered Product Records
  //----------------------------------------------------------------------------
  public static list<Ordered_Product__c> createTestOrderProduct(Integer orderProdSize,
                                                                License_Order__c licOrder,
                                                                Boolean isInsert)
  {
    list<Ordered_Product__c> ops = new list<Ordered_Product__c>();
    for(Integer i = 0; i < orderProdSize; i++)
    {
      Ordered_Product__c op = new Ordered_Product__c();
      op.License_Order__c   = licOrder.Id;      
      ops.add(op);
    } 
    if(isInsert)
      insert ops;
    return ops; 
  }
  //----------------------------------------------------------------------------
  //Create Ordered Product Records with Asset and product
  //----------------------------------------------------------------------------
  public static list<Ordered_Product__c> createTestOrderProduct1(Integer orderProdSize,
                                                                License_Order__c licOrder,
                                                                Asset asset,
                                                                Product2 product,
                                                                Boolean isInsert)
  {
    list<Ordered_Product__c> ops = new list<Ordered_Product__c>();
    for(Integer i = 0; i < orderProdSize; i++)
    {
      Ordered_Product__c op = new Ordered_Product__c();
      op.License_Order__c   = licOrder.Id;
      op.Asset__c           = asset.Id;
      op.Product__c         = product.Id;      
      ops.add(op);
    } 
    if(isInsert)
      insert ops;
    return ops; 
  }
    
  //----------------------------------------------------------------------------
  //Create Associated Site Records for Supported Products => added for 4148 Link Associated Sites during Consolidation
  //----------------------------------------------------------------------------
  public static list<Associated_Sites__c> createAssoSites(Integer AssociatedSiteSize,
                                                          Account acc,
                                                          ID SPid,                                                                
                                                          Boolean isInsert)
  {
    list<Associated_Sites__c> lstAsst = new list<Associated_Sites__c>();
    
    for(Integer i = 0; i < AssociatedSiteSize; i++)
    {
      Associated_Sites__c ast = new Associated_Sites__c();
      ast.Account_Site__c = acc.Id;
      ast.Supported_Product__c = SPid;        
      lstAsst.add(ast);
    } 
    
    if(isInsert) 
        insert lstAsst;
    return lstAsst; 
  }  
    //Create Opportunity record for testclass created by Rajesh patel
  public static list<Opportunity> createOpportunity(Integer opportunitySize, 
                                                        Account acc,
                                                        Boolean isUpsert )
  {
    list<Opportunity> opps = new list<Opportunity>();
    for(Integer i = 0; i < opportunitySize; i++)
    {  
      Opportunity opp = new Opportunity();    
               opp.Name = 'Test'+i ;
               opp.AccountId=acc.id;
               opp.CurrencyIsoCode = 'USD';
               opp.CloseDate = system.today();
               opp.BU_Code__c ='2872 - Network Control';
               opp.Type = 'New Client';
               opp.StageName ='Won';
               opp.Probability = 100;
               opp.Area__c ='AMR';
               opp.FES_Region__c='NEU';
               opp.Territory__c ='Account Management';
               opp.Opportunity_Country__c=' United States (US)';
               opp.Forecast_Call__c='won';
               Id OppRecordTypeName = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Operations Opportunity Record Type').getrecordTypeId();
               opp.recordTypeId = OppRecordTypeName;
               opp.Industry__c = 'Distribution';
               opp.BidType__c = 'Sole Sourced';
               opp.Amount = 500 +i;     
    
               opps.add(opp);
        }   
    if(isUpsert)
      Upsert opps;
    return opps;           
  }
           

}