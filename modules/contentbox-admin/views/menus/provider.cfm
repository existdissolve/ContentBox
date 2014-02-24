<cfoutput>
    <div class="dd-handle dd3-handle" title="Drag to reorder"><i class="icon-move icon-large"></i></div>
    <div class="dd3-type" title="#args.provider.getDescription()#"><i class="#args.provider.getIconCls()#"></i></div>
    <div class="dd3-content double">#args.menuItem.getLabel()#</div>
    <div class="dd3-extracontent" style="display:none;">
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
    </div>
    <div class="dd3-expand" title="Edit Details"><i class="icon-edit icon-large"></i></div>
    <div class="dd3-delete" data-toggle="confirmation" data-title="Are you sure you want to remove this menu item and all its descendants?"><i class="icon-trash icon-large"></i></div>
</cfoutput>