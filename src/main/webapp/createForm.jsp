<%@page import="java.util.ArrayList"%>
<%@page import="Object.IKUser"%>
<%@page import="com.mycompany.mavenproject2.LDAPLoginAuthentication"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%      

       LDAPLoginAuthentication ldap = new LDAPLoginAuthentication();
       ArrayList<IKUser> ikList = ldap.getIKList();
       boolean isLogin = false;
       for (IKUser ik : ikList) {
              if(ik.getUserName().equals(request.getParameter("userName"))
                      &&
                 ik.getPasssword().equals(request.getParameter("password"))){
                  session.setAttribute( "userName",request.getParameter("userName") );
                  isLogin = true;
              } 
           }
       if(!isLogin){
            String redirectURL = "index.jsp?err_no=1";
            response.sendRedirect(redirectURL);
       }
%>
<%
    /*if ("POST".equalsIgnoreCase(request.getMethod())) {
        out.println("POST:"+request.getParameter("name"));
    } else {
    }*/
%>
<!DOCTYPE html>
<html>
 <head>
     <link rel="stylesheet" href="resource/css/bootstrap.min.css">
     <link rel="stylesheet" href="resource/css/form.css">
     <link href="resource/css/signin.css" rel="stylesheet" >
 </head>
 <body>
    <jsp:include page="Views/navbar.jsp" />
<div class="container">
                <!-- Form Area -->
                <div class="form-signin" style="max-width: 1000px">
                    <!-- Form -->
                    <form id="contact-us" method="post" action="createForm.jsp">
                        <!-- Left Inputs -->
                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            <!-- Name -->
                            <input type="text" name="name" id="name" class="form" placeholder="Pozisyon" />
                            <!-- Email -->
                            <input type="text" name="date" id="date" class="form" placeholder="İlanın kapanma tarihi" />
                            <!-- Subject -->
                            <div class="form">
                                İlan Aktif mi: <input type="checkbox" checked data-toggle="toggle">
                            </div>
                            </div><!-- End Left Inputs -->
                        <!-- Right Inputs -->
                        <div class="col-xs-6 wow animated slideInRight" data-wow-delay=".5s">
                            <!-- Message -->
                            <textarea name="message" id="message" class="form textarea"  placeholder="Açıklama"></textarea>
                        </div><!-- End Right Inputs -->
                        <!-- Bottom Submit -->
                        <div class="relative fullwidth col-xs-12">
                            <!-- Send Button -->
                            <button type="submit" id="submit" name="submit" class="form-btn semibold">Oluştur</button> 
                        </div><!-- End Bottom Submit -->
                        <!-- Clear -->
                        <div class="clear"></div>
                    </form>

                    <!-- Your Mail Message -->
                    <div class="mail-message-area">
                        <!-- Message -->
                        <div class="alert gray-bg mail-message not-visible-message">
                            <strong>Thank You !</strong> Your email has been delivered.
                        </div>
                    </div>

                </div><!-- End Contact Form Area -->
</div> <!-- /container -->
 </body>
</html>
