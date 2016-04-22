(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .service('playlistService', playlistService);
        
    playlistService.$inject = ['$rootScope', '$http', '$q', '$log'];
    
    function playlistService($rootScope, $http, $q, $log) {
        var service = this,
            tracks = [],
            initiliazed = false,
            initPromise;
        service.getTracks = getTracks;
        service.setCurrentTrack = setCurrentTrack;
        service.queueTrack = queueTrack;
        
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
                return deferred.promise.then(function(toto) {
                    return toto.slice(offset, offset + count);
                });
            })(offset, count);
            
            if(initiliazed) {
                deferred.resolve(tracks);
            } else {
                initPromise.then(deferred.resolve);
            }
            
            return resultPromise;
        }
        
        // Propagates track set event
        function setCurrentTrack(track) {
            $rootScope.$emit('setTrack', track);
        }
        
        // Propagates track queue event
        function queueTrack(track) {
            $rootScope.$emit('queueTrack', track);
        }
        
        function init() {
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
