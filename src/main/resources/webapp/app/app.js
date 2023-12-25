(function (angular) {

    let app = angular.module("myApp", ['ngResource', 'ngAnimate', 'ngStorage', 'ngCookies', 'pascalprecht.translate', 'ngMessages']);

    app.config(function ($locationProvider, $translateProvider) {
        $locationProvider.html5Mode({
            enabled: true,
            requireBase: false
        });
        $translateProvider
            .useStaticFilesLoader({
                prefix: 'locale/locale-',
                suffix: '.json'
            })
            .determinePreferredLanguage()
            .useLocalStorage()
            .useSanitizeValueStrategy('escape')
            .useLoaderCache(true);
    }).run(function ($localStorage, $http, $location, $rootScope, $window, $cookies) {
        if ($localStorage.user) {
            $http.defaults.headers.common.Authorization = 'Bearer ' + $localStorage.token;
        }
        $rootScope.$on('$locationChangeStart', function () {
            if ($location.path() === "/" && $cookies.get("token")) {
                $window.location.href = '/main.jsp';
            }
        });
    });
}(angular));


