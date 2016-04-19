(function(window, document, angular, undefined) {
    angular.module('alouatta.player')
        .controller('playerController', playerController);
    
    playerController.$inject = ['CONFIG'];
    
    function playerController(CONFIG) {
        var vm = this;
        vm.source = CONFIG.player.streamUrl;
    }
})(window, document, angular);