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
 * Provider for URL-type menu items
 */
component implements="contentbox.model.menu.providers.IMenuItemProvider" extends="contentbox.model.menu.providers.BaseProvider" accessors=true {

    /**
     * Constructor
     */
    public URLProvider function init() {
        setName( "URL" );
        setType( "URL" );
        setIconCls( "icon-link" );
        setEntityName( "cbURLMenuItem" );
        setDescription( "A menu item to a URL" );
        return this;
    }
    /**
     * Gets the name of the menu item provider
     */
    public string function getName() {
        return name;
    }

    /**
     * Gets the entityName for the menu item provider
     */
    public string function getEntityName() {
        return entityName;
    }

    /**
     * Gets the name of the menu item provider
     */
    public string function getType() {
        return type;
    }

    /**
     * Gets the iconCls of the menu item provider
     */
    public string function getIconCls() {
        return iconCls;
    }

    /**
     * Retrieves template for use in admin screens for this type of menu item provider
     */ 
    public string function getAdminTemplate( required any menuItem, any event ) {
        var args = { 
            menuItem=arguments.menuItem
        };
        return renderer.get().renderExternalView( 
            view="contentbox/model/menu/providers/url/admin", 
            module="contentbox",
            args = args
        );
    }

    /**
     * Retrieves template for use in rendering menu item on the site
     * @menuItem.hint The menu item object
     * @args.hint Additional arguments to be used in the method
     */ 
    public string function getDisplayTemplate( required any menuItem, required struct args={} ) {
        var viewArgs = {
            menuItem=arguments.menuItem,
            data = arguments.menuItem.getMemento()
        };
        return renderer.get().renderExternalView( 
            view="contentbox/model/menu/providers/url/display", 
            module="contentbox",
            args = viewArgs
        );
    }

    /**
     * Custom validator for this menu item provider...any rules can be applied
     */
    public array function validate() {
        var errors = [];
        return errors;
    }

    /**
     * Determines if menu item provider is valid based on validation criteria
     */
    public boolean function isValid() {
        return !arrayLen( validate() );
    }
}