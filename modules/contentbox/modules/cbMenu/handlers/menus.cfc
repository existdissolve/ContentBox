/**
* Manage custom site menus
*/
component {

    // Dependencies
    property name="menuService" inject="id:menuService@cbMenu";
    property name="menuItemService" inject="id:menuItemService@cbMenu";
    property name="cb" inject="cbHelper@cb";
    
    // pre handler
    function preHandler( event, action, eventArguments ){
        var rc  = event.getCollection();
        var prc = event.getCollection( private=true );
        prc.cbAdminEntryPoint = getModuleSettings( "contentbox-admin" ).entryPoint;
        prc.entryPoint = getModuleSettings( "contentbox-menu" ).entryPoint;
        // Tab control
        prc.tabContent = true;
    }
    
    // index
    public void function index( required any event, required struct rc, required struct prc ){
        // exit Handlers
        prc.xehMenuRemove  = cb.buildModuleLink( "cbMenu", "menus.remove" );
        prc.xehMenuSave    = cb.buildModuleLink( "cbMenu", "menus.save" );
        prc.xehExportAll   = cb.buildModuleLink( "cbMenu", "menus.exportAll" );
        prc.xehMenuImport  = cb.buildModuleLink( "cbMenu", "menus.importAll" );
        prc.xehMenuEditor  = cb.buildModuleLink( "cbMenu", "menus.editor" );
        // Get all menus
        prc.menus = menuService.list( sortOrder="title", asQuery=false );
        // Tab
        prc.tabContent_menus = true;
        // view
        event.setView( view="index" );
    }

    // editor
    public void function editor( required any event, required struct rc, required struct prc ){
        // get new or persisted
        prc.menu  = menuService.get( event.getValue( "menuID", 0 ) );
        // load menu items if persisted
        //if( prc.menu.isLoaded() ){}       
        // exit handlers
        prc.xehMenuSave   = cb.buildModuleLink( "cbMenu", "menus.save" );
        // Tab
        prc.tabContent = true;
        // get registered providers
        prc.providers = menuItemService.getProviders();
        // view
        event.setView( "editor" );
    }

    public void function createMenuItem( required any event, required struct rc, required struct prc ) {
        prc.provider = menuItemService.getProvider( arguments.rc.type );
        // get new or persisted
        prc.menuItem  = entityNew( prc.provider.getEntityName() );//menuItemService.get( event.getValue( "menuItemID", 0 ) );
        event.setView( view="provider", layout="ajax" );
    }

    // save
    public void function save( required any event, required struct rc, required struct prc ){
        // slugify if not passed, and allow passed slugs to be saved as-is
        if( !len( rc.slug ) ) { 
            rc.slug = getPlugin( "HTMLHelper" ).slugify( rc.title ); 
        }
        // populate and get menu
        var Menu = populateModel( menuService.get( id=rc.menuID ) );
        // announce event
        announceInterception( "cbadmin_preMenuSave", { menu=Menu, menuID=rc.menuID } );
        // save menu
        menuService.save( Menu );
        // announce event
        announceInterception( "cbadmin_postMenuSave", { menu=Menu } );
        // messagebox
        getPlugin( "MessageBox" ).setMessage( "info", "Menu saved!" );
        // relocate
        setNextEvent(prc.xehCategories);
    }
    
    // remove
    public void function remove( required any event, required struct rc, required struct prc ){
        // params
        event.paramValue( "menuID", "" );
        
        // verify if contentID sent
        if( !len( rc.menuID ) ){
            getPlugin( "MessageBox" ).warn( "No categories sent to delete!" );
            setNextEvent( event=prc.xehMenus );
        }
        
        // Inflate to array
        rc.menuID = listToArray( rc.menuID );
        var messages = [];
        
        // Iterate and remove
        for( var thisMenuID in rc.menuID ){
            var Menu = menuService.get( thisMenuID );
            if( isNull( Menu ) ){
                arrayAppend( messages, "Invalid menuID sent: #thisMenuID#, so skipped removal" );
            }
            else{
                // GET id to be sent for announcing later
                var menuID  = Menu.getMenuID();
                var title   = Menu.getSlug();
                // announce event
                announceInterception("cbadmin_preMenuRemove", { menu=Menu, menuID=menuID } );
                // Delete it
                menuService.delete( Menu.removeAllContent() ); 
                arrayAppend( messages, "Menu '#title#' removed" );
                // announce event
                announceInterception( "cbadmin_postMenuRemove", { menuID=menuID } );
            }
        }
        
        // messagebox
        getPlugin( "MessageBox" ).info(messageArray=messages);
        setNextEvent( prc.xehMenus );
    }

    // export all menus
    public void function exportAll( required any event, required struct rc, required struct prc ){
        event.paramValue( "format", "json" );
        // get all prepared content objects
        var data  = menuService.getAllForExport();
        // export based on format
        switch( rc.format ){
            case "xml" : case "json" : {
                var filename = "Menus." & ( rc.format eq "xml" ? "xml" : "json" );
                event.renderData( data=data, type=rc.format, xmlRootName="menus" )
                    .setHTTPHeader( name="Content-Disposition", value=" attachment; filename=#fileName#" ); 
                break;
            }
            default: {
                event.renderData( data="Invalid export type: #rc.format#" );
            }
        }
    }
    
    // import menus
    public void function importAll( required any event, required struct rc, required struct prc ){
        event.paramValue( "importFile", "" );
        event.paramValue( "overrideContent", false );
        try {
            if( len( rc.importFile ) and fileExists( rc.importFile ) ){
                var importLog = menuService.importFromFile( importFile=rc.importFile, override=rc.overrideContent );
                getPlugin( "MessageBox" ).info( "Menus imported sucessfully!" );
                flash.put( "importLog", importLog );
            }
            else{
                getPlugin("MessageBox").error( "The import file is invalid: #rc.importFile# cannot continue with import" );
            }
        }
        catch( any e ){
            var errorMessage = "Error importing file: #e.message# #e.detail# #e.stackTrace#";
            log.error( errorMessage, e );
            getPlugin( "MessageBox" ).error( errorMessage );
        }
        setNextEvent( prc.xehMenus );
    }
}
