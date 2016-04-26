(function(window, document, angular, undefined) {    
    angular.module('alouatta.player')
        .component('alouattaTrackDetail', {
            bindings: {
                'type': '@',
                'track': '<',
            },
            controllerAs: 'vm',
            transclude: false,
            templateUrl: getTrackDetailTemplateUrl,
        });
    
    // Gets track detail directive's template url
    function getTrackDetailTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/track-detail-' + attrs.type + '.html';
        } else {
            return 'templates/track-detail-default.html';
        }
    }
    
    getTrackDetailTemplateUrl.$inject = ['$element', '$attrs'];
})(window, document, angular);
