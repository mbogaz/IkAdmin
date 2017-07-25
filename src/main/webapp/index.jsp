
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <%
        if(request.getParameter("err_no")!=null){
            int err_no = Integer.parseInt(request.getParameter("err_no"));
            switch(err_no){
                case 1:
                    out.println("<script>$(document).ready(function(){alert('Hatalı Kullanıcı Adı yada Şifre'); });</script>");
                    break;
                case 2: 
                    out.println("<script>$(document).ready(function(){alert('Lütfen Oturum Açınız'); });</script>");
                    break;
            }
        }
    %>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    
<!-- Mirrored from keenthemes.com/preview/metronic/theme/admin_1/page_user_login_1.html by HTTrack Website Copier/3.x [XR&CO'2013], Tue, 25 Jul 2017 07:22:00 GMT -->
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
<head>
        <meta charset="utf-8" />
        <title>IK Admin</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="Preview page of Metronic Admin Theme #1 for " name="description" />
        <meta content="" name="author" />
        <link href="http://keenthemes.com/preview/metronic/theme/assets/pages/css/login.min.css" rel="stylesheet" type="text/css" />

        <jsp:include page="Views/imports.jsp" />
        
        <link rel="shortcut icon" href="resource/img/icon.png" /> 
</head>
    <!-- END HEAD -->

    <body class=" login">
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <form class="login-form" action="Actions/ldapLogin.jsp" method="post">
                <h3 class="form-title font-green">Giriş</h3>
                <div class="alert alert-danger display-hide">
                    <button class="close" data-close="alert"></button>
                    <span> Lütfen bilgilerinizi giriniz. </span>
                </div>
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Kullanıcı Adı</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Kullanıcı Adı" name="userName" /> </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Şifre</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Şifre" name="password" /> </div>
                <div class="form-actions">
                    <button type="submit" class="btn green uppercase">Giriş</button>
                </div>
                <div class="login-options">
                    <a href="https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=86vvecy3ntqbft&scope=r_basicprofile%20r_emailaddress&redirect_uri=http://localhost:21222/mavenproject2/Actions/linkedinLogin.jsp?type=1">
                    <h4>Linked-in ile gir</h4>
                    </a>
                    <ul class="social-icons">
                        <li>
                            <a class="social-icon-color linkedin" data-original-title="Linkedin" href="https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=86vvecy3ntqbft&scope=r_basicprofile%20r_emailaddress&redirect_uri=http://localhost:21222/mavenproject2/Actions/linkedinLogin.jsp?type=1"></a>
                        </li>
                    </ul>
                </div>
                <div class="login-options">
                    <a href="jobs.jsp"><h4>Tüm ilanları gör</h4></a>
                </div>
            </form>
            <!-- END LOGIN FORM -->
        </div>
        
<!-- End -->
</body>


</html>