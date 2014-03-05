component persistent="true" entityName="cbJSMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="JS" {
    property name="js" notnull="false" ormtype="string" default="";
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.JSProvider";

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var result = super.getMemento();
        // add our subclasses's properties
        result[ "js" ] = getJS();
        return result;
    }
}