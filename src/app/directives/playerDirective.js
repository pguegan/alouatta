(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .directive('alouattaPlayer', playerDirective);
    
    var playerParameters = {
        'autoplay': '=',
        'controls': '=',
    };
    
    function initPlayerDirective(scope, element, attrs, controller, transclude) {
        var audio = element.find('audio');
        if (audio && audio.length) {
            scope.vm.player = audio[0];
        }
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
