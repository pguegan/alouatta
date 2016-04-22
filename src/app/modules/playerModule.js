(function(window, document, angular, undefined) {
    angular.module('alouatta.player', [])
        .constant('CONFIG', {
            player: {
                streamUrl: "http://stream.myjungly.fr/RIFFX",
            }
        })
        .config(playerModuleConfig);
    
    playerModuleConfig.$inject = ['$sceDelegateProvider'];
    
    function playerModuleConfig($sce) {
        $sce.resourceUrlWhitelist([
            'http://stream.myjungly.fr/**',
            'http://www.cpordevises.com/uploads/**',
        ]);
    }
})(window, document, angular);
