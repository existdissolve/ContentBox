component persistent="true" entityName="cbURLMenuItem" table="cb_menuItem" extends="contentbox.modules.cbMenu.model.BaseMenuItem" discriminatorValue="URL" {
    property name="url" notnull="false" ormtype="string" default="";
}