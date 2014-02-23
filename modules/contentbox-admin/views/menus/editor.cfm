<cfoutput>
    #html.startForm( action=prc.xehMenuSave, name="menuForm", novalidate="novalidate", class="form-vertical" )#
    <div class="row-fluid" id="main-content">
        <div class="box">
            <!--- Body Header --->
            <div class="header">
                <i class="icon-tags icon-large"></i>
                Menus
            </div>
            <!--- Body --->
            <div class="body row-fluid">
                <!--- MessageBox --->
                #getPlugin( "MessageBox" ).renderit()#
                <span  class="span9">
                    <h3>Menu Designer</h3>
                    <div>
                        <cfloop collection="#prc.providers#" item="provider">
                            <button class="btn provider" data-provider="#provider#" title="#prc.providers[ provider].getDescription()#">#provider#</button>
                        </cfloop>
                    </div>
                    <div class="dd" id="nestable">
                        <ol class="dd-list">
                            #prc.menuItems#
                        </ol>
                    </div>
                </span >
                <span class="span3">
                    <h3>Menu Meta</h3>
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
                        class="textfield width70",
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
                        class="textfield width70",
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
                        class="textfield width70",
                        wrapper="div class=controls",
                        labelClass="control-label",
                        groupWrapper="div class=control-group"
                    )#
                </span>
            </div>
        </div>
    </div>
    #html.endForm()#
</cfoutput>