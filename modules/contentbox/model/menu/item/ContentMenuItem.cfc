component persistent="true" entityName="cbContentMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="Content" {
    // simple content
    property name="contentSlug" notnull="false" ormtype="string" default="";
    // M20 - Content Items
    //property name="content" cfc="contentbox.model.content.BaseContent"  fieldtype="many-to-one" fkcolumn="FK_contentID" lazy="true";
    // di 
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.content.ContentProvider";
}