<aura:application extends = "force:slds">
    <!-- <c:globalValueProviders/>-->
    <c:nestedComp/>
    <lightning:card>
<aura:set attribute="title">My Account</aura:set>
<aura:set attribute="footer">Footer</aura:set>
<aura:set attribute="actions">
<lightning:button label="New"/>
</aura:set>
<p class="slds-p-horizontal_small">
Card Body
</p>
      
</lightning:card>
      <c:attributeValueInJs/>
</aura:application>