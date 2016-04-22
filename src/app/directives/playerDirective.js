(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .directive('alouattaPlayer', playerDirective);
    
    // Component bindable parameters
    var playerParameters = {
        'autoplay': '=',
        'volume': '=',
    };
    
    // Supported player events
    var playerEvents = [
            "loadstart",
            "durationchange",
            "loadedmetadata",
            "loadeddata",
            //"progress",
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
            //"timeupdate",
            "volumechange",
            "waiting",
        ];
    
    // Called when an event occurs on player
    function playerEventCallback(scope, controller) {
        return function(event) {
            controller.onPlayerEvent(event);
            scope.$apply();
        };
    }
    
    // Inits audio player 
    function initPlayerDirective(scope, element, attrs, controller, transclude) {
        var audio = new Audio();
        
        for(var i=0; i<playerEvents.length; i++) {
           audio.addEventListener(playerEvents[i], playerEventCallback(scope, controller));
        }
        
        if(attrs.autoplay) {
            audio.autoplay = true;
        }
        if(attrs.volume) {
            audio.volume = Number(attrs.volume);
        }
        
        controller.setPlayer(audio);
    }
    
    // Gets player directive's template url
    function getPlayerTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/player-' + attrs.type + '.html';
        } else {
            return 'templates/player-default.html';
        }
    }
    
    // Gets player directive's definition
    function playerDirective() {
        return {
            restrict: 'AE',
			bindToController: true,
			controllerAs: 'vm',
            templateUrl: getPlayerTemplateUrl,
            controller: 'playerController',
            scope: playerParameters,
            link: initPlayerDirective,
        };
    }
})(window, document, angular);
