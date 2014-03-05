component persistent="true" entityName="cbURLMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="URL" {
    property name="url" notnull="false" ormtype="string" default="";
    // DI
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.URLProvider";

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var result = super.getMemento();
        // add our subclasses's properties
        result[ "url" ] = getURL();
        return result;
    }
}