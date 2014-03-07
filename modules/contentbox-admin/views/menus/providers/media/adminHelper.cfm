<cfoutput>
    <script>
        var input = null;
        var hidden = null;
        var label = null;
        var win = null;
        $( document ).ready(function() {
            $( '.select-media' ).on( 'click', function() {
                input = $( this ).siblings( 'input[name^=media]' );
                hidden= $( this ).siblings( 'input[name^=mediaPath]' );
                label = $( this ).closest( '.dd3-extracontent' ).find( 'input[name^=label]' );

                var baseURL = '#args.xehMediaSelector#';
                win = window.open( baseURL, 'fbSelector', 'height=600,width=600' )
            });
        });
        /**
         * Custom callback for menu item selection
         * @param {String} sPath
         * @param {String} sURL
         * @param {String} sType
         */
        function fbMenuItemSelect( sPath, sURL, sType ) {
            var fileParts = sPath.split( '/' ),
                fileName = fileParts[ fileParts.length-1 ];
            input.val( fileName );
            hidden.val( sPath );
            label.val( fileName );
            updateLabel( label );
            win.close();
            return false;
        }
    </script>
</cfoutput>