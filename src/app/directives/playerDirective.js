(function(window, document, angular, undefined) {    
    angular.module('alouatta.player')
        .component('alouattaPlayer', {
            bindings: {
                'autoplay': '@',
                'preload': '@',
                'volume': '@',
                'src': '@',
            },
            controller: 'playerController',
			controllerAs: 'vm',
            transclude: true,
            template: '<ng-transclude></ng-transclude>',
        });
})(window, document, angular);
