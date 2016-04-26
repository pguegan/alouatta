(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .controller('playlistController', playerController);
    
    playerController.$inject = ['$log', 'playlistService'];
    
    function playerController(log, playlistService) {
        var vm = this;
        
        // Public methods
        vm.$onInit = init;
        vm.setTrack = setTrack;
        vm.nextPage = nextPage;
        vm.previousPage = previousPage;        
        
        // Fields        
        var paging = {
            offset: 0,
            count: 10,
        };
        
        /*
            Public methods
        */
        
        // Sets current track
        function setTrack(track) {
            vm.playerCtrl.setTrack(track);
            vm.currentTrack = track;
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
            playlistService.getTracks(paging.offset, paging.count)
                .then(function(result) {
                    vm.tracks = result;
                });
        }
    }
})(window, document, angular);
