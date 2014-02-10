component persistent="true" entityName="cbSubMenuItem" table="cb_menuItem" extends="contentbox.modules.cbMenu.model.BaseMenuItem" discriminatorValue="SubMenu" {
    // M20 - SubMenu
    property name="subMenu" cfc="contentbox.modules.cbMenu.model.Menu" fieldtype="many-to-one" fkcolumn="FK_subMenuID" lazy="true" fetch="join";
}