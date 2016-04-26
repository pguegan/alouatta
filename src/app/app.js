(function(window, document, angular, undefined) {
    angular.module('alouatta', [
            'alouatta.player',
            'alouatta.controls',
            'alouatta.playlist',
        ])
        .config(moduleConfig)
        .constant('CONFIG', {
            playlistService: {
                //url: 'data/tracks.json',
                url: 'http://www.cpordevises.com/api/podcasts.json',
                srcPrefix: 'http://www.cpordevises.com/',
            }
        });
    
    moduleConfig.$inject = [
        '$sceDelegateProvider',
        '$compileProvider',
        '$logProvider',
    ];
    
    function moduleConfig(sce, compile, log) {
        sce.resourceUrlWhitelist([
            'self',
            'http://stream.myjungly.fr/**',
            'http://www.cpordevises.com/uploads/**',
            'http://www.cpordevises.com/api/**',
        ]);
        
        // Production settings
        compile.debugInfoEnabled(false);
        log.debugEnabled(false);
    }
})(window, document, angular);
