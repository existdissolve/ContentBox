<cfoutput>
      #html.textarea(
            label="JavaScript Code:",
            name="js",
            bind=prc.menuItem, 
            maxlength="100",
            required="required",
            title="JavaScript to be executed when this item is clicked",
            class="textfield width98",
            wrapper="div class=controls",
            labelClass="control-label",
            groupWrapper="div class=control-group"
      )#
</cfoutput>