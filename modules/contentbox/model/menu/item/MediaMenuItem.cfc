component persistent="true" entityName="cbMediaMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="Media" {
    property name="mediaPath" notnull="false" ormtype="string" default="";
}