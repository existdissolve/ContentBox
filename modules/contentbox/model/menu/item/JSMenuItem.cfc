component persistent="true" entityName="cbJSMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="JS" {
    property name="js" notnull="false" ormtype="string" default="";
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.js.JSProvider";
}