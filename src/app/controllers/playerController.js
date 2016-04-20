(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .controller('playerController', playerController);
    
    playerController.$inject = ['CONFIG'];
    
    function playerController(CONFIG) {
        var vm = this;
        
        // Properties
        vm.isLoading = false;
        vm.isPlaying = false;
        
        // Public methods
        vm.init = init;
        vm.play = play;
        vm.pause = pause;
        vm.togglePlay = togglePlay;
        vm.toggleMute = toggleMute;
        vm.onPlayerEvent = onPlayerEvent;
                
        function onPlayerEvent(event) {
            console.log(event.type);
            
            if(event.type === "loadstart") {
                vm.isLoading = true;
            } else if(event.type === "canplay") {
                vm.isLoading = false;
            } else if(event.type === "pause") {
                vm.isPlaying = false;
            } else if(event.type === "playing") {
                vm.isPlaying = true;
            }
        }
        
        // Inits player
        function init(player) {
            vm.player = player;
            player.src = CONFIG.player.streamUrl;
        }
        
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
        
        // Toggles mute 
        function toggleMute() {
            vm.player.muted = !vm.player.muted;
        }
    }
})(window, document, angular);
