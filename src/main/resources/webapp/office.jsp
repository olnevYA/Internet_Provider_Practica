<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Office</title>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-local/angular-translate-storage-local.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0-rc.0/angular-messages.min.js"></script>
    <script src="app/app.js"></script>
    <script src="app/login.js"></script>
    <script src="app/office.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
          integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
    <link rel="stylesheet" href="style/header.css">
    <link rel="stylesheet" href="style/office.css">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC|Cormorant+Infant" rel="stylesheet">
</head>
<body ng-app="myApp" ng-controller="officeCtrl">
<jsp:include page="header.jspf">
    <jsp:param name="pageTitle" value="office"/>
</jsp:include>
<div class="content-container">
    <div class="user-info d-flex justify-content-between flex-wrap flex-md-nowrap flex-sm-wrap mt-3" ng-cloak>
        <div class="w-100 text-left text-md-center text-sm-left hello-container">
            <span class="user-name w-100 d-inline text-nowrap" translate="HELLO"
                  translate-value-name="{{login}}"></span>
            <img class="cartoon-img non-hover-img d-inline" ng-src="{{user.tariff.imgUrl}}">
        </div>
        <div class="user-status text-center w-auto">
            <span translate="STATUS"></span><span class="main-info" translate="{{user.status}}"></span>
        </div>
    </div>
    <div class="d-flex tariff-balance justify-content-between flex-wrap flex-md-nowrap flex-sm-wrap ml-sm-0 ml-0 ml-md-5 mt-3 mr-5"
         ng-cloak>
        <div class="tariff-info" ng-if="user.tariff.title" ng-cloak>
            <span translate="CONNECTED_TARIFF"></span>:<span class="main-info">{{user.tariff.title}}</span><br>
            <span translate="DOWNLOAD_UPLOAD_SPEED"></span>:
            <span class="main-info">{{user.tariff.downloadSpeed}}/{{user.tariff.uploadSpeed}} </span>
            <span translate="Mbps"></span><br>
            <span ng-if="user.tariff.traffic == 0"><span translate="TRAFFIC"></span>:
<span class="main-info" translate="UNLIMITED"></span><br></span>
            <span ng-if="user.tariff.traffic != 0"><span translate="TRAFFIC"></span>:
<span class="main-info">{{user.tariff.traffic}} </span><span translate="GB"></span><br></span>
            <span translate="COST"></span>: <span class="main-info ">{{user.tariff.cost}} </span><span
                translate="RUB"></span><br>
            <button class="btn btn-secondary" ng-click="deactivate()" translate="DISABLE_SERVICE"></button>
        </div>
        <div class="tariff-info" ng-if="!user.tariff.title" ng-cloak>
            <p translate="TARIFF_IS_NOT_SELECTED"></p>
            <a href="tariffs.jsp" target="_self" translate="SELECT_TARIFF"></a>
        </div>
        <div class="balance w-auto align-self-center mt-5 mt-md-0 mt-sm-5" ng-cloak>
            <p translate="ACCOUNT_BALANCE"></p>
            <span translate="CURRENT_BALANCE"></span>:<span class="main-info">{{user.cash}}</span><span
                translate="RUB"></span><br>
            <span translate="BONUSES"></span>:<span class="main-info">{{user.bonusAmount}}</span><span
                translate="POINTS"></span><br>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#payment"
                    translate="REPLENISH_BALANCE"></button>
        </div>
    </div>
    <div class="carousel-container d-flex justify-content-md-center justify-content-sm-left justify-content-left flex-wrap flex-md-nowrap flex-sm-wrap
mt-sm-3 mb-sm-3 mt-3 mb-3 mt-md-0 mb-md-0"
         ng-cloak>
        <div id="carouselIndicators" class="carousel w-50 mw-100 slide" data-ride="carousel" data-interval="3000">
            <div class="carousel-inner text-center">
                <jsp:useBean id="rewardDao" class="com.epam.internet_provider.dao.impl.RewardDaoImpl"/>
                <c:set var="rewards" value="${rewardDao.rewards}"/>
                <c:forEach items="${rewards}" var="reward" varStatus="rewardLoop">
                    <div class="carousel-item flex-column" ng-class="{'active': ${rewardLoop.index} == 0}">
                        <a class="img-container h-auto" href="reward.jsp" target="_self">
                            <img ng-src="${reward.imgHref}" alt="${reward.title}"></a>
                        <div class="carousel-caption position-static pb-3 pt-0">
                            <h3 class="mb-0">${reward.title}</h3>
                            <span>${reward.bonusPoints} </span><span translate="POINTS"></span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <ol class="carousel-indicators">
                <c:forEach items="${rewards}" var="reward" varStatus="rewardLoop">
                    <li data-target="#carouselIndicators" data-slide-to="${rewardLoop.index}"
                        ng-class="{'active': ${rewardLoop.index} == 0}"></li>
                </c:forEach>
            </ol>
            <a class="carousel-control-prev align-self-center" href="#carouselIndicators" role="button"
               data-slide="prev">
                <i class="fas fa-angle-left fa-3x" aria-hidden="true"></i>
            </a>
            <a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
                <i class="fas fa-angle-right fa-3x"></i>
            </a>
        </div>
        <div class="reward-history-container  ml-5 align-self-end">
            <button type="button" class="btn" data-toggle="modal" data-target="#rewardModal"
                    translate="PURCHASES_HISTORY"></button>
        </div>
    </div>
</div>
<!-- Modal Payment -->
<div class="modal fade modal-payment" id="payment" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form ng-submit="pay()">
                <div class="modal-header">
                    <h4 class="modal-title m-auto" id="paymentModal">Belarus Bank</h4>
                    <button type="button" class="close position-absolute" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="inputSum" translate="MAX_MIN_SUPPLEMENT"></label>
                    <input type="number" name="cash" min="1" max="50" required class="form-control" id="inputSum"
                           ng-model="cash" aria-describedby="sumHelp" placeholder="{{'ENTER_AMOUNT' | translate}}">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <i class="fa fa-times"></i><span translate="CANCEL"></span>
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-check"></i><span translate="REPLENISH"></span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Modal Rewards-->
<div class="modal fade reward-modal text-center" id="rewardModal" tabindex="-1" role="dialog"
     aria-labelledby="rewardModalTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header d-flex justify-content-center">
                <h5 class="modal-title" id="rewardModalTitle" translate="COMPLETED_PURCHASES"></h5>
            </div>
            <div class="modal-body">
                <div ng-repeat="reward in user.rewards">
                    <h4>{{reward.title}}</h4>
                    <img class="rounded mx-auto d-block" ng-src="{{reward.imgHref}}" alt="{{reward.title}}">
                    <h6>{{reward.bonusPoints}} {{'POINTS' | translate}}</h6>
                    <hr ng-if="!$last">
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <h5 class="total-info" translate="TOTAL_POINTS_SPENT" translate-value-number="{{getTotal()}}"></h5>
                <button type="button" class="btn btn-secondary btn-close" data-dismiss="modal">
                    <i class="fa fa-times"></i><span translate="CLOSE"></span>
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>