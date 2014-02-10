<!---
<cfoutput>
<!--- Custom JS --->
<script type="text/javascript">
$( document ).ready(function() {
    $menuForm = $( "##menuForm" );
    $menuEditor = $( "##menuEditor" );
    $importDialog = $( "##importDialog" );
    // table sorting + filtering
    $( "##menus" ).tablesorter();
    $( "##menuFilter" ).keyup(function(){
        $.uiTableFilter( $( "##menus" ), this.value );
    });
    // form validator
    $menuEditor.validate();
});
<cfif prc.oAuthor.checkPermission("MENUS_ADMIN,TOOLS_IMPORT")>
function bulkRemove(){
    $menuForm.submit();
}
function importContent(){
    // local id's
    var $importForm = $( "##importForm" );
    // open modal for cloning options
    openModal( $importDialog, 500, 350 );
    // form validator and data
    $importForm.validate({ 
        submitHandler: function(form){
            $importForm.find( "##importButtonBar" ).slideUp();
            $importForm.find( "##importBarLoader" ).slideDown();
            form.submit();
        }
    });
    // close button
    $importForm.find( "##closeButton" ).click(function( e ){
        closeModal( $importDialog ); return false;
    });
    // clone button
    $importForm.find( "##importButton" ).click(function( e ){
        $importForm.submit();
    });
}
function edit( menuID, title, slug ){
    openModal( $( "##menuEditorContainer" ), 500, 200 );
    $menuEditor.find( "##menuID" ).val( menuID );
    $menuEditor.find( "##title" ).val( title );
    $menuEditor.find( "##slug" ).val( slug );
}
function remove( menuID ){
    var $menuForm = $( "##menuForm" );
    $( "##delete_"+ menuID ).removeClass( "icon-remove-sign" ).addClass( "icon-spinner icon-spin" );
    $menuForm.find( "##menuID" ).val( menuID );
    $menuForm.submit();
}
function createMenu(){
    openModal( $( "##menuEditorContainer" ), 500, 200 );
    $menuEditor.find( "##menuID" ).val( '' );
    $menuEditor.find( "##title" ).val( '' );
    $menuEditor.find( "##slug" ).val( '' );
    return false;
}
</cfif>
</script>
</cfoutput>
--->