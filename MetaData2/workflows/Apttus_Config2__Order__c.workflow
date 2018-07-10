<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Activate_Order</fullName>
        <description>This rule will activate the order</description>
        <field>Apttus_Config2__ActivatedDate__c</field>
        <formula>NOW()</formula>
        <name>Activate Order</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>To activate order when the  Ready For Activation Date field is not empty</fullName>
        <actions>
            <name>Activate_Order</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
