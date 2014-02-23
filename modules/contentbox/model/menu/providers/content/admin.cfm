<cfoutput>
    <div class="control-group">
        <label for="submenu" class="control-label">Select Content Item:</label>
        <div class="controls">
            <div class="input-prepend" style="display:block;">
                <a class="select-content add-on btn btn-success">@</a>
                <input type="hidden" name="contentID" class="textfield" required="true" />
                <input type="text" name="content" class="textfield" required="true" title="Select a content item" readonly=true />
            </div>
        </div>
    </div>
</cfoutput>