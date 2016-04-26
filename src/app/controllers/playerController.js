(function (window, document, angular, undefined) {
    angular.module('alouatta.player')
        .controller('playerController', playerController);

    playerController.$inject = ['$scope', '$log'];

    function playerController(scope, log) {
        var vm = this;

        // Properties
        vm.player = {
            isLoading: false,
            isPlaying: false,
            isError: false,
            buffered: [],
        };

        // Public methods
        vm.$onInit = init;
        vm.$onDestroy = cleanup;
        vm.play = play;
        vm.pause = pause;
        vm.toggleMute = toggleMute;
        vm.setVolume = setVolume;
        vm.setCurrentTime = setCurrentTime;
        vm.setTrack = setTrack;

        // Fields
        var audio,
            previousTrack,
            trackQueue = [],
            // Supported player events
            playerEvents = [
                "loadstart",
                "durationchange",
                "loadedmetadata",
                "loadeddata",
                "progress",
                "canplay",
                "canplaythrough",
                "abort",
                "emptied",
                "ended",
                "error",
                "pause",
                "play",
                "playing",
                "ratechange",
                "seeked",
                "seeking",
                "stalled",
                "suspend",
                "timeupdate",
                "volumechange",
                "waiting",
            ];

        /*
            Public methods
        */

        // Starts player
        function play() {
            audio.play();
        }

        // Pauses player
        function pause() {
            audio.pause();
        }

        // Toggles mute 
        function toggleMute() {
            audio.muted = !audio.muted;
        }

        // Sets volume
        function setVolume(volume) {
            audio.volume = volume;
        }

        // Sets current time
        function setCurrentTime(currentTime) {
            audio.currentTime = currentTime;
        }

        // Sets current track
        function setTrack(track) {
            if (!angular.isDefined(previousTrack)) {
                previousTrack = audio;
                previousTrack.pause();
                init();
            }

            audio.src = track.url;
        }

        /*
            Internal methods
        */

        // Inits controller
        function init() {
            audio = new Audio();

            for (var i = 0; i < playerEvents.length; i++) {
                audio.addEventListener(playerEvents[i], onPlayerEvent);
            }

            if (angular.isDefined(vm.autoplay)) {
                audio.autoplay = true;
            }
            if (angular.isDefined(vm.preload)) {
                audio.preload = vm.preload;
            }
            if (angular.isDefined(vm.volume)) {
                audio.volume = Number(vm.volume);
            }
            if (angular.isDefined(vm.src)) {
                audio.src = vm.src;
            }

            vm.player.volume = audio.volume;
            vm.player.muted = audio.muted;
        }

        // Cleanup resources on destroy
        function cleanup() {
            if (audio) {
                audio.pause();
            }
        }

        // Called when an event occurs on player
        function onPlayerEvent(event) {
            // Verbose events
            if (event.type !== "progress" && event.type !== "timeupdate")
                log.debug(event.type);

            vm.player.isError = false;

            if (event.type === "error") {
                vm.player.isError = true;
            } else if (event.type === "canplay" || event.type === "suspend") {
                vm.player.isLoading = false;
            } else if (event.type === "loadstart" || event.type === "waiting") {
                vm.player.isLoading = true;
            } else if (event.type === "ended") {
                vm.player.isPlaying = false;
                resumePreviousTrack();
            } else if (event.type === "pause") {
                vm.player.isPlaying = false;
            } else if (event.type === "playing") {
                vm.player.isPlaying = true;
            } else if (event.type === "progress") {
                for (var i = 0; i < audio.buffered.length; i++) {
                    vm.player.buffered[i] = {
                        start: audio.buffered.start(i),
                        end: audio.buffered.end(i)
                    };
                }
            } else if (event.type === "volumechange") {
                vm.player.volume = audio.volume;
                vm.player.muted = audio.muted;
            } else if (event.type === "timeupdate") {
                vm.player.currentTime = audio.currentTime;
            } else if (event.type === "durationchange") {
                if(audio.duration === Infinity) {
                    vm.player.duration = false;
                } else {
                    vm.player.duration = audio.duration;
                }
            }

            scope.$apply();
        }

        // Sets previous track back
        function resumePreviousTrack() {
            if (angular.isDefined(previousTrack)) {
                if(!audio.paused) {
                    audio.pause();
                }
                
                audio = previousTrack;
                audio.play();
                
                previousTrack = undefined;
            }
        }
    }
})(window, document, angular);
