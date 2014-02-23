<cfoutput>
<!--- Load Content List Viewer UI --->
#renderView(view="_tags/contentListViewer", prePostExempt=true)#
<!--- page JS --->
<script type="text/javascript">
$(document).ready(function() {
    // Setup content view
    setupContentView({ 
        tableContainer  : $("##menuTableContainer"), 
        tableURL        : '#event.buildLink( prc.xehMenuTable )#',
        searchField     : $("##contentMenu"),
        searchName      : 'searchMenu',
        contentForm     : $("##menuForm"),
        importDialog    : $("##importDialog")
    });
    
    // load content on startup, using default parents if passed.
    contentLoad( {} );
    console.log( 'hi')
});
</script>
</cfoutput>