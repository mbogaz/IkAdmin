

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Giriş Yapınız</title>

    <!-- Bootstrap core CSS -->
    <link href="resource/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="resource/css//ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="resource/css/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="resource/js/ie-emulation-modes-warning.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
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
    <div class="container">

      <form class="form-signin" method="post" action="ldapLogin.jsp" >
        <input type="text" id="userName" name="userName" class="form-control" placeholder="Kullanıcı Adı" autofocus>
        <input type="password" id="password" name="password" class="form-control" placeholder="Şifre" >

        <button class="btn btn-lg btn-primary btn-block" type="submit">IK Olarak Giriş Yap</button>
        <a href="https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=86vvecy3ntqbft&redirect_uri=http://localhost:26201/mavenproject2/Actions/linkedinLogin.jsp?type=1" 
           class="btn btn-lg btn-primary btn-block">LinkedIn İle Giriş Yap</a>
        <a href="editForms.jsp" class="btn btn-lg btn-primary btn-block">İlanları Gör</a>
      </form>
        

    </div> <!-- /container -->


  </body>
</html>

