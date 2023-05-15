<aura:application >
	 <lightning:buttonGroup>
        <lightning:button label="Success" onclick="{!c.handleSuccess}"/>
        <lightning:button label="Warning" onclick="{!c.handleWarning}"/>
        <lightning:button label="Error" onclick="{!c.handleError}"/>
    </lightning:buttonGroup>
    <c:customToast aura:id="toastCmp"/>
</aura:application>