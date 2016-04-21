(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .directive('alouattaPlaylist', playlistDirective);
    
    // Component bindable parameters
    var playlistParameters = {
        'autoplay': '=',
        'volume': '=',
    };
    
    // Gets playlist directive's template url
    function getPlaylistTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/playlist-'+attrs.type+'.html';
        } else {
            return 'templates/playlist-default.html';
        }
    }
    // Inits playlist 
    function initPlaylistDirective(scope, element, attrs, controller, transclude) {
    }
    
    function playlistDirective() {
        return {
            restrict: 'AE',
			bindToController: true,
			controllerAs: 'vm',
            templateUrl: getPlaylistTemplateUrl,
            controller: 'playlistController',
            scope: playlistParameters,
            link: initPlaylistDirective,
        };
    }
})(window, document, angular);
