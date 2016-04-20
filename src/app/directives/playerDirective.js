(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .directive('alouattaPlayer', playerDirective);
    
    var playerParameters = {
        'autoplay': '=',
        'volume': '=',
    };
    
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
    
    function initPlayerDirective(scope, element, attrs, controller, transclude) {
        var audio = new Audio();
        
        if(attrs.autoplay) {
            audio.autoplay = true;
        }
        if(attrs.volume) {
            audio.volume = Number(attrs.volume);
        }
        
        for(var i=0; i<playerEvents.length; i++) {
           audio.addEventListener(playerEvents[i], function(event) {
               controller.onPlayerEvent(event);
               scope.$apply();
           }) 
        }
        
        controller.init(audio);
    }
    
    function getPlayerTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/player-'+attrs.type+'.html';
        } else {
            return 'templates/player-default.html';
        }
    }
    
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
