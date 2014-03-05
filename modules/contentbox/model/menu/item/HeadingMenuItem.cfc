component persistent="true" entityName="cbHeadingMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="Heading" {
    // DI
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.HeadingProvider";

    /**
     * Get a flat representation of this menu item
     */
    public struct function getMemento(){
        var result = super.getMemento();
        return result;
    }
}