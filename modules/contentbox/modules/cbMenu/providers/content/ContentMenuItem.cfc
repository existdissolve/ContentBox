component persistent="true" entityName="cbContentMenuItem" table="cb_menuItem" extends="contentbox.modules.cbMenu.model.BaseMenuItem" discriminatorValue="Content" {
    // M20 - Content Items
    property name="content" cfc="contentbox.model.content.BaseContent"  fieldtype="many-to-one" fkcolumn="FK_contentID" lazy="true";
}