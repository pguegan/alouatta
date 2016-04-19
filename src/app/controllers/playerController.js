(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .controller('playerController', playerController);
    
    playerController.$inject = ['CONFIG'];
    
    function playerController(CONFIG) {
        var vm = this;
        vm.source = CONFIG.player.streamUrl;
        vm.play = play;
        vm.pause = pause;
        vm.togglePlay = togglePlay;
        
        // Starts player
        function play() {
            vm.player.play();
        }
        
        // Pauses player
        function pause() {
            vm.player.pause();
        }
        
        // Toggles player 
        function togglePlay() {
            if(vm.player.paused) {
                vm.play();
            } else {
                vm.pause();
            }
        }
    }
})(window, document, angular);
