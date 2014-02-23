component persistent="true" entityName="cbMenuItem" table="cb_menuItem" cachename="cbMenuItem" cacheuse="read-write" discriminatorColumn="menuType" {
    // DI Injections
    property name="menuItemService" inject="menuItemService@cb" persistent="false";
    // Non-relational Properties
    property name="menuItemID" fieldtype="id" generator="native" setter="false";
    property name="title"   notnull="true"  ormtype="string" length="200" default="" index="idx_menuitemtitle";
    property name="label"   notnull="false" ormtype="string" length="200" default="";
    property name="cls"     notnull="false" ormtype="string" length="200" default="";
    property name="data"    notnull="false" ormtype="string" default="";
    // M20 - Owning menu
    property name="menu" cfc="contentbox.model.menu.Menu" fieldtype="many-to-one" fkcolumn="FK_menuID" lazy="true" fetch="join" notnull="true";
    // M20 - Parent Menu item
    property name="parent"  cfc="BaseMenuItem" fieldtype="many-to-one" fkcolumn="FK_parentID" lazy="true";
    // O2M - Child Menu Item
    property name="children" singularName="child" fieldtype="one-to-many" type="array" lazy="extra" batchsize="25" cfc="BaseMenuItem" fkcolumn="FK_parentID" inverse="true" cascade="all-delete-orphan";
    
    /************************************** CONSTRUCTOR *********************************************/

    /**
    * constructor
    */
    BaseMenuItem function init(){
        return this;
    }

    /************************************** PUBLIC *********************************************/

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var pList = menuItemService.getPropertyNames();
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
        // Parent
        if( hasParent() ){
            result[ "parent" ] = {
                menuID = getParent().getmenuID(),
                slug = getParent().getSlug(),
                title = getParent().getTitle()
            };
        }
        // Children
        if( hasChild() ){
            result[ "children" ] = [];
            for( var thisChild in variables.children ){
                arrayAppend( result[ "children" ], thisChild.getMemento() );    
            }
        }
        else{
            result[ "children" ] = [];
        }
        return result;
    }
}