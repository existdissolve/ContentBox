﻿<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Saerch Box --->
	<div class="small_box">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/search.png" alt="info" width="24" height="24" />Search
		</div>
		<div class="body<cfif len(rc.searchPages)> selected</cfif>">
			<!--- Search Form --->
			#html.startForm(name="authorSearchForm",action=prc.xehPageSearch)#
				#html.textField(label="Search:",name="searchPages",class="textfield",size="16",title="Search all pages",value=event.getValue("searchPages",""))#
				<input type="submit" value="Search" class="buttonred" />
				<button class="button" onclick="return to('#event.buildLink(prc.xehPages)#')">Clear</button>
			#html.endForm()#
		</div>
	</div>

	<!--- Filter Box --->
	<div class="small_box">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/filter.png" alt="info" width="24" height="24" />Filters
		</div>
		<div class="body<cfif prc.isFiltering> selected</cfif>">
			#html.startForm(name="pageFilterForm",action=prc.xehPageSearch)#
			<!--- Authors --->
			<label for="fAuthors">Authors: </label>
			<select name="fAuthors" id="fAuthors" style="width:200px">
				<option value="all" <cfif rc.fAuthors eq "all">selected="selected"</cfif>>All Authors</option>
				<cfloop array="#prc.authors#" index="author">
				<option value="#author.getAuthorID()#" <cfif rc.fAuthors eq author.getAuthorID()>selected="selected"</cfif>>#author.getName()#</option>
				</cfloop>
			</select>
			<!--- Categories --->
			<label for="fCategories">Categories: </label>
			<select name="fCategories" id="fCategories" style="width:200px">
				<option value="all" <cfif rc.fCategories eq "all">selected="selected"</cfif>>All Categories</option>
				<option value="none" <cfif rc.fCategories eq "none">selected="selected"</cfif>>Uncategorized</option>
				<cfloop array="#prc.categories#" index="category">
				<option value="#category.getCategoryID()#" <cfif rc.fCategories eq category.getCategoryID()>selected="selected"</cfif>>#category.getCategory()#</option>
				</cfloop>
			</select>
			<!--- Status --->
			<label for="fStatus">Page Status: </label>
			<select name="fStatus" id="fStatus" style="width:200px">
				<option value="any"   <cfif rc.fStatus eq "any">selected="selected"</cfif>>Any Status</option>
				<option value="true"  <cfif rc.fStatus eq "true">selected="selected"</cfif>>Published</option>
				<option value="false" <cfif rc.fStatus eq "false">selected="selected"</cfif>>Draft</option>
			</select>

			<div class="actionBar">
				<input type="submit" value="Apply Filters" class="buttonred" />
				<button class="button" onclick="return to('#event.buildLink(prc.xehPages)#')">Reset</button>
			</div>
			#html.endForm()#
		</div>
	</div>

	<!--- Help Box--->
	<div class="small_box" id="help_tips">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/help.png" alt="info" width="24" height="24" />Help Tips
		</div>
		<div class="body">
			<ul class="tipList">
				<li title="Click Me!" onclick="exposeIt('##pages')">Right click on a row to activate quick look!</li>
				<li title="Click Me!" onclick="exposeIt('##main_column')">Sorting is only done within your paging window</li>
				<li title="Click Me!" onclick="exposeIt('##contentBar')">Quick Filtering is only for viewed results</li>
				<li>Cloning does not copy comments or version history</li>
				<li>You can quickly order the pages by dragging the rows</li>
			</ul>
		</div>
	</div>
</div>
<!--End sidebar-->
<!--============================Main Column============================-->
<div class="main_column" id="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			<img src="#prc.cbroot#/includes/images/page_big.png" alt="sofa" width="30" height="30" />
			Pages (#prc.pagesCount#)
			<cfif len(rc.searchPages)> > Search: #rc.searchPages#</cfif>
			<cfif prc.isFiltering> > Filtered View</cfif>
		</div>
		<!--- Body --->
		<div class="body">

			<!--- MessageBox --->
			#getPlugin("MessageBox").renderit()#

			<!--- pageForm --->
			#html.startForm(name="pageForm",action=prc.xehPageRemove)#
			#html.hiddenField(name="contentStatus",value="")#
			#html.hiddenField(name="contentID",value="")#
			#html.hiddenField(name="parent",value=event.getValue("parent",""))#

			<!--- Info Bar --->
			<cfif NOT prc.cbSettings.cb_comments_enabled>
				<div class="infoBar">
					<img src="#prc.cbRoot#/includes/images/info.png" alt="comments" />
					Comments are currently disabled site-wide!
				</div>
			</cfif>

			<!--- Content Bar --->
			<div class="contentBar" id="contentBar">

				<!--- Create Butons --->
				<cfif prc.oAuthor.checkPermission("PAGES_ADMIN") or prc.oAuthor.checkPermission("PAGES_EDITOR")>
				<div class="buttonBar">
					<button class="button2" onclick="return bulkChangeStatus('publish')" title="Bulk Publish Content">Publish</button>
					<button class="button2" onclick="return bulkChangeStatus('draft')" title="Bulk Draft Content">Draft</button>
					<button class="buttonred" onclick="return to('#event.buildLink(linkTo=prc.xehPageEditor)#/parentID/#event.getValue('parent','')#');">Create Page</button>
				</div>
				</cfif>

				<!--- Filter Bar --->
				<div class="filterBar">
					<div>
						#html.label(field="pageFilter",content="Quick Filter:",class="inline")#
						#html.textField(name="pageFilter",size="30",class="textfield")#
					</div>
				</div>
			</div>

			<!--- Paging --->
			#prc.pagingPlugin.renderit(prc.pagesCount,prc.pagingLink)#

			<!--- Location Bar --->
			<cfif structKeyExists(rc, "parent") AND len( rc.parent )>
			<div class="infoBar">
			  <a href="#event.buildLink(prc.xehPages)#">
			  	<img src="#prc.cbRoot#/includes/images/home.png" alt="root" title="Home"/>
			  </a> #getMyPlugin(plugin="PageBreadcrumbVisitor",module="contentbox-admin").visit(prc.page, event.buildLink(prc.xehPages))#
			</div>
			</cfif>

			<!--- pages --->
			<table name="pages" id="pages" class="tablesorter" width="98%">
				<thead>
					<tr>
						<th id="checkboxHolder" class="{sorter:false}" width="20"><input type="checkbox" onClick="checkAll(this.checked,'contentID')"/></th>
						<th>Name</th>
						<th width="150">Categories</th>
						<th width="40" class="center"><img src="#prc.cbRoot#/includes/images/sort.png" alt="menu" title="Show in Menu"/></th>
						<th width="40" class="center"><img src="#prc.cbRoot#/includes/images/publish.png" alt="publish" title="Published"/></th>
						<th width="40" class="center"><img src="#prc.cbRoot#/includes/images/glasses.png" alt="hits" title="Hits"/></th>
						<th width="100" class="center {sorter:false}">Actions</th>
					</tr>
				</thead>

				<tbody>
					<cfloop array="#prc.pages#" index="page">
					<tr id="contentID-#page.getContentID()#" data-contentID="#page.getContentID()#"
						<cfif page.isExpired()>
							class="expired"
						<cfelseif page.isPublishedInFuture()>
							class="futurePublished"
						<cfelseif !page.isContentPublished()>
							class="selected"
						</cfif>>
						<!--- check box --->
						<td>
							<input type="checkbox" name="contentID" id="contentID" value="#page.getContentID()#" />
						</td>
						<td>
							<!--- Children Dig Deeper --->
							<cfif page.getNumberOfChildren()>
								<a href="#event.buildLink(prc.xehPages)#/parent/#page.getContentID()#" class="hand-cursor" title="View Child Pages (#page.getNumberOfChildren()#)"><img src="#prc.cbRoot#/includes/images/plus.png" alt="child" border="0"/></a>
							<cfelse>
								<img src="#prc.cbRoot#/includes/images/page.png" alt="page"/>
							</cfif>
							<!--- Title --->
							<cfif prc.oAuthor.checkPermission("PAGES_EDITOR") OR prc.oAuthor.checkPermission("PAGES_ADMIN")>
								<a href="#event.buildLink(prc.xehPageEditor)#/contentID/#page.getContentID()#" title="Edit #page.getTitle()#">#page.getTitle()#</a>
							<cfelse>
								#page.getTitle()#
							</cfif>
							<cfif page.getNumberOfChildren()>
							(#page.getNumberOfChildren()#)
							</cfif>
						</td>
						<td>#page.getCategoriesList()#</td>
						<td class="center">
							<cfif page.getShowInMenu()>
								<img src="#prc.cbRoot#/includes/images/button_ok.png" alt="published" title="Shows in menu!" />
							<cfelse>
								<img src="#prc.cbRoot#/includes/images/button_cancel.png" alt="draft" title="Not in menu!" />
							</cfif>
						</td>
						<td class="center">
							<cfif page.isExpired()>
								<img src="#prc.cbRoot#/includes/images/button_cancel.png" alt="expired" title="Page has expired on ( (#page.getDisplayExpireDate()#))" />
								<span class="hidden">expired</span>
							<cfelseif page.isPublishedInFuture()>
								<img src="#prc.cbRoot#/includes/images/information.png" alt="published" title="Page Publishes in the future (#page.getDisplayPublishedDate()#)" />
								<span class="hidden">published in future</span>
							<cfelseif page.isContentPublished()>
								<img src="#prc.cbRoot#/includes/images/button_ok.png" alt="published" title="Page Published!" />
								<span class="hidden">published in future</span>
							<cfelse>
								<img src="#prc.cbRoot#/includes/images/button_cancel.png" alt="draft" title="Page Draft!" />
								<span class="hidden">draft</span>
							</cfif>
						</td>
						<td class="center">#page.getHits()#</td>
						<td class="center">
							<!---Info Panel --->
							<button class="button" onclick="return toggleInfoPanel('#page.getContentID()#')" title="Page Info" ><img src="#prc.cbroot#/includes/images/gravatar.png" /></button>
							<!---Info Panel --->
							<div id="infoPanel_#page.getContentID()#" class="contentInfoPanel">
								<img src="#prc.cbRoot#/includes/images/calendar_small.png" alt="calendar"/>  
								Last edit by <a href="mailto:#page.getAuthorEmail()#">#page.getAuthorName()#</a> on 
								#page.getActiveContent().getDisplayCreatedDate()#
								</br>
								<!--- password protect --->
								<cfif page.isPasswordProtected()>
									<img src="#prc.cbRoot#/includes/images/lock.png" alt="locked"/> Password Protected
								<cfelse>
									<img src="#prc.cbRoot#/includes/images/lock_off.png" alt="locked"/> Public Page
								</cfif>
								<br/>
								<!--- comments icon --->
								<cfif page.getallowComments()>
									<img src="#prc.cbRoot#/includes/images/comments.png" alt="locked"/> Open Comments
								<cfelse>
									<img src="#prc.cbRoot#/includes/images/comments_off.png" alt="locked"/> Closed Comments
								</cfif>
								<!---Layouts --->
								<br/>
								<img src="#prc.cbRoot#/includes/images/layouts_small.png" alt="page layout"/> Layout: <strong>#page.getLayout()#</strong>
								<br/>
								<img src="#prc.cbRoot#/includes/images/iPad.png" alt="mobile layout"/> Mobile Layout: <strong>#page.getMobileLayout()#</strong>
							</div>
							
							<!---Page Actions --->
							<button class="button" onclick="return toggleActionsPanel('#page.getContentID()#')" title="Page Actions" ><img src="#prc.cbroot#/includes/images/settings_black.png" /></button>
							<!---Page Actions Panel --->
							<div id="pageActions_#page.getContentID()#" class="actionsPanel">
								<cfif prc.oAuthor.checkPermission("PAGES_EDITOR") OR prc.oAuthor.checkPermission("PAGES_ADMIN")>
								<!--- Clone Command --->
								<a href="javascript:openCloneDialog('#page.getContentID()#','#URLEncodedFormat(page.getTitle())#')"><img src="#prc.cbroot#/includes/images/clone.png" alt="edit" border="0"/> Clone Page</a>
								<br/>
								<!--- Create Child --->
								<a href="#event.buildLink(prc.xehPageEditor)#/parentID/#page.getContentID()#"><img src="#prc.cbroot#/includes/images/parent.png" alt="edit" border="0"/> Create Child</a>
								<br/>
								</cfif>
								<!--- History Command --->
								<a href="#event.buildLink(prc.xehPageHistory)#/contentID/#page.getContentID()#"><img src="#prc.cbroot#/includes/images/old-versions.png" alt="versions" border="0"/> Page History</a>
								<br/>
								<cfif prc.oAuthor.checkPermission("PAGES_ADMIN")>
								<!--- Delete Command --->
								<a href="javascript:remove('#page.getContentID()#')" class="confirmIt"
								  data-title="Delete Page?" data-message="This will delete the page and all of its sub-pages, are you sure?"><img id="delete_#page.getContentID()#" src="#prc.cbroot#/includes/images/delete.png" border="0" alt="delete"/> Delete Page</a>
								<br/>
								</cfif>
								<!--- View in Site --->
								<a href="#prc.CBHelper.linkPage(page)#" target="_blank"><img src="#prc.cbroot#/includes/images/eye.png" alt="edit" border="0"/> View Page</a>
							</div>
							</td>
					</tr>
					</cfloop>
				</tbody>
			</table>

			<!--- Paging --->
			#prc.pagingPlugin.renderit(prc.pagesCount,prc.pagingLink)#

			#html.endForm()#
		</div>
	</div>
</div>
<cfif prc.oAuthor.checkPermission("PAGES_EDITOR") OR prc.oAuthor.checkPermission("PAGES_ADMIN")>
<div id="cloneDialog" class="modal">
	<div id="modalContent">
		<h2>Page Cloning</h2>
		<p>By default, all internal page links are updated for you as part of the cloning process.</p>
		#html.startForm(name="cloneForm", action=prc.xehPageClone)#
			#html.hiddenField(name="contentID")#
			#html.textfield(name="title", label="Please enter the new page title:", class="textfield", required="required", size="50")#
			<label for="pageStatus">Publish all pages in hierarchy?</label>
			<small>By default all cloned pages are published as drafts.</small><br>
			#html.select(options="true,false", name="pageStatus", selectedValue="false")#
			
			<div class="infoBar">Please note that cloning is an expensive process, so please be patient when cloning big hierarchical content trees.</div>
			<hr/>
			<!--- Button Bar --->
			<div id="bottomCenteredBar" class="textRight">
				<button class="button2" id="cloneButton"> Clone </button>
				<button class="buttonred" id="closeButton"> Cancel </button>
			</div>
			<!--- Loader --->
			<div class="center loaders" id="clonerBarLoader">
				<img src="#prc.cbRoot#/includes/images/ajax-loader-blue.gif" alt="loader"/>
				<br>Please wait, doing some hardcore cloning action...
			</div>
		#html.endForm()#
	</div>
</div>
</cfif>
</cfoutput>