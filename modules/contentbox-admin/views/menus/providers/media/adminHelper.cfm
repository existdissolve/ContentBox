<cfoutput>
    <script>
        var input = null;
        var hidden = null;
        var label = null;
        $( document ).ready(function() {
            $( '.select-media' ).on( 'click', function() {
                input = $( this ).siblings( 'input[name^=media]' );
                hidden= $( this ).siblings( 'input[name^=mediaPath]' );
                label = $( this ).closest( '.dd3-extracontent' ).find( 'input[name^=label]' );

                var baseURL = '#args.xehMediaSelector#';
                window.open( baseURL, 'fbSelector', 'height=600,width=600' )
            });
        });
        function fbMenuItemSelect( sPath, sURL, sType ) {
            var fileParts = sPath.split( '/' ),
                fileName = fileParts[ fileParts.length-1 ];
            input.val( fileName );
            hidden.val( sPath );
            label.val( fileName );
            updateLabel( label );
            return false;
        }
    </script>
</cfoutput>