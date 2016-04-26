(function (window, document, angular, undefined) {
    angular.module('alouatta.controls')
        .controller('controlsController', controlsController);

    controlsController.$inject = ['$log'];

    function controlsController(log) {
        var vm = this;

        // Public methods
        vm.$onInit = init;
        vm.play = play;
        vm.pause = pause;
        vm.togglePlay = togglePlay;
        vm.toggleMute = toggleMute;
        vm.setVolume = setVolume;
        vm.setCurrentTime = setCurrentTime;

        var previousTrack,
            trackQueue = [];

        /*
            Public methods
        */

        // Starts player
        function play() {
            vm.playerCtrl.play();
        }

        // Pauses player
        function pause() {
            vm.playerCtrl.pause();
        }

        // Toggles player 
        function togglePlay() {
            if (vm.player.isPlaying) {
                vm.pause();
            } else {
                vm.play();
            }
        }

        // Toggles mute 
        function toggleMute() {
            vm.playerCtrl.toggleMute();
        }

        // Sets volume
        function setVolume() {
            vm.playerCtrl.setVolume(vm.player.volume);
        }

        // Sets volume
        function setCurrentTime() {
            vm.playerCtrl.setCurrentTime(vm.player.currentTime);
        }

        /*
            Internal methods
        */

        // Inits controller
        function init() {
            vm.player = vm.playerCtrl.player;
        }

        // Sets current track on message event
        function setCurrentTrack(event, track) {
            if (!angular.isDefined(previousTrack)) {
                previousTrack = vm.player.src;
            }

            vm.player.src = track.url;
        }

        // Sets previous track back
        function resumePreviousTrack() {
            if (angular.isDefined(previousTrack)) {
                vm.player.src = previousTrack;
            }
        }
    }
})(window, document, angular);
