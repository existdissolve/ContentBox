component persistent="true" entityName="cbURLMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="URL" {
    property name="url" notnull="false" ormtype="string" default="";
}