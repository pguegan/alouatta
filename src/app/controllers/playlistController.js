(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .controller('playlistController', playerController);
    
    playerController.$inject = ['playlistService'];
    
    function playerController(playlistService) {
        var vm = this;
        
        // Public methods
        vm.setTrack = setTrack;
        vm.nextPage = nextPage;
        vm.previousPage = previousPage;        
        
        // Fields
        
        var paging = {
            offset: 0,
            count: 10,
        };
        
        init();
        
        /*
            Public methods
        */
        
        function setTrack(track) {
            playlistService.setCurrentTrack(track);
        }
        
        function nextPage() {
            if(vm.tracks.length == paging.count) {
                paging.offset += paging.count;
                getTracks();
            }
        }
        
        function previousPage() {
            paging.offset -= paging.count;
            if(paging.offset < 0) {
                paging.offset = 0;
            }
            
            getTracks();
        }
        
        /*
            Internal methods
        */
        
        // Inits controller
        function init() {
            getTracks();
        }
        
        function getTracks() {
            vm.tracks = playlistService.getTracks(paging.offset, paging.count);
        }
    }
})(window, document, angular);
