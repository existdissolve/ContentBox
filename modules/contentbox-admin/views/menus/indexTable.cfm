<cfoutput>
    <!--- menus --->
    <table name="menu" id="menu" class="tablesorter table table-hover" width="98%">
        <thead>
            <tr>
                <th id="checkboxHolder" class="{sorter:false}" width="20"><input type="checkbox" onClick="checkAll(this.checked,'contentID')"/></th>
                <th>Name</th>
                <th>Slug</th>
                <!---<th width="40" class="center"><i class="icon-globe icon-large" title="Published Status"></i></th>--->
                <th width="100" class="center {sorter:false}">Actions</th>
            </tr>
        </thead>
        
        <tbody>
            <cfloop array="#prc.menus#" index="menu">
            <tr id="contentID-#menu.getMenuID()#" data-contentID="#menu.getMenuID()#">
                <!--- check box --->
                <td>
                    <input type="checkbox" name="menuID" id="menuID" value="#menu.getMenuID()#" />
                </td>
                <td>
                    <cfif prc.oAuthor.checkPermission("MENUS_ADMIN")>
                        <a href="#event.buildLink(prc.xehMenuEditor)#/menuID/#menu.getMenuID()#" title="Edit menu">#menu.getTitle()#</a>
                    <cfelse>
                        #menu.getTitle()#
                    </cfif>
                </td>
                <td>#menu.getSlug()#</td>
                <td class="center">
                    <div class="btn-group">
                        <cfif prc.oAuthor.checkPermission("MENUS_ADMIN")>
                        <!--- Edit Command --->
                        <li><a href="#event.buildLink(prc.xehMenuEditor)#/menuID/#menu.getMenuID()#"><i class="icon-edit icon-large"></i> Edit</a></li>
                        <!--- Delete Command --->
                        <a class="btn" title="Delete Menu" href="javascript:remove('#menu.getmenuID()#', 'menuID')" class="confirmIt" data-title="Delete Menu?"><i class="icon-trash icon-large" id="delete_#menu.getMenuID()#"></i></a>
                        </cfif>
                    </div>
                </td>
            </tr>
            </cfloop>
        </tbody>
    </table>
    <!--- Paging --->
    <cfif !rc.showAll>
        #prc.pagingPlugin.renderit(foundRows=prc.menuCount, link=prc.pagingLink, asList=true)#
        <cfelse>
        <span class="label label-info">Total Records: #prc.menuCount#</span>
    </cfif>
</cfoutput>