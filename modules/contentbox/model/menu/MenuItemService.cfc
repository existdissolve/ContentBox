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
* Service to handle menu operations.
*/
component extends="coldbox.system.orm.hibernate.VirtualEntityService" accessors="true" singleton {  
    property name="providers" type="array";  
    property name="wirebox" inject="wirebox";
    /**
    * Constructor
    */
    MenuItemService function init(){
        // init it
        super.init( entityName="cbMenuItem" );
        this.providers = [];
        return this;
    }

    function onDIComplete(){
        registerProvider( type="URL", providerPath="contentbox.model.menu.providers.url.URLProvider" );
        registerProvider( type="Content", providerPath="contentbox.model.menu.providers.content.ContentProvider" );
        registerProvider( type="JS", providerPath="contentbox.model.menu.providers.js.JSProvider" );
        registerProvider( type="Media", providerPath="contentbox.model.menu.providers.media.MediaProvider" );
        registerProvider( type="SubMenu", providerPath="contentbox.model.menu.providers.submenu.SubMenuProvider" );
        registerProvider( type="Heading", providerPath="contentbox.model.menu.providers.heading.HeadingProvider" );
    }

    public MenuItemService function registerProvider( required string type, required string providerPath ) {
        variables.providers[ arguments.type ] = wirebox.getInstance( arguments.providerPath );
        return this;
    }

    public MenuItemService function unRegisterProvider( required string type ) {
        structDelete( variables.providers, arguments.type );
        return this;
    }

    public any function getProvider( required string type ) {
        return variables.providers[ arguments.type ];
    }
}