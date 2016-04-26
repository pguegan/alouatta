(function (window, document, angular, undefined) {
    angular.module('alouatta.controls')
        .controller('controlsController', controlsController);

    controlsController.$inject = ['$log'];

    function controlsController(log) {
        // Fields
        var vm = this;

        // Public methods
        vm.$onInit = init;
        vm.play = play;
        vm.pause = pause;
        vm.togglePlay = togglePlay;
        vm.toggleMute = toggleMute;
        vm.setVolume = setVolume;
        vm.setCurrentTime = setCurrentTime;
        
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
            vm.playerCtrl.setCurrentTime(vm.player.desiredTime);
        }

        /*
            Internal methods
        */

        // Inits controller
        function init() {
            vm.player = vm.playerCtrl.player;
        }
    }
})(window, document, angular);
