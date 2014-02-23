<cfoutput>
    <script>
        $( document ).ready(function() {
            $( '.add-related-content' ).on( 'click', function() {
                var baseURL = '#event.buildLink( args.xehContentSelector )#';
                openRemoteModal( baseURL, {contentType:'Page,Entry'}, 900, 600 );
            });
        });
        function chooseRelatedContent( id, title, type ) {
            closeRemoteModal();
            return false;
        }
    </script>
</cfoutput>