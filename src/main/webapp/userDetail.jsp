<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    MongoDBJDBC mongo = new MongoDBJDBC();
    if ("POST".equalsIgnoreCase(request.getMethod())) { 
 
        
    } else { 
        
    }
    String user = request.getParameter("user");
    JSONObject obj = mongo.getElement("user", user);
%> 
<!DOCTYPE html>
<html>
 <head>
     <link rel="stylesheet" href="resource/css/bootstrap.min.css">
     <link rel="stylesheet" href="resource/css/form.css">
     <link rel="stylesheet" href="resource/css/hastag.css">
     <link href="resource/css/signin.css" rel="stylesheet" >
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
     <script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js'></script>
     <script type="text/javascript" src="resource/js/hastag.js"></script>
     <script type="text/javascript" src="resource/js/jquery.tagsinput.js"></script>
  

 </head>
 <body>
     <jsp:include page="Views/navbarIk.jsp" />
<div class="container">
                <!-- Form Area -->
                <div class="form-signin" style="max-width: 1000px">


                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            <image src="<% out.println(obj.getString("pictureUrl")); %>" class="img-thumbnail center-block">
                            <p><label>İsim:&nbsp;&nbsp;<% out.print(obj.getString("fn"));%></label></p> 
                            <p><label>Soyisim:&nbsp;<% out.print(obj.getString("ln")); %></label></p>
                            <p><label>Durum:&nbsp;<% out.print(obj.getString("headline")); %></label></p>
                            <p><label>Lokasyon:&nbsp;<% out.print(obj.getString("location")); %></label></p>
                            <p><label>E mail:&nbsp;<% out.print(obj.getString("emailAddress")); %></label></p>
                            <p><label>Kişisel Ve Profesyonel Özellikler:&nbsp;<% out.print(obj.getString("skills")); %></label></p></div>
                        </div>
                        
                        <div class="col-xs-6 wow animated slideInRight" data-wow-delay=".5s">
                            <label>Tüm Başvuruları</label>
                            <%
                              ArrayList<JSONObject> registerList = mongo.getRegistersByUserId(obj.getString("user"));
                              for(JSONObject registerObj:registerList){
                                  out.println("</br>"+mongo.getElement("advert", registerObj.getInt("advertCode")+"").getString("header"));
                              }
                            
                            %>
                        <div class="clear"></div>


                </div><!-- End Contact Form Area -->
</div> <!-- /container -->
 </body>
</html>
