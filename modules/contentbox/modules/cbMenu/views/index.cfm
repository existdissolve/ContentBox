<cfoutput>
<div class="row-fluid" id="main-content">
    <div class="box">
        <!--- Body Header --->
        <div class="header">
            <i class="icon-tags icon-large"></i>
            Menus
        </div>
        <!--- Body --->
        <div class="body">
            <!--- MessageBox --->
            #getPlugin( "MessageBox" ).renderit()#
            <!---Import Log --->
            <cfif flash.exists( "importLog" )>
                <div class="consoleLog">#flash.get( "importLog" )#</div>
            </cfif>
            <!--- MenuForm --->
            #html.startForm(name="menuForm", action=prc.xehMenuRemove, class="form-vertical" )#
            <input type="hidden" name="menuID" id="menuID" value="" />
            
            <!--- Content Bar --->
            <div class="well well-small">
                <!--- Command Bar --->
                <div class="pull-right">
                    <!---Global --->
                    <cfif prc.oAuthor.checkPermission( "MENUS_ADMIN,TOOLS_IMPORT,TOOLS_EXPORT" )>
                    <div class="btn-group">
                        <a class="btn dropdown-toggle" data-toggle="dropdown" href="##">
                            Global Actions <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <cfif prc.oAuthor.checkPermission( "MENUS_ADMIN" )>
                            <li><a href="javascript:bulkRemove()" class="confirmIt"
                                    data-title="Delete Selected Menus?" data-message="This will delete the menus and associations, are you sure?"><i class="icon-trash"></i> Delete Selected</a></li>
                            </cfif>
                            <cfif prc.oAuthor.checkPermission( "MENUS_ADMIN,TOOLS_IMPORT" )>
                            <li><a href="javascript:importContent()"><i class="icon-upload-alt"></i> Import</a></li>
                            </cfif>
                            <cfif prc.oAuthor.checkPermission( "MENUS_ADMIN,TOOLS_EXPORT" )>
                            <li class="dropdown-submenu">
                                <a href="##"><i class="icon-download icon-large"></i> Export All</a>
                                <ul class="dropdown-menu text-left">
                                    <li><a href="#prc.xehExportAll#.json" target="_blank"><i class="icon-code"></i> as JSON</a></li>
                                    <li><a href="#prc.xehExportAll#.xml" target="_blank"><i class="icon-sitemap"></i> as XML</a></li>
                                </ul>
                            </li>
                            </cfif>
                        </ul>
                    </div>
                    </cfif>
                    <cfif prc.oAuthor.checkPermission( "MENUS_ADMIN" )>
                        <button class="btn btn-danger" onclick="return to('#prc.xehMenuEditor#')">Create Menu</button>
                    </cfif>
                </div>
                <!--- Filter Bar --->
                <div class="filterBar">
                    <div>
                        #html.textField( name="menuFilter",size="30", class="textfield", label="Quick Filter: ", labelClass="inline" )#
                    </div>
                </div>
            </div>
            <cfif arrayLen( prc.menus )>
                <!--- menus --->
                <table name="menus" id="menus" class="tablesorter table table-striped table-hover" width="98%">
                    <thead>
                        <tr>
                            <th id="checkboxHolder" class="{sorter:false}" width="20"><input type="checkbox" onClick="checkAll( this.checked,'menuID' )"/></th>
                            <th>Menu Name</th>
                            <th>Slug</th> 
                            <th width="100" class="center {sorter:false}">Actions</th>
                        </tr>
                    </thead>                
                    <tbody>
                        <cfloop array="#prc.menus#" index="menu">
                        <tr id="menuID-#menu.getMenuID()#" data-menuID="#menu.getMenuID()#">
                            <!--- check box --->
                            <td>
                                <input type="checkbox" name="menuID" id="menuID" value="#menu.getMenuID()#" />
                            </td>
                            <td><a href="javascript:edit('#menu.getMenuID()#',
                                                         '#HTMLEditFormat( JSStringFormat( menu.getTitle() ) )#',
                                                         '#HTMLEditFormat( JSStringFormat( menu.getSlug() ) )#')" title="Edit #menu.getMenu()#">#menu.getMenu()#</a></td>
                            <td>#menu.getSlug()#</td>
                            <td class="center">
                                <div class="btn-group">
                                    <cfif prc.oAuthor.checkPermission("MENUS_ADMIN")>
                                    <!--- Edit Command --->
                                    <a class="btn" href="javascript:edit('#menu.getMenuID()#',
                                                             '#HTMLEditFormat( JSStringFormat( menu.getTitle() ) )#',
                                                             '#HTMLEditFormat( JSStringFormat( menu.getSlug() ) )#')" title="Edit #menu.getMenu()#"><i class="icon-edit icon-large"></i></a>
                                    <!--- Delete Command --->
                                    <a class="btn" title="Delete Menu" href="javascript:remove('#menu.getmenuID()#')" class="confirmIt" data-title="Delete Menu?"><i class="icon-trash icon-large" id="delete_#menu.getMenuID()#"></i></a>
                                    </cfif>
                                </div>
                            </td>
                        </tr>
                        </cfloop>
                    </tbody>
                </table>
            <cfelse>
                <div class="alert alert-block">
                    <h4>Sorry!</h4>
                    Looks like you haven't created any menus yet. Why not start one now?
                </div>
            </cfif>
            #html.endForm()#
        </div>  
    </div>
</div>
<cfif prc.oAuthor.checkPermission( "MENUS_ADMIN,TOOLS_IMPORT" )>
<!---Import Dialog --->
<div id="importDialog" class="modal hide fade">
    <div id="modalContent">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3><i class="icon-copy"></i> Import Menus</h3>
        </div>
        #html.startForm(name="importForm", action=prc.xehMenuImport, class="form-vertical", multipart=true)#
        <div class="modal-body">
            <p>Choose the ContentBox <strong>JSON</strong> menus file to import.</p>
            
            #getMyPlugin( plugin="BootstrapFileUpload", module="contentbox" ).renderIt( 
                name="importFile", 
                required=true
            )#
            
            <label for="overrideContent">Override Menus?</label>
            <small>By default all content that exist is not overwritten.</small><br>
            #html.select(options="true,false", name="overrideContent", selectedValue="false", class="input-block-level",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group")#
            
            <!---Notice --->
            <div class="alert alert-info">
                <i class="icon-info-sign icon-large"></i> Please note that import is an expensive process, so please be patient when importing.
            </div>
        </div>
        <div class="modal-footer">
            <!--- Button Bar --->
            <div id="importButtonBar">
                <button class="btn" id="closeButton"> Cancel </button>
                <button class="btn btn-danger" id="importButton"> Import </button>
            </div>
            <!--- Loader --->
            <div class="center loaders" id="importBarLoader">
                <i class="icon-spinner icon-spin icon-large icon-2x"></i>
                <br>Please wait, doing some hardcore importing action...
            </div>
        </div>
        #html.endForm()#
    </div>
</div>
</cfif>
</cfoutput>