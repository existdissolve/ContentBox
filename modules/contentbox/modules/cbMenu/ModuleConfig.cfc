/**
********************************************************************************
ContentBox - A Modular Content Platform
Copyright 2012 by Luis Majano and Ortus Solutions, Corp
www.gocontentbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2012] [Luis Majano and Ortus Solutions,Corp]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************
* ContentBox Menu Management module configuration
*/
component {

    // Module Properties
    this.title              = "cbMenu";
    this.author             = "Ortus Solutions, Corp";
    this.webURL             = "http://www.ortussolutions.com";
    this.description        = "ContentBox Menu";
    this.version            = "2.0.0.@build.number@";
    this.viewParentLookup   = true;
    this.layoutParentLookup = true;
    this.entryPoint         = "cbmenu";

    function configure(){
        // Module Settings
        settings = {};
        // Parent Settings
        parentSettings = {};
        // SES Routes
        routes = [
            // Module Entry Point
            { pattern="/", handler="menus", action="index" },
            // Convention Route
            { pattern="/:handler/:action?" }
        ];
        // Custom Declared Points
        interceptorSettings = {};
        // Custom Declared Interceptors
        interceptors = [
            // CB Admin Request Interceptor
            { 
                class="contentboxer.modules.contentbox-admin.interceptors.CBRequest", 
                name="CBRequest@cbAdmin", 
                properties={ 
                    entryPoint=this.entryPoint
                }
            }
        ]; 
        // mappings
        binder.map( "menuService@cbMenu" ).to( "#moduleMapping#.model.MenuService" );
        binder.map( "menuItemService@cbMenu" ).to( "#moduleMapping#.model.MenuItemService" );
        // menu item providers
        binder.map( "URLProvider@cbMenu" ).to( "#moduleMapping#.providers.url.URLProvider" );
    }

    /**
    * Fired when the module is registered and activated.
    */
    function onLoad(){
        // Let's add ourselves to the main menu in the Modules section
        var menuService = controller.getWireBox().getInstance( "AdminMenuService@cb" );
        var menuItemService = controller.getWireBox().getInstance( "MenuItemService@cbMenu" );
        // Add Menu Contribution
        menuService.addSubMenu( 
            topMenu=menuService.MODULES,
            name=this.title,
            label=this.description,
            href="#menuService.buildModuleLink( this.title, 'menus.index' )#"
        );
        // register default providers
        menuItemService.registerProvider( type="URL", providerPath="contentbox.modules.cbMenu.providers.url.URLProvider" );
        menuItemService.registerProvider( type="Content", providerPath="contentbox.modules.cbMenu.providers.content.ContentProvider" );
        menuItemService.registerProvider( type="JS", providerPath="contentbox.modules.cbMenu.providers.js.JSProvider" );
        menuItemService.registerProvider( type="Media", providerPath="contentbox.modules.cbMenu.providers.media.MediaProvider" );
        menuItemService.registerProvider( type="SubMenu", providerPath="contentbox.modules.cbMenu.providers.submenu.SubMenuProvider" );
    }

    /**
    * Fired when the module is activated
    */
    function onActivate(){}

    /**
    * Fired when the module is unregistered and unloaded
    */
    function onUnload(){
        // Let's remove ourselves to the main menu in the Modules section
        var menuService = controller.getWireBox().getInstance( "AdminMenuService@cb" );
        // Remove Menu Contribution
        menuService.removeSubMenu( topMenu=menuService.MODULES, name="cbMenu" );
    }

    /**
    * Fired when the module is deactivated by ContentBox Only
    */
    function onDeactivate(){}
}