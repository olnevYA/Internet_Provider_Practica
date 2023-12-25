var app = angular.module("myApp");

app.controller("loginCtrl", function ($scope, $http, $localStorage, $location, $window, $cookies, $translate) {
    $scope.userName = $localStorage.user;
    $scope.role = $localStorage.role;
    $scope.loginCheck = false;
    $scope.loginSpin = false;
    $scope.emailCheck = false;
    $scope.emailSpin = false;

    $scope.changeLanguage = function (langKey) {
        $translate.use(langKey);
    };

    $scope.registration = function (login, email, password) {
        getEncryption(function (encrypt) {
            let user = {
                login: login,
                email: email,
                password: encrypt.encrypt(password)
            };
            $http.post('/registration', user, {headers: {'Content-Type': 'application/json'}})
                .then(
                    function (response) {
                        $localStorage.user = response.headers().user;
                        $localStorage.role = response.headers().role;
                        $window.location.href = '/main.jsp';
                    }, function () {
                        alert("Bad registration")
                    });
        });
    };
    $scope.login = function (login, password) {
        getEncryption(function (encrypt) {
            let credentials = {
                login: login,
                password: encrypt.encrypt(password)
            };
            $http.post('/login', credentials, {headers: {'Content-Type': 'application/json'}})
                .then(
                    function (response) {
                        $localStorage.user = response.headers().user;
                        $localStorage.role = response.headers().role;
                        $window.location.href = '/main.jsp';
                    }, function () {
                        alert("Bad login or password");
                    });
        });
    };
    $scope.logout = function () {
        $cookies.remove("token");
        delete $localStorage.user;
        $http.defaults.headers.common = {};
        $window.location.href = '/';
    };

    $scope.runSpin = function (event, fieldCheck, fieldSpin) {
        if (event.keyCode === 8) {
            $scope[fieldCheck] = false;
            $scope[fieldSpin] = true
        }
    };

    let getEncryption = function (callback) {
        $http.get('/encrypt')
            .then(function (response) {
                let encrypt = new JSEncrypt();
                encrypt.setPublicKey(response.data);
                callback(encrypt);
            })
    };
});

app.directive('validateEquals', function () {
    return {
        scope: {
            matchTarget: '=',
        },
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            var passwordValidator = function (value) {
                ngModelCtrl.$setValidity('match', value === scope.matchTarget);
                return value;
            };

            ngModelCtrl.$parsers.unshift(passwordValidator);

            scope.$watch('matchTarget', function () {
                passwordValidator(ngModelCtrl.$viewValue);
            });
        }
    };
});

app.directive('validateEmail', ['$http', function ($http) {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            ngModelCtrl.$asyncValidators.emailValidator = function (modelValue, viewValue) {
                return $http.get('/userData', {params: {value: modelValue || viewValue, field: 'email'}})
                    .then(function () {
                        ngModelCtrl.$setValidity('validateEmail', false);
                        scope.emailSpin = false;
                        return false;
                    }, function () {
                        ngModelCtrl.$setValidity('validateEmail', true);
                        scope.emailSpin = false;
                        scope.emailCheck = true;
                        return true;
                    });
            }
        }
    };
}]);

app.directive('validateLogin', ['$http', function ($http) {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            ngModelCtrl.$asyncValidators.loginValidator = function (modelValue, viewValue) {
                return $http.get('/userData', {params: {value: modelValue || viewValue, field: 'login'}})
                    .then(function () {
                        ngModelCtrl.$setValidity('validateLogin', false);
                        scope.loginSpin = false;
                        return false;
                    }, function () {
                        ngModelCtrl.$setValidity('validateLogin', true);
                        scope.loginSpin = false;
                        scope.loginCheck = true;
                        return true;
                    });
            }
        }
    };
}]);


