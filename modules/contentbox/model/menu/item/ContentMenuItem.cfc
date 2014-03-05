component persistent="true" entityName="cbContentMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="Content" {
    // simple content
    property name="contentSlug" notnull="false" ormtype="string" default="";
    // di 
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.ContentProvider";

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var result = super.getMemento();
        // add our subclasses's properties
        result[ "contentSlug" ] = getContentSlug();
        return result;
    }
}