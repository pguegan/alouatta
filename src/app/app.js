(function(window, document, angular, undefined) {
    angular.module('alouatta', [
            'alouatta.player',
            'alouatta.playlist',
        ])
        .config(moduleConfig);
    
    moduleConfig.$inject = ['$sceDelegateProvider'];
    
    function moduleConfig($sce) {
        $sce.resourceUrlWhitelist([
            'self',
            'http://stream.myjungly.fr/**',
            'http://www.cpordevises.com/uploads/**',
        ]);
    }
})(window, document, angular);
