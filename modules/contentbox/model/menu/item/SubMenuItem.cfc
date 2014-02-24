component persistent="true" entityName="cbSubMenuItem" table="cb_menuItem" extends="contentbox.model.menu.item.BaseMenuItem" discriminatorValue="SubMenu" {
    // M20 - SubMenu
    property name="subMenu" cfc="contentbox.model.menu.Menu" fieldtype="many-to-one" fkcolumn="FK_subMenuID" lazy="true" fetch="join";
    // DI
    property name="provider" persistent="false" inject="contentbox.model.menu.providers.submenu.SubMenuProvider";
}