<cfoutput>
    <div class="control-group">
        <label for="submenu" class="control-label">Select Sub-menu:</label>
        <div class="controls">
            <select name="submenu" id="submenu" class="textfield width95" required="true" title="Select a submenu">
                <cfloop array="#args.menus#" index="menu">
                    <option value="#menu.getMenuID()#">#menu.getTitle()#</option>
                </cfloop>
            </select>
        </div>
    </div>
</cfoutput>