<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <script src="//code.angularjs.org/snapshot/angular.min.js"></script>
    <script src="//code.angularjs.org/snapshot/angular-animate.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.7.2/angular-cookies.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ngStorage/0.3.11/ngStorage.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-resource/1.6.9/angular-resource.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/2.3.1/jsencrypt.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-local/angular-translate-storage-local.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-storage-cookie/angular-translate-storage-cookie.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-translate/2.18.1/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0-rc.0/angular-messages.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
          integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
    <link rel="stylesheet" href="style/login.css">
    <script src="app/app.js"></script>
    <script src="app/login.js"></script>
</head>
<body ng-app="myApp" ng-controller="loginCtrl">
<noscript>
    <style>html {
        display: none;
    }</style>
    <meta http-equiv="refresh" content="0; noscript.html"/>
</noscript>
<div class="login-container">
    <div class="panel panel-login p-4 position-relative" ng-cloak>
        <div class="panel-heading">
            <div class="row d-flex justify-content-around" ng-init="active=true">
                <a href="#" ng-class="{'active': active === true}" ng-click="checked=false; active=!active"
                   class="login-form-link form-link">{{'LOGIN'| translate}}</a>
                <a href="#" ng-class="{'active': active === false}" ng-click="checked=true; active=!active"
                   class="register-form-link form-link" id="register-form">{{'REGISTRATION'| translate}}</a>
            </div>
            <hr>
        </div>
        <div class="panel-body" ng-cloak>
            <div class="row">
                <div class="col-12 mw-25">
                    <form name="signin" ng-submit="login(authLogin, authPassword)" ng-hide="checked"
                          class="animate-show-hide" role="form" id="auth-login">
                        <div class="form-group">
                            <input type="text" name="login" ng-model="authLogin" tabindex="1" class="form-control"
                                   placeholder="{{'USERNAME'| translate}}" required>
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" ng-model="authPassword" tabindex="2"
                                   class="form-control" placeholder="{{'PASSWORD'| translate}}" required>
                        </div>
                        <div class="form-group text-center">
                            <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                            <label for="remember" translate="REMEMBER_ME"></label>
                        </div>
                        <div class="form-group">
                            <div class="d-flex justify-content-center m-auto">
                                <button type="submit" name="login-submit" tabindex="4"
                                        class="form-control btn btn-login"
                                        translate="LOGIN"></button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="text-center">
                                        <a href="#" tabindex="5" class="forgot-password"
                                           translate="FORGOT_PASSWORD"></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <form name="register" ng-show="checked" class="animate-show-hide" role="form"
                          ng-submit="registration(registrationLogin, registrationEmail, registrationPassword)"
                          novalidate>
                        <div class="form-group position-relative">
                            <input type="text" name="registrationLogin" ng-model="registrationLogin" tabindex="1"
                                   ng-class="{'is-invalid':register.registrationLogin.$invalid,
                                   'is-valid':register.registrationLogin.$valid}" class="form-control"
                                   ng-model-options="{ debounce : 1000}" required validate-login id="registration-login"
                                   placeholder="{{'USERNAME'| translate}}" ng-minlength="3" ng-maxlength="30"
                                   ng-pattern="/^([A-Za-zа-яА-Я0-9_])*$/" ng-trim="false"
                                   ng-keydown="runSpin($event, 'loginCheck', 'loginSpin')"
                                   ng-keypress="loginCheck = false; loginSpin = true">
                            <div class="loader animate-show-hide" ng-show="loginSpin == true"></div>
                            <div class="fas fa-check fa-2x validation-success animate-show-hide"
                                 ng-show="loginSpin == false && register.registrationLogin.$valid"
                                 id="login-success"></div>
                            <div class="fas fa-times fa-2x validation-failure animate-show-hide"
                                 ng-show="loginSpin == false && register.registrationLogin.$invalid
                                 && !register.registrationLogin.$pristine" id="login-error"></div>
                        </div>
                        <div ng-messages="register.registrationLogin.$error" class="help-block">
                            <div ng-message="minlength" translate="MIN_LENGTH" translate-value-length="3"></div>
                            <div ng-message="maxlength" translate="MAX_LENGTH" translate-value-length="30"></div>
                            <div ng-message="pattern" translate="LOGIN_PATTERN"></div>
                            <div ng-message="validateLogin" translate="LOGIN_EXISTS"></div>
                        </div>
                        <div class="form-group position-relative">
                            <input type="email" name="registrationEmail" ng-model="registrationEmail" tabindex="2"
                                   class="form-control" placeholder="{{'EMAIL_ADDRESS'| translate}}"
                                   ng-model-options="{ debounce : 1000}" required validate-email id="registration-email"
                                   ng-class="{'is-invalid':register.registrationEmail.$invalid,
                                   'is-valid':register.registrationEmail.$valid}" ng-trim="false"
                                   ng-keydown="runSpin($event, 'emailCheck', 'emailSpin')"
                                   ng-keypress="emailCheck = false; emailSpin = true">
                            <div class="loader animate-show-hide" ng-show="emailSpin == true"></div>
                            <div class="fas fa-check fa-2x validation-success animate-show-hide"
                                 ng-show="emailSpin == false && register.registrationEmail.$valid"
                                 id="email-success"></div>
                            <div class="fas fa-times fa-2x validation-failure animate-show-hide"
                                 ng-show="emailSpin == false && register.registrationEmail.$invalid
                                 && !register.registrationEmail.$pristine" id="email-error"></div>
                        </div>
                        <div ng-messages="register.registrationEmail.$error" class="help-block">
                            <div ng-message="email" translate="EMAIL_PATTERN"></div>
                            <div ng-message="validateEmail" translate="EMAIL_EXISTS"></div>
                        </div>
                        <div class="form-group">
                            <input type="password" name="registrationPassword" ng-model="registrationPassword"
                                   tabindex="3" class="form-control" placeholder="{{'PASSWORD'| translate}}" required
                                   ng-class="{'is-invalid':register.registrationPassword.$invalid,
                                   'is-valid':register.registrationPassword.$valid}" ng-minlength="8" ng-maxlength="30"
                                   ng-pattern="/^(?=.*\d)(?=.*[a-zа-я])(?=.*[A-ZА-Я]).*$/" id="registrationPassword">
                        </div>
                        <div ng-messages="register.registrationPassword.$error" class="help-block">
                            <div ng-message="minlength" translate="MIN_LENGTH" translate-value-length="8"></div>
                            <div ng-message="maxlength" translate="MAX_LENGTH" translate-value-length="30"></div>
                            <div ng-message="pattern" translate="PASSWORD_PATTERN"></div>
                        </div>
                        <div class="form-group">
                            <input type="password" name="registrationPasswordConfirm"
                                   ng-model="registrationPasswordConfirm" id="registrationPasswordConfirm"
                                   tabindex="4" class="form-control" placeholder="{{'CONFIRM_PASSWORD'| translate}}"
                                   ng-class="{'is-invalid':register.registrationPasswordConfirm.$invalid,
                                   'is-valid':register.registrationPasswordConfirm.$valid}"
                                   required validate-equals match-target="registrationPassword">
                        </div>
                        <div ng-messages="register.registrationPasswordConfirm.$error" class="help-block">
                            <div ng-message="match" translate="PASSWORDS_MUST_MATCH"></div>
                        </div>
                        <button type="submit" name="register-submit" tabindex="5"
                                class="form-control btn btn-register" id="register-submit"
                                ng-disabled="register.$invalid || loginCheck == false || emailCheck == false"
                                translate="REGISTER_NOW"></button>
                    </form>
                </div>
            </div>
        </div>
        <img src="img/bird.png" class="bird-img" alt="Bird">
    </div>
</div>
</body>
</html>