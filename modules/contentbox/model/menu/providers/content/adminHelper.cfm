<cfoutput>
    <script>
        var input = null;
        var hidden = null;
        var label = null;
        $( document ).ready(function() {
            $( '.select-content' ).on( 'click', function() {
                input = $( this ).siblings( 'input[name=content]' );
                hidden= $( this ).siblings( 'input[name=contentID]' );
                label = $( this ).closest( '.dd3-extracontent' ).find( 'input[name=label]' );
                var baseURL = '#event.buildLink( args.xehContentSelector )#';
                openRemoteModal( baseURL, {contentType:'Page,Entry'}, 900, 600 );
            });
        });
        function chooseRelatedContent( id, title, type ) {
            closeRemoteModal();
            input.val( title );
            hidden.val( id );
            label.val( title );
            updateLabel( label );
            return false;
        }
    </script>
</cfoutput>