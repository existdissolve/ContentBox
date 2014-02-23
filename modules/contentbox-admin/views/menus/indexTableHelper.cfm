<cfoutput>
<script type="text/javascript">
$(document).ready(function() {
    // tables references
    $menu = $("##menu");
    // sorting
    $menu.tablesorter();
    // activate confirmations
    activateConfirmations();
    // activate tooltips
    activateTooltips();
    // Popovers
    activateInfoPanels();
});
</script>
</cfoutput>