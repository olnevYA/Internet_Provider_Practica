var app = angular.module("myApp");

app.controller("rewardCtrl", function ($scope, $http) {
    var self = this;

    $scope.runAddRewardModal = function (id, title, bonusPoints) {
        self.rewardId = id;
        self.rewardTitle = title;
        self.rewardBonusPoints = bonusPoints;
        $('#add-reward-modal').modal('show');
    };

    $scope.addReward = function (id) {
        $http.post("/reward", {rewardId: id}, {headers: {'Content-Type': 'application/json'}})
            .then(function () {
                $('#add-reward-modal').modal('hide');
            }, function () {
                alert("Not enough bonus points!")
            });
    };
});