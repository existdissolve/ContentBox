<cfoutput>
    <div class="dd-handle dd3-handle">Drag</div>
    <div class="dd3-type">Type</div>
    <!---<cfif args.menuItem.hasChild() >
        <button data-action="collapse" type="button" style="display: none;">Collapse</button>
        <button data-action="expand" type="button" style="display: block;">Expand</button>
    </cfif>--->
    <div class="dd3-content double">#args.menuItem.getLabel()#</div>
    <div class="dd3-extracontent" style="display:none;">

        <!---<div id="modalContent">
            <div class="modal-header">
                <i class="icon-tags icon-large"></i>
                Create #rc.type# Menu Item
            </div>
            <div class="modal-body">
                <!--- Body --->
                <!---here are the default fields that we need for every menu item--->
                <h3>Menu Meta</h3>--->
                <!--- id --->
                #html.hiddenField( name="menuItemID", bind=args.menuItem )#  
                <div class="row-fluid">
                <span class="span6">
                #html.textfield(
                    label="Label:",
                    name="label",
                    bind=args.menuItem, 
                    maxlength="100",
                    required="required",
                    title="The label for this menu item",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="Data Attributes:",
                    name="data",
                    bind=args.menuItem, 
                    maxlength="100",
                    title="Data attributes to set on this menu item's HTML element",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                </span>
                <span class="span6">
                <!--- title --->
                #html.textfield(
                    label="Title:",
                    name="title",
                    bind=args.menuItem, 
                    maxlength="100",
                    required="required",
                    title="The title for this menu item",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="CSS Classes:",
                    name="cls",
                    bind=args.menuItem, 
                    maxlength="100",
                    title="Additional CSS classes to use for this menu item's HTML element",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                </span>
                </div>
                <div class="row-fluid">
                <!---End default fields--->

                <!---do provider thing--->
                #args.provider.getAdminTemplate( menuItem=args.menuItem, event=event )#
                </div>
                <!---end provider thing--->
            <!---</div>
            <div class="modal-footer">
                #html.resetButton( name="btnReset", value="Cancel", class="btn", onclick="closeRemoteModal()" )#
                #html.submitButton( name="btnSave", value="Add Menu Item", class="btn btn-danger" )#
            </div>--->
    </div>
    <div class="dd3-expand"><i class="icon-edit icon-large"></i></div>
</cfoutput>