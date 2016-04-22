(function(window, document, angular, undefined) {
    angular.module('alouatta.playlist')
        .service('playlistService', playlistService);
    
    var tracks = [
        {
            title: "Un jour une devise - Leu Moldave",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/404/Devises_du_monde_-_Leu_Moldave.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Lek Albanais",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/403/Devises_du_monde_-_Le_Lek_albanais.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Kuna Croatie",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/402/Devises_du_monde_-_Kuna_Croatie.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Euro Montenegro",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/401/Devises_du_monde_-_Euro_Montenegro.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Euro Kosovo",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/400/Devises_du_monde_-_Euro_Kosovo.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Denar Macedonien",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/399/Devises_du_monde_-_Denar_macedonien.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Tcheque",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/398/Devises_du_monde_-_Couronne_Tcheque.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Suedoise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/397/Devises_du_monde_-_Couronne_suedoise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - couronne Islandaise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/396/Devises_du_monde_-_Couronne_islandaise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Danoise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/395/Devises_du_monde_-_Couronne_danoise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Litas Lituanien",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/394/Devises_du_monde_-_Le_Litas_lituanien.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Mark convertible",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/393/Devises_du_monde_-_Le_Mark_convertible.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Leu Moldave",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/404/Devises_du_monde_-_Leu_Moldave.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Lek Albanais",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/403/Devises_du_monde_-_Le_Lek_albanais.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Kuna Croatie",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/402/Devises_du_monde_-_Kuna_Croatie.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Euro Montenegro",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/401/Devises_du_monde_-_Euro_Montenegro.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Euro Kosovo",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/400/Devises_du_monde_-_Euro_Kosovo.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Denar Macedonien",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/399/Devises_du_monde_-_Denar_macedonien.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Tcheque",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/398/Devises_du_monde_-_Couronne_Tcheque.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Suedoise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/397/Devises_du_monde_-_Couronne_suedoise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - couronne Islandaise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/396/Devises_du_monde_-_Couronne_islandaise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Couronne Danoise",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/395/Devises_du_monde_-_Couronne_danoise.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Litas Lituanien",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/394/Devises_du_monde_-_Le_Litas_lituanien.mp3",
            pubdate: "2016-04-05",
        },
        {
            title: "Un jour une devise - Le Mark convertible",
            url: "http://www.cpordevises.com/uploads/podcast/mp3/393/Devises_du_monde_-_Le_Mark_convertible.mp3",
            pubdate: "2016-04-05",
        },
    ];
    
    playlistService.$inject = ['$rootScope'];
    
    function playlistService($rootScope) {
        var service = this;
        service.getTracks = getTracks;
        service.setCurrentTrack = setCurrentTrack;
        
        function getTracks(offset, count) {
            if(!angular.isNumber() || offset < 0) {
                offset = 0;
            }
            if(!angular.isNumber() || count < 0) {
                count = 10;
            }
            
            return tracks.slice(offset, count + offset);
        }
        
        function setCurrentTrack(track) {
            $rootScope.$emit('setTrack', track);
        }
    }
})(window, document, angular);
