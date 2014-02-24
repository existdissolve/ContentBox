component persistent="true" entityName="cbURLMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="URL" {
    property name="url" notnull="false" ormtype="string" default="";
    // DI
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.url.URLProvider";
}