var app = angular.module("myApp");

app.controller("tariffCtrl", function ($scope, $http) {
    var self = this;
    $scope.user = null;
    $scope.tariffs = null;

    let getUser = function () {
        $http.get("/user")
            .then(function (response) {
                $scope.user = response.data
            }, function () {
                alert("Server is not responding")
            })
    };

    let getTarrifs = function () {
        $http.get("/tariff")
            .then(function (response) {
                $scope.tariffs = response.data
            }, function () {
                alert("Server is not responding")
            })
    };

    $scope.runActivateModal = function (id, title, cost) {
        self.connectedTariffId = id;
        self.connectedTariffTitle = title;
        self.connectedTariffCost = cost;
        $('#connect').modal('show');
    };

    $scope.activate = function (id) {
        $http.put("/user", {tariff_id: id}, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                getUser();
                $('#connect').modal('hide');
            }, function () {
                alert("You are Blocked! Ha-ha!")
            });
    };

    $scope.runChangeModal = function (id, title, downloadSpeed, uploadSpeed, traffic, cost, imgUrl) {
        self.changingTariffId = id;
        self.changingTariffTitle = title;
        self.changingTitle = title;
        self.changingDownloadSpeed = downloadSpeed;
        self.changingUploadSpeed = uploadSpeed;
        self.changingTraffic = traffic;
        self.changingCost = cost;
        self.changingImgUrl = imgUrl;
        $('#changeTariffModal').modal('show');
    };

    $scope.createTariff = function (title, downloadSpeed, uploadSpeed, traffic, cost, imgUrl) {
        let tariff = {
            title: title,
            downloadSpeed: downloadSpeed,
            uploadSpeed: uploadSpeed,
            traffic: traffic,
            cost: cost,
            imgUrl: imgUrl
        };
        $http.post('/tariff', tariff, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                $('#createTariffModal').modal('hide')
                getTarrifs();
            }, function () {
                alert("Тариф " + title + " уже существует");
            })
    };

    $scope.changeTariff = function (title, downloadSpeed, uploadSpeed, traffic, cost, imgUrl) {
        let tariff = {
            id: self.changingTariffId,
            title: title,
            downloadSpeed: downloadSpeed,
            uploadSpeed: uploadSpeed,
            traffic: traffic,
            cost: cost,
            imgUrl: imgUrl
        };
        $http.put("/tariff", tariff, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                getTarrifs();
                $('#changeTariffModal').modal('hide')
            }, function () {
                alert("Server is not responding")
            });
    };

    $scope.deleteTariff = function (id) {
        bootbox.confirm({
            title: "Удалить тариф?",
            className: 'tariff-confirm',
            closeButton: false,
            message: "Вернуть это изменение будет невозможно.",
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> Отмена'
                },
                confirm: {
                    label: '<i class="fa fa-check"></i> Подтвердить'
                }
            },
            callback: function (result) {
                if (result) {
                    $http.delete('/tariff', {params: {tariff_id: id}}, {headers: {'Content-Type': 'application/json'}})
                        .then(
                            function () {
                                getTarrifs();
                            },
                            function (error) {
                                alert("Ошибка:" + error)
                            });
                }
            }
        });
    };

    angular.element(document).ready(function () {
        getUser();
        getTarrifs();
    });
})
;