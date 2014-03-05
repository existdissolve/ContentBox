component persistent="true" entityName="cbMediaMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="Media" {
    property name="mediaPath" notnull="false" ormtype="string" default="";
    // DI
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.MediaProvider";

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var result = super.getMemento();
        // add our subclasses's properties
        result[ "mediaPath" ] = getMediaPath();
        return result;
    }
}