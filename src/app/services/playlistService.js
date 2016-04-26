(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .service('playlistService', playlistService);
        
    playlistService.$inject = ['$http', '$q', '$log', 'CONFIG'];
    
    function playlistService($http, $q, $log, CONFIG) {
        // Fields
        var service = this,
            tracks = [],
            isLoading = false,
            loadingPromise,
            currentPage = 1,
            isNextPage;
        
        // Public methods
        service.getTracks = getTracks;
        
        init();
        
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
            
            if(isLoading) {
                loadingPromise.then(deferred.resolve)
            } else if(isNextPage && offset + count > tracks.length) {
                currentPage++;
                loadTracks().then(deferred.resolve);
            } else {
                deferred.resolve(tracks);
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
            isLoading = true;
            var deferred = $q.defer();
            loadingPromise = deferred.promise;
            
            $http({
                url: CONFIG.playlistService.url,
                params: {
                    page: currentPage
                },
                method: 'GET'
            }).then(function(result) {
                isLoading = false;
                isNextTrack = angular.isDefined(result.data.links.next);
                for(var i=0; i<result.data.podcasts.length; i++) {
                    result.data.podcasts[i].mp3 = CONFIG.playlistService.srcPrefix + result.data.podcasts[i].mp3;
                    tracks.push(result.data.podcasts[i]);
                }
                deferred.resolve(tracks);
            });
            
            
            return loadingPromise;
        }
    }
})(window, document, angular);
