component persistent="true" entityName="cbMediaMenuItem" table="cb_menuItem" extends="contentbox.modules.cbMenu.model.BaseMenuItem" discriminatorValue="Media" {
    property name="mediaPath" notnull="false" ormtype="string" default="";
}