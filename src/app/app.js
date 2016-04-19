(function(window, document, angular, undefined) {
    angular.module('alouatta.player', [])
        .constant('CONFIG', {
            player: {
                streamUrl: "http://stream.myjungly.fr/RIFFX",
            }
        })
        .config(moduleConfig);
    
    moduleConfig.$inject = ['$sceDelegateProvider'];
    
    function moduleConfig($sce) {
        $sce.resourceUrlWhitelist([
            'self',
            'http://*.myjungly.fr/**',
        ]);
    }
})(window, document, angular);
