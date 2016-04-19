(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .directive('alouattaPlayer', playerDirective);
    
    function playerDirective() {
        return {
            restrict: 'AE',
            transclude: false,
			bindToController: true,
			controllerAs: 'vm',
            template: '<audio ng-src="{{ vm.source }}" controls></audio>',
            controller: 'playerController',
        };
    }
})(window, document, angular);
