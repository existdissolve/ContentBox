<cfoutput>

        <div id="modalContent">
            <div class="modal-header">
                <i class="icon-tags icon-large"></i>
                Create #rc.type# Menu Item
            </div>
            <div class="modal-body">
                <!--- Body --->
                <!---here are the default fields that we need for every menu item--->
                <h3>Menu Meta</h3>
                <!--- id --->
                #html.hiddenField( name="menuItemID", bind=prc.menuItem )#    
                <!--- title --->
                #html.textfield(
                    label="Title:",
                    name="title",
                    bind=prc.menuItem, 
                    maxlength="100",
                    required="required",
                    title="The title for this menu item",
                    class="textfield width98",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="Label:",
                    name="label",
                    bind=prc.menuItem, 
                    maxlength="100",
                    required="required",
                    title="The label for this menu item",
                    class="textfield width98",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="CSS Classes:",
                    name="cls",
                    bind=prc.menuItem, 
                    maxlength="100",
                    title="Additional CSS classes to use for this menu item's HTML element",
                    class="textfield width98",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="Data Attributes:",
                    name="data",
                    bind=prc.menuItem, 
                    maxlength="100",
                    title="Data attributes to set on this menu item's HTML element",
                    class="textfield width98",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                <!---End default fields--->

                <!---do provider thing--->
                #prc.provider.getAdminTemplate( prc.menuItem )#
                <!---end provider thing--->
            </div>
            <div class="modal-footer">
                #html.resetButton( name="btnReset", value="Cancel", class="btn", onclick="closeRemoteModal()" )#
                #html.submitButton( name="btnSave", value="Add Menu Item", class="btn btn-danger" )#
            </div>
        </div>
</cfoutput>