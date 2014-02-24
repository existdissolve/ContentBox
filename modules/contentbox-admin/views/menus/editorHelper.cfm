 <cfoutput>
    <!---<cfset addAsset( "#event.getModuleRoot( 'cbMenu' )#/includes/nestable.css" )>
    <cfset addAsset( "#event.getModuleRoot( 'cbMenu' )#/includes/jquery.nestable.js" )>--->
    <script>
        var confirmConfig = {
            placement: 'right',
            title: 'Are you sure you want to remove this menu item and all its descendants?',
            singleton: true,
            href: 'javascript:void(0);',
            onConfirm: function() {
                $( this ).closest( '.dd3-item' ).remove();
            }
        };
        function updateLabel( el ) {
            var me = $( el ),
                titleDiv = me.closest( '.dd3-extracontent' ).prev( '.dd3-content' ),
                value = me.val() != '' ? me.val() : '<i class="emptytext">Please enter a label</i>';
            // toggle 
            $( titleDiv ).html( value );
        }
        function addMenuItem( content, context ) {
            var wrapper = $( '##nestable' ),
                outer = wrapper.children( 'ol' );
            // if a context isn't defined, add to outer element
            if( !context ) {
                $( content ).appendTo( outer ).each(function() {
                    var extra = $( this ).find( '.dd3-extracontent' );
                    extra.toggle( 300 );
                    extra.find( 'input[name=label]' ).focus();
                    $( this ).find( '[data-toggle="confirmation"]' ).confirmation( confirmConfig );
                });
            }
            else {

            }
        }
        function processItem( input ) {
            var li = $( input ).closest( 'li' ),
                fields = $( li ).find( ':input' ),
                errors =  0;
            // run over fields with validation
            for( var i=0; i<fields.length; i++ ) {
                var fld = $( fields[ i ] );
                if( fld.valid() ) {
                    li.data( fld.attr( 'name' ), fld.val() );
                }
                else {
                    errors++;
                }
            }
            li.data( 'isValid', errors ? false : true );
        }
        function saveMenu() {
            var form = $( '##menuForm' ),
                nestable = $( '##nestable' );
            console.log( nestable.nestable( 'serialize' ) )
        }
        $( document ).ready(function() {
            //****** setup listeners ********//
            $( '##submitMenu' ).on( 'click', function() {
                saveMenu();
            });
            $( '[data-toggle="confirmation"]' ).confirmation( confirmConfig );
            $( '##nestable' ).on('click', '.dd3-expand', function() {
                var me = $( this ),
                    prev = me.prev( '.dd3-extracontent' );
                // toggle 
                prev.toggle( 300 );
            });
            $( '##nestable' ).on('keyup change focus blur', 'input[name=label]', function() {
                updateLabel( this );
            });
            $( '##nestable' ).on('keyup change focus blur', 'input', function() {
                processItem( this );
            });

            // provider buttons
            $( '.provider' ).click(function( e ) {
                e.preventDefault();
                var provider = $( this ).data( 'provider' );
                $.ajax({
                    url: '#event.buildLink( linkto=prc.xehMenuItem )#',
                    data: { type: provider },
                    success: function( data, textStatus, jqXHR ){
                        addMenuItem( data );
                    }
                })
            });
            //******** setup nestable menu items **************//
            $( '##nestable' ).nestable();
            
            //************* helper functions ***********//
            
            /**
             * gets a hierarchical json representation of the menus
             */
            function getMenu1() {
                var hierarchy = $('.sortable').nestedSortable( 'toHierarchy' );
                console.log( hierarchy )
                console.log( $.quoteString( $.toJSON( hierarchy ) ) );
            }
            
            /**
             * validates and saves the sortable menu
             */
            function saveMenu1() {
                var hierarchy = $('.sortable').nestedSortable( 'toHierarchy' );
                var errors = '';
                if( $( 'input[name=supermenu_title]' ).val()=='' ) {
                    errors += 'Please enter a title for your menu!<br />';
                }
                if( $( 'input[name=supermenu_slug]' ).val()=='' ) {
                    errors += 'Please enter a slug for your menu!<br />';
                }
                if( !hierarchy.length ) {
                    errors += 'Please add at least one item to your menu!';
                }
                if( errors != '' ) {
                    apprise( errors, {});
                    return false;
                }
                $( 'input[name=supermenu_content]' ).val( $.toJSON( hierarchy ) );
                $( '##supermenu_form' )[0].submit();
            }
            
            /**
             * deletes the menu
             
            function deleteMenu() {
                var form = $( '##supermenu_form' )[0];
                var id = $( '##menuID' ).val();
                form.action = '/menu/' + id;
                apprise( 'Are you sure you want to delete this menu?', {
                    verify:true
                },function(r) {
                    if(r) {
                        form.submit();
                    }
                });
                return false;
            }*/
            
            /**
             * Adds a page or blog entry item to the sortable menu
             * type {String} the type of pages being added
             */
            function addPages( type ) {
                $( '##' + type + '_selector' ).find( 'input[type=checkbox]:checked' ).each(function( index ) {
                    var selector = $( this ).attr('id').split('_')[1];
                    var data = {
                        id: selector,
                        title: $( '##title_' + selector ).val(),
                        url: $( '##url_' + selector ).val(),
                        contentID: $( '##contentID_' + selector ).val(),
                        type: type
                    }
                    addPage( data );
                });
            }
            
            /**
             * Wraps page or blog entry data up into an html structure that will be inserted into the DOM
             * data {Object} the data that will populate the html elements
             */
            function addPage1( data ) {
                var sortable = $( '.sortable' );
                var content = [
                    '<li id=key_' + data.id + '>',
                        '<div class="collapsible_wrapper">',
                            '<div class="collapsible_title">' + data.title + '<div class="content_type">' + data.type + '</div><div class="collapse_arrow"></div></div>',
                            '<div class="collapsible_content">',
                                '<table border="0" cellspacing="0" cellpadding="0">',
                                    '<tr>',
                                        '<td>',
                                            '<label>Label:</label>',
                                        '</td>',
                                        '<td>',
                                            '<input type="text" name="label" value="' + data.title + '" />',
                                        '</td>',
                                        '<td>',
                                            '<label>Title:</label>',
                                        '</td>',
                                        '<td>',
                                            '<input type="text" name="title" value="' + data.title + '" />',
                                            '<input type="hidden" name="url" value="' + data.url + '" />',
                                            '<input type="hidden" name="type" value="' + data.type + '" />',
                                            '<input type="hidden" name="contentID" value="' + data.contentID + '" />', 
                                        '</td>',
                                    '</tr>',
                                    '<tr>',
                                        '<td>',
                                            '<label>Original:</label>',
                                        '</td>',
                                        '<td>',
                                            '<span style="font-size:12px;">' + data.title + '</span>',
                                        '</td>',
                                    '</tr>',
                                '</table>',
                                '<div class="removal">',
                                    '<a href="javascript:void(0);">Remove Menu Item</a>',
                                '</div>',
                            '</div>',
                        '</div>',
                    '</li>' 
                ];
                var finalString = content.join('');
                sortable.append( finalString );  
                $( '##' + data.type + '_selector' ).find( 'input[type=checkbox]:checked' ).each(function( index ) {$
                    $( this ).removeAttr( 'checked' );
                });
            }
            
            /**
             * Wraps link data up into an html structure that will be inserted into the DOM
             * data {Object} the data that will populate the html elements
             */
            // TODO: merge with addPage
            function addLink( data ) {
                var sortable = $( '.sortable' );                        
                var content = [
                    '<li id=key_' + data.id + '>',
                        '<div class="collapsible_wrapper">',
                            '<div class="collapsible_title">' + data.title + '<div class="content_type">' + data.type + '</div><div class="collapse_arrow"></div></div>',
                            '<div class="collapsible_content">',
                                '<table border="0" cellspacing="0" cellpadding="0">',
                                    '<tr>',
                                        '<td>',
                                            '<label>Label:</label>',
                                        '</td>',
                                        '<td>',
                                            '<input type="text" name="label" value="' + data.title + '" />',
                                        '</td>',
                                        '<td>',
                                            '<label>Title:</label>',
                                        '</td>',
                                        '<td>',
                                            '<input type="text" name="title" value="' + data.title + '" />',                                                            
                                            '<input type="hidden" name="type" value="' + data.type + '" />',
                                        '</td>',
                                    '</tr>',
                                    '<tr>',
                                        '<td>',
                                            '<label>URL:</label>',
                                        '</td>',
                                        '<td colspan="3">',
                                            '<input type="text" name="url" value="' + data.url + '" style="width:98%;" />',
                                        '</td>',
                                    '</tr>',
                                '</table>',
                                '<div class="removal">',
                                    '<a href="javascript:void(0);"><img src="#prc.cbRoot#/includes/images/delete.png" alt="Control"/> Remove Menu Item</a>',
                                '</div>',
                            '</div>',
                        '</div>',
                    '</li>' 
                ];
                var finalString = content.join('');
                sortable.append( finalString );  
                $( '##customlink_url' ).val( 'http://' );
                $( '##customlink_title' ).val( '' );
            }
        });
    </script>
</cfoutput>