(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .directive('alouattaPlayer', playerDirective);
    
    var playerScope = {
        'autoplay': '=',
        'controls': '=',
    };
    
    function playerDirective() {
        return {
            restrict: 'AE',
            transclude: false,
			bindToController: true,
			controllerAs: 'vm',
            template: '<audio ng-src="{{ vm.source }}" ng-attr-autoplay="{{ vm.autoplay }}" ng-attr-controls="{{ vm.controls }}"></audio>',
            controller: 'playerController',
            scope: playerScope,
        };
    }
})(window, document, angular);
