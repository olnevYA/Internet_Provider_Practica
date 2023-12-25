var app = angular.module("myApp");

app.controller("officeCtrl", function ($scope, $http, $localStorage) {

    $scope.login = $localStorage.user;

    angular.element(document).ready(function () {
        getUser();
    });

    var getUser = function () {
        $http.get("/user")
            .then(function (response) {
                $scope.user = response.data
            }, function () {
                alert("Server is not responding")
            })
    };

    $scope.pay = function () {
        $http.put("/payment", {cash: $scope.cash}, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                getUser();
                $('#payment').modal('hide')
            }, function () {
                alert("Server is not responding")
            })
    };

    $('#payment').on('hide.bs.modal', function () {
        $scope.cash = null;
    });

    $scope.deactivate = function () {
        $http.put("/user", {tariff_id: -1}, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                getUser();
            })
    };

    $scope.getTotal = function () {
        let total = 0;
        if (!angular.isUndefined($scope.user)) {
            for (let i = 0; i < $scope.user.rewards.length; i++) {
                let reward = $scope.user.rewards[i];
                total += reward.bonusPoints;
            }
        }
        return total;
    };
});
