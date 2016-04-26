(function(window, document, angular, undefined) {
    angular.module('alouatta', [
            'alouatta.player',
            'alouatta.controls',
            'alouatta.playlist',
        ])
        .config(moduleConfig);
    
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
        ]);
        
        // Production settings
        compile.debugInfoEnabled(false);
        log.debugEnabled(false);
    }
})(window, document, angular);
