var app = angular.module("myApp");

app.controller("userCtrl", function ($scope, $http) {
    $scope.users = null;
    $scope.statuses = null;

    let getUsers = function () {
        $http.get("/users")
            .then(function (response) {
                $scope.users = response.data
            }, function () {
                alert("Server is not responding")
            })
    };

    let getStatuses = function () {
        $http.get("/userStatus")
            .then(function (response) {
                $scope.statuses = response.data
            }, function () {
                alert("Server is not responding")
            })
    };

    $scope.changeStatus = function (login, status) {
        let user = {
            login: login,
            status: status
        };
        $http.put("/userStatus", user, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                getUsers();
                getStatuses();
            });
    };

    angular.element(document).ready(function () {
        getUsers();
        getStatuses();
    });
});
