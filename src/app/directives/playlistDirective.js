(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .component('alouattaPlaylist', {
            require: {
                playerCtrl: '^alouattaPlayer', 
            },
            bindings: {
                'type': '@',
            },
            controller: 'playlistController',
			controllerAs: 'vm',
            transclude: false,
            templateUrl: getPlaylistTemplateUrl,
        });
    
    // Gets playlist directive's template url
    function getPlaylistTemplateUrl(element, attrs) {
        if (attrs.type) {
            return 'templates/playlist-'+attrs.type+'.html';
        } else {
            return 'templates/playlist-default.html';
        }
    }
    
    getPlaylistTemplateUrl.$inject = ['$element', '$attrs'];
})(window, document, angular);
