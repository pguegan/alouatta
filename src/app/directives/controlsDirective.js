(function(window, document, angular, undefined) {
    angular.module('alouatta.controls')
        .component('alouattaControls', {
            require: {
                playerCtrl: '^alouattaPlayer', 
            },
            bindings: {
                'type': '@',
            },
            controller: 'controlsController',
			controllerAs: 'vm',
            transclude: false,
            templateUrl: getControlsTemplateUrl,
        });
    
    // Gets controls directive's template url
    function getControlsTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/controls-' + attrs.type + '.html';
        } else {
            return 'templates/controls-default.html';
        }
    }
    
    getControlsTemplateUrl.$inject = ['$element', '$attrs'];
})(window, document, angular);
