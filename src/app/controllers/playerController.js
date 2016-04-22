(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .controller('playerController', playerController);
    
    playerController.$inject = ['$rootScope'];
    
    function playerController($rootScope) {
        var vm = this;
        
        // Properties
        vm.isLoading = false;
        vm.isPlaying = false;
        
        // Public methods
        vm.setPlayer = setPlayer;
        vm.play = play;
        vm.pause = pause;
        vm.togglePlay = togglePlay;
        vm.toggleMute = toggleMute;
        vm.onPlayerEvent = onPlayerEvent;
        
        init();
        
        /*
            Public methods
        */
        
        function onPlayerEvent(event) {
            vm.isError = false;
            if(event.type === "loadstart") {
                vm.isLoading = true;
            } else if(event.type === "canplay") {
                vm.isLoading = false;
            } else if(event.type === "pause") {
                vm.isPlaying = false;
            } else if(event.type === "playing") {
                vm.isPlaying = true;
            }else if(event.type === "error") {
                vm.isError = true;
            }
        }
        
        // Links audio player
        function setPlayer(player) {
            vm.player = player;
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
        
        /*
            Internal methods
        */
        
        // Inits controller
        function init() {            
            $rootScope.$on('setTrack', setCurrentTrack);
        }
        
        // Sets current track on message event
        function setCurrentTrack(event, track) {
            vm.player.src = track.url;
        }
    }
})(window, document, angular);
