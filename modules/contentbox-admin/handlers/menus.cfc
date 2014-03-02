/**
* Manage custom site menus
*/
component extends="baseHandler" {

    // Dependencies
    property name="menuService"     inject="id:menuService@cb";
    property name="menuItemService" inject="id:menuItemService@cb";
    property name="settingService" inject="id:settingService@cb";
    
    // Public properties
    this.preHandler_except = "pager";

    // pre handler
    function preHandler(event,action,eventArguments){
        var rc  = event.getCollection();
        var prc = event.getCollection(private=true);
        // exit Handlers
        prc.xehMenus      = "#prc.cbAdminEntryPoint#.menus";
        prc.xehMenuEditor = "#prc.cbAdminEntryPoint#.menus.editor";
        prc.xehMenuRemove = "#prc.cbAdminEntryPoint#.menus.remove";
        // Tab control
        prc.tabContent = true;
    }
    
    // index
    function index( required any event, required struct rc, required struct prc ){
        // exit Handlers
        prc.xehMenuSave   = "#prc.cbAdminEntryPoint#.menus.save";
        prc.xehMenuExportAll= "#prc.cbAdminEntryPoint#.menus.exportAll";
        prc.xehMenuImport  = "#prc.cbAdminEntryPoint#.menus.importAll";
        prc.xehMenuEditor = "#prc.cbAdminEntryPoint#.menus.editor";
        prc.xehMenuSearch  = "#prc.cbAdminEntryPoint#.menus";
        prc.xehMenuTable= "#prc.cbAdminEntryPoint#.menus.menuTable";
        // Get all menus
        prc.menus = menuService.list( sortOrder="title", asQuery=false );
        // Tab
        prc.tabContent_menus = true;
        // view
        event.setView( "menus/index" );
    }

    function filebrowser( required any event, required struct rc, required struct prc ) {
        prc.defaultEvent = "contentbox-filebrowser:home.index";
        // CKEditor callback
        rc.callback="fbMenuItemSelect";
        // get settings according to contentbox
        prc.cbSetting = settingService.buildFileBrowserSettings();
        // load jquery as it is standalone
        prc.cbSetting.loadJQuery = true;

        var args = { widget=true, settings=prc.cbSetting };
        return runEvent( event=prc.defaultEvent, eventArguments=args );
    }

    // editor
    public void function editor( required any event, required struct rc, required struct prc ){
        // get new or persisted
        prc.menu  = menuService.get( event.getValue( "menuID", 0 ) );                       
        prc.menuItems = menuService.buildEditableMenu( prc.menu.getMenuItems() );
        // exit handlers
        prc.xehMenuSave   = "#prc.cbAdminEntryPoint#.menus.save";
        prc.xehMenuItem   = "#prc.cbAdminEntryPoint#.menus.createMenuItem";
        // Tab
        prc.tabContent = true;
        // get registered providers
        prc.providers = menuItemService.getProviders();
        // add assets
        rc.cssAppendList = "nestable";       
        rc.jsAppendList  = "jquery.nestable,bootstrap-confirmation";        
        // view
        event.setView( "menus/editor" );
    }

    public void function createMenuItem( required any event, required struct rc, required struct prc ) {
        prc.provider = menuItemService.getProvider( arguments.rc.type );
        // get new or persisted
        var args = {
            menuItem  = entityNew( prc.provider.getEntityName() ),
            provider = prc.provider
        };
        var str = '<li class="dd-item dd3-item" data-id="new-#createUUID()#">';
        savecontent variable="menuString" {
            writeoutput(renderView( 
                view="menus/provider", 
                args = args
            ));
        };
        str &= menuString & "</li>";
        event.renderData( data=str, type="text" );
    }

    // menuTable
    function menuTable( event, rc, prc ){
        // params
        event.paramValue("page",1);
        event.paramValue("searchContent","");
        event.paramValue("isFiltering", false, true);
        event.paramValue("showAll", false);

        // prepare paging plugin
        prc.pagingPlugin    = getMyPlugin( plugin="Paging", module="contentbox" );
        prc.paging          = prc.pagingPlugin.getBoundaries();
        prc.pagingLink      = "javascript:contentPaginate(@page@)";
        
        // is Filtering?
        if( rc.showAll ) { 
            prc.isFiltering = true;
        }
        // search content with filters and all
        var results = menuService.search(search=rc.searchContent,
                                         offset=( rc.showAll ? 0 : prc.paging.startRow-1 ),
                                         max=( rc.showAll ? 0 : prc.cbSettings.cb_paging_maxrows ),
                                         sortOrder="createdDate desc");
        prc.menus = results.menus;
        prc.menuCount = results.count;

        // exit handlers
        prc.xehMenuSearch        = "#prc.cbAdminEntryPoint#.contentStore";
        prc.xehMenuExport        = "#prc.cbAdminEntryPoint#.contentStore.export";        
        // view
        event.setView(view="menus/indexTable", layout="ajax");
    }

    // save
    public void function save( required any event, required struct rc, required struct prc ){
        // slugify if not passed, and allow passed slugs to be saved as-is
        if( !len( rc.slug ) ) { 
            rc.slug = getPlugin( "HTMLHelper" ).slugify( rc.title ); 
        }
        
        // populate and get menu
        var Menu = populateModel( model=menuService.get( id=rc.menuID ), exclude="menuItems" );
        // clear menu items
        arrayClear( Menu.getMenuItems() );
        // populate items from form
        var items = Menu.populateMenuItems( rawData=deserializeJSON( rc.menuItems ) );
        for( var item in items ) {
            Menu.addMenuItem( item );
        }
        // announce event
        announceInterception( "cbadmin_preMenuSave", { menu=Menu, menuID=rc.menuID } );
        // save menu
        menuService.save( Menu );
        // announce event
        announceInterception( "cbadmin_postMenuSave", { menu=Menu } );
        // messagebox
        getPlugin( "MessageBox" ).setMessage( "info", "Menu saved!" );
        // relocate
        setNextEvent( prc.xehMenus );
    }
    
    // remove
    public void function remove( required any event, required struct rc, required struct prc ){
        // params
        event.paramValue( "menuID", "" );
        
        // verify if contentID sent
        if( !len( rc.menuID ) ){
            getPlugin( "MessageBox" ).warn( "No menus sent to delete!" );
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
