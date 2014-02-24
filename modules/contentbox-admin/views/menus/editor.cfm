<cfoutput>
<div class="row-fluid">
    #html.startForm( action=prc.xehMenuSave, name="menuForm", novalidate="novalidate", class="form-vertical" )#
    <div class="span9" id="main-content">
        <div class="box">
            <!--- Body Header --->
            <div class="header">
                <i class="icon-tags icon-large"></i>
                Menu Designer
            </div>
            <!--- Body --->
            <div class="body row-fluid">
                <!--- MessageBox --->
                #getPlugin( "MessageBox" ).renderit()#
                <div>
                    <cfloop collection="#prc.providers#" item="provider">
                        <a class="btn provider" data-provider="#provider#" title="#prc.providers[ provider].getDescription()#">#provider#</a>
                    </cfloop>
                </div>
                <div class="dd" id="nestable">
                    <ol class="dd-list">
                        #prc.menuItems#
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!--- main sidebar --->
    <div class="span3" id="main-sidebar">
        <!--- Info Box --->
        <div class="small_box">
            <div class="header">
                <i class="icon-cogs"></i> Actions
            </div>
            <div class="body">
                <!--- id --->
                #html.hiddenField( name="menuID", bind=prc.menu )#    
                <!--- title --->
                #html.textfield(
                    label="Title:",
                    name="title",
                    bind=prc.menu, 
                    maxlength="100",
                    required="required",
                    title="The title for this menu",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="Slug:",
                    name="slug",
                    bind=prc.menu, 
                    maxlength="100",
                    required="required",
                    title="The unique slug for this menu",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                #html.textfield(
                    label="CSS Classes:",
                    name="cls",
                    bind=prc.menu, 
                    maxlength="100",
                    title="Additional CSS classes to use for the main menu HTML element",
                    class="textfield width95",
                    wrapper="div class=controls",
                    labelClass="control-label",
                    groupWrapper="div class=control-group"
                )#
                <div class="actionBar">
                    <a class="btn btn-danger" id="submitMenu">Save Menu</a>
                </div>
            </div>
        </div>
    </div>
    #html.endForm()#
</div>
</cfoutput>