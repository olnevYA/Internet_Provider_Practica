<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <title>Tariffs</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <script src="//code.angularjs.org/snapshot/angular.min.js"></script>
    <script src="//code.angularjs.org/snapshot/angular-animate.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ngStorage/0.3.11/ngStorage.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-resource/1.6.9/angular-resource.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.7.2/angular-cookies.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.4.0/bootbox.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-local/angular-translate-storage-local.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0-rc.0/angular-messages.min.js"></script>
    <script src="app/app.js"></script>
    <script src="app/login.js"></script>
    <script src="app/tariff.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
          integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="style/tariffs.css">
    <link rel="stylesheet" href="style/header.css">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC|Cormorant+Infant" rel="stylesheet">
</head>
<body ng-app="myApp" ng-controller="tariffCtrl as $ctrl">
<jsp:include page="header.jspf">
    <jsp:param name="pageTitle" value="tariffs"/>
</jsp:include>
<div class="content-container">
    <div class="create-tariff" ng-if="user.role == 'Admin'" data-toggle="modal" data-target="#createTariffModal"
         ng-cloak
         translate="CREATE_NEW_TARIFF">
    </div>
    <div class="table-container table-responsive">
        <p class="table-caption" translate="TARIFFS"></p>
        <table class="tariffs-table table" ng-cloak>
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col" translate="TITLE"></th>
                <th scope="col">{{'DOWNLOAD_UPLOAD_SPEED' | translate}}, {{'Mpbs' | translate}}</th>
                <th scope="col">{{'TRAFFIC_AMOUNT' | translate}}, {{'GB' | translate}}</th>
                <th scope="col">{{'COST' | translate}}, {{'RUB' | translate}}</th>
                <th scope="col" translate="STATUS"></th>
                <th ng-if="user.role == 'Admin'" colspan="2" translate="ACTION"></th>
            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="tariff in tariffs">
                <td> {{$index + 1}}</td>
                <td width="150px"> {{tariff.title}}</td>
                <td> {{tariff.downloadSpeed}}/{{tariff.uploadSpeed}}</td>
                <td>
                    <div ng-if="tariff.traffic == 0" translate="UNLIMITED"></div>
                    <div ng-if="tariff.traffic != 0"> {{tariff.traffic}}</div>
                </td>
                <td> {{tariff.cost}}</td>
                <td>
                    <button ng-click="runActivateModal(tariff.id, tariff.title, tariff.cost)"
                            ng-disabled="user.tariff.id == tariff.id || user.status == 'Blocked'"
                            ng-class="{'current-tariff btn-info' : user.tariff.id == tariff.id,
                        'not-current-tariff btn-dark' : user.tariff.id != tariff.id}" type="button" class="btn btn-lg">
                        <div ng-if="user.tariff.id != tariff.id" translate="CONNECT"></div>
                        <div ng-if="user.tariff.id == tariff.id" translate="CONNECTED"></div>
                    </button>
                </td>
                <td ng-if="user.role == 'Admin'">
                    <button class="btn admin-button btn-lg" data-toggle="modal" ng-click="runChangeModal(tariff.id, tariff.title,
                        tariff.downloadSpeed, tariff.uploadSpeed, tariff.traffic, tariff.cost, tariff.imgUrl)"
                            translate="CHANGE">
                    </button>
                </td>
                <td ng-if="user.role == 'Admin'">
                    <button class="btn btn-lg admin-button" ng-click="deleteTariff(tariff.id)"
                            translate="REMOVE"></button>
                </td>
            </tr>
            </tbody>
        </table>
        <h3 ng-if="user.status == 'Blocked'" ng-cloak translate="BLOCKED_MESSAGE"></h3>
    </div>
</div>
<!-- Modal Connect -->
<div class="modal fade modal-connect" id="connect" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title" id="connectModal" translate="CONNECT_TARIFF"
                     translate-value-name="{{$ctrl.connectedTariffTitle}}"></div>
            </div>
            <div class="modal-body">
                <div class="m-auto" translate="PRICE_ALERT" translate-value-cost="{{$ctrl.connectedTariffCost}}"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn confirm-cancel" data-dismiss="modal">
                    <i class="fa fa-times"></i><span translate="CANCEL"></span>
                </button>
                <button type="button" class="btn btn-info" ng-click="activate($ctrl.connectedTariffId)">
                    <i class="fa fa-check"></i><span translate="CONFIRM"></span>
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Create Modal -->
<div class="modal fade" ng-cloak ng-if="user.role == 'Admin'" id="createTariffModal" tabindex="-1" role="dialog"
     aria-labelledby="createTariffModal"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form ng-submit="createTariff(title, downloadSpeed, uploadSpeed, traffic, cost, imgUrl)">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createTariffModalLabel">Создать тариф</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="inputTitle" class="col-auto col-form-label">Название</label>
                        <div class="col-auto">
                            <input type="text" ng-model="title" class="form-control" id="inputTitle"
                                   placeholder="Название">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="downloadSpeed" class="col-auto col-form-label">Скорость приёма, Мбит/с</label>
                        <div class="col-auto">
                            <input type="number" ng-model="downloadSpeed" class="form-control" id="downloadSpeed"
                                   placeholder="Скорость приёма">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="uploadSpeed" class="col-auto col-form-label">Скорость передачи, Мбит/с</label>
                        <div class="col-auto">
                            <input type="number" ng-model="uploadSpeed" class="form-control" id="uploadSpeed"
                                   placeholder="Скорость передачи">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="traffic" class="col-auto col-form-label">Траффик, ГБ</label>
                        <div class="col-auto">
                            <input type="number" ng-model="traffic" class="form-control" id="traffic"
                                   placeholder="Траффик">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="cost" class="col-auto col-form-label">Стоимость, р</label>
                        <div class="col-auto">
                            <input type="number" ng-model="cost" class="form-control" id="cost"
                                   placeholder="Стоимость">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="img-url" class="col-auto col-form-label">Изображение</label>
                        <div class="col-auto">
                            <input type="text" ng-model="imgUrl" class="form-control" id="img-url"
                                   placeholder="url">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- Change Modal -->
<div class="modal fade" ng-cloak ng-if="user.role == 'Admin'" id="changeTariffModal" tabindex="-1" role="dialog"
     aria-labelledby="changeTariffModal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form ng-submit="changeTariff($ctrl.changingTitle, $ctrl.changingDownloadSpeed, $ctrl.changingUploadSpeed,
        $ctrl.changingTraffic, $ctrl.changingCost, $ctrl.changingImgUrl)">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changeTariffModalLabel">Изменить тариф
                        {{$ctrl.changingTariffTitle}}</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Название</label>
                        <div class="col-auto">
                            <input type="text" id="changingTitle" ng-model="$ctrl.changingTitle"
                                   class="form-control" placeholder="Название" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Скорость приёма, Мбит/с</label>
                        <div class="col-auto">
                            <input type="number" id="changingDownloadSpeed" ng-model="$ctrl.changingDownloadSpeed"
                                   class="form-control" placeholder="Скорость приёма" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Скорость передачи, Мбит/с</label>
                        <div class="col-auto">
                            <input type="number" id="changingUploadSpeed" ng-model="$ctrl.changingUploadSpeed"
                                   class="form-control" placeholder="Скорость передачи" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Траффик, ГБ</label>
                        <div class="col-auto">
                            <input type="number" id="changingTraffic" ng-model="$ctrl.changingTraffic"
                                   class="form-control" placeholder="Траффик" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Стоимость, р</label>
                        <div class="col-auto">
                            <input type="number" id="changingCost" ng-model="$ctrl.changingCost" class="form-control"
                                   placeholder="Стоимость" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-auto col-form-label">Изображение</label>
                        <div class="col-auto">
                            <input type="text" id="changingImgUrl" ng-model="$ctrl.changingImgUrl" class="form-control"
                                   placeholder="url" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>