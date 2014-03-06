/**
* Comment Cleanup interceptor
*/
component extends="coldbox.system.Interceptor"{
    // DI
    property name="menuItemService" inject="id:menuItemService@cb";

    /**
    * Configure
    */
    function configure(){}

    public void function cbadmin_postPageSave( required any event, required struct interceptData ) async="true" {
        var criteria = menuItemService.newCriteria();
        var menuItemsInNeed = criteria.eq( "contentSlug", "#arguments.interceptData.originalSlug#" ).list();
        for( var menuItem in menuItemsInNeed ){
            menuItem.setContentSlug( arguments.interceptData.page.getSlug() );
            menuItemService.save( entity=menuItem );
        }
    }

    public void function cbadmin_postEntrySave( required any event, required struct interceptData ) async="true" {
        var criteria = menuItemService.newCriteria();
        var menuItemsInNeed = criteria.eq( "contentSlug", "#arguments.interceptData.originalSlug#" ).list();
        for( var menuItem in menuItemsInNeed ){
            menuItem.setContentSlug( arguments.interceptData.entry.getSlug() );
            menuItemService.save( entity=menuItem );
        }
    }

    public void function cbadmin_postMenuSave( required any event, required struct interceptData ) async="true" {
        // Update all affected menuitems if any on slug updates
        var criteria = menuItemService.newCriteria();
        var menuItems = criteria.eq( "menuSlug", "#arguments.interceptData.originalSlug#" ).list();
        for( var item in menuItems ){
            item.setMenuSlug( arguments.interceptData.menu.getSlug() );
            menuItemService.save( entity=item  );
        }
    }

    public void function fb_postFileRename( required any event, required struct interceptData ) async="true" {
        var rc = event.getCollection();
        // make sure we have settings
        if( structKeyExists( rc, "filebrowser" ) ) {
            var settings = rc.filebrowser.settings;
            // old path is full path from directoryRoot up...so strip that out
            var oldFileName = replaceNoCase( arguments.interceptData.original, settings.directoryRoot, '', 'all' );
            // match with mediaPath and leftover name
            var matcher = settings.mediaPath & oldFileName;
            // Update all affected menuitems if any on slug updates
            var criteria = menuItemService.newCriteria();
            var menuItems = criteria.eq( "mediaPath", "#matcher#" ).list();
            for( var item in menuItems ){
                item.setMediaPath( settings.mediaPath & "/" & arguments.interceptData.newName );
                menuItemService.save( entity=item  );
            }
        }
    }    
}