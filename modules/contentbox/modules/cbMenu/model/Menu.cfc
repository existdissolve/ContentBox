component persistent="true" entityName="cbMenu" table="cb_menu" cachename="cbMenu" cacheuse="read-write" {
    // DI Injections
    property name="menuService" inject="menuService@cbMenu" persistent="false";
    // Non-relational Properties
    property name="menuID" fieldtype="id" generator="native" setter="false";
    property name="title" notnull="true" ormtype="string" length="200" default="" index="idx_menutitle";
    property name="slug" notnull="true" ormtype="string" length="200" default="" unique="true" index="idx_menuslug";
    property name="cls" ormtype="string" length="160" default="";
    property name="createdDate" ormtype="timestamp" notnull="true" update="false";
    // O2M -> Comments
    property name="menuItems" singularName="menuItem" fieldtype="one-to-many" type="array" cfc="BaseMenuItem" fkcolumn="FK_menuID" cascade="all-delete-orphan" inverse="true";
    /************************************** CONSTRUCTOR *********************************************/

    /**
     * constructor
     */
    Menu function init(){
        return this;
    }

    /*
     * In built event handler method, which is called if you set ormsettings.eventhandler = true in Application.cfc
     */
    public void function preInsert(){
        setCreatedDate( now() );
    }

    /************************************** PUBLIC *********************************************/
    
    /**
     * Get a flat representation of this menu
     * slugCache.hint Cache of slugs to prevent infinite recursions
     */
    public struct function getMemento( required array slugCache=[], counter=0 ){
        var pList = menuService.getPropertyNames();
        var result = {};
        
        // Do simple properties only
        for(var x=1; x lte arrayLen( pList ); x++ ){
            if( structKeyExists( variables, pList[ x ] ) ){
                if( isSimpleValue( variables[ pList[ x ] ] ) ){
                    result[ pList[ x ] ] = variables[ pList[ x ] ]; 
                }
            }
            else{
                result[ pList[ x ] ] = "";
            }
        }
        // Comments
        if( hasMenuItem() ){
            result[ "menuItems" ] = [];
            for( var thisMenuItem in variables.menuItems ){
                arrayAppend( result[ "comments" ], thisMenuItem.getMemento() );  
            }
        }
        else{
            result[ "menuItems" ] = [];
        }
        return result;
    }
}