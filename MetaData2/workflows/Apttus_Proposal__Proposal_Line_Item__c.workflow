<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Service_Section_on_proposal</fullName>
        <field>ServiceSectiononproposal__c</field>
        <literalValue>1</literalValue>
        <name>Service Section on proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Apttus_Proposal__Proposal__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Software_Section_on_proposal</fullName>
        <field>SoftwareSection__c</field>
        <literalValue>1</literalValue>
        <name>Software Section on proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Apttus_Proposal__Proposal__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_End_date</fullName>
        <field>End_Date__c</field>
        <formula>Apttus_QPConfig__EndDate__c</formula>
        <name>Update End date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Start_Date</fullName>
        <field>Start_Date__c</field>
        <formula>Apttus_QPConfig__StartDate__c</formula>
        <name>Update Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Check is New when created</fullName>
        <actions>
            <name>Update_the_proposal_line_item_is_new_box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Product_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Check the IS NEW checkbox when the record is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Service Section on proposal</fullName>
        <actions>
            <name>Service_Section_on_proposal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>Consulting</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>Managed Services</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Software Section on proposal</fullName>
        <actions>
            <name>Software_Section_on_proposal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4</booleanFilter>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>Licenses</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>Maintenance</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>SaaS</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus_Proposal__Proposal_Line_Item__c.Revenue_Stream__c</field>
            <operation>equals</operation>
            <value>Hardware</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Date Fields</fullName>
        <actions>
            <name>Update_End_date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
