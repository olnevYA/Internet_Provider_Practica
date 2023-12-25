<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Main</title>
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
    <link href="https://fonts.googleapis.com/css?family=Dancing+Script|Gloria+Hallelujah|Great+Vibes|Hanalei+Fill|Kirang+Haerang|Modern+Antiqua|Pacifico|Ranga|Sacramento|Shadows+Into+Light"
          rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="style/header.css">
    <link rel="stylesheet" href="style/main.css">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC|Cormorant+Infant" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jspf">
    <jsp:param name="pageTitle" value="main"/>
</jsp:include>
<div class="content-container">
    <div class="carousel-container">
        <div id="carouselControls" class="carousel slide" data-pause="false" data-ride="carousel" data-interval="3500">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block" src="img/aboutCompany.jpg" alt="First slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block" src="img/boy.jpg" alt="Second slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block" src="img/letaet-vo-sne.jpg" alt="Third slide">
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>