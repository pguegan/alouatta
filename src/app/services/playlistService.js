(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .service('playlistService', playlistService);
        
    playlistService.$inject = ['$http', '$q', '$log'];
    
    function playlistService($http, $q, $log) {
        // Fields
        var service = this,
            tracks = [],
            initiliazed = false,
            initPromise;
        
        // Public methods
        service.getTracks = getTracks;
        
        initPromise = init();
        
        // Gets tracks
        function getTracks(offset, count) {
            if(!angular.isNumber(offset) || offset < 0) {
                offset = 0;
            }
            if(!angular.isNumber(count) || count < 0) {
                count = 10;
            }
            
            var deferred = $q.defer();
            var resultPromise = (function(offset, count) {
                return deferred.promise.then(function(result) {
                    return tracks.slice(offset, offset + count);
                });
            })(offset, count);
            
            if(initiliazed) {
                deferred.resolve(tracks);
            } else {
                initPromise.then(deferred.resolve);
            }
            
            return resultPromise;
        }
        
        // Inits service
        function init() {
            return $q.all([
                loadTracks(),
            ]);
        }
        
        // Loads track list
        function loadTracks() {
            var deferred = $q.defer();
            
            $http({
                url: 'data/tracks.json',
                method: 'GET'
            }).then(function(result) {
                tracks = result.data;
                initiliazed = true;
                
                deferred.resolve(tracks);
            });
            
            return deferred.promise;
        }
    }
})(window, document, angular);
