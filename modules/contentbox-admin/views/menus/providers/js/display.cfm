<cfoutput>
    <cfset udfName = "udf#args.menuItem.getMenuItemID()#">
    <script>
        function #udfName#Callback() {
            (#args.menuItem.getJS()#).call();
        }
    </script>
    <a onclick="#udfName#Callback()">#args.menuItem.getLabel()#</a>
</cfoutput>