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
<hr style="color: black; height: 1px; background-color:black;" />

                <div class="form-signin" style="max-width: 1000px">


                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            <image src="<% out.println(obj.getString("pictureUrl")); %>" class="img-thumbnail center-block">
                            <p><label>İsim:&nbsp;&nbsp;<% out.print(obj.getString("fn"));%></label></p> 
                            <p><label>Soyisim:&nbsp;<% out.print(obj.getString("ln")); %></label></p>
                            
                            <p><label>Kişisel Ve Profesyonel Özellikler:&nbsp;<% out.print(obj.getString("skills")); %></label></p>
                        </div>
                </div>
                        
                <div class="col-xs-6 wow animated slideInRight " data-wow-delay=".5s">
                            <a href="#" class="btn btn-s btn-primary btn-block" style="width:50%">Kara Listeye Al</a>
                            </br></br>
                            <p><label>Durum:&nbsp;<% out.print(obj.getString("headline")); %></label></p>
                            <p><label>Lokasyon:&nbsp;<% out.print(obj.getString("location")); %></label></p>
                            <p><label>E mail:&nbsp;<% out.print(obj.getString("emailAddress")); %></label></p>                                                    

                </div>
</div>
                            </br>
                            
<div class="container">   
    <div class="" style="max-width: 1000px;padding-left: 15px;">
        <hr style="color: black; height: 1px; background-color:black;" />
        <div class="col-xs-12 wow animated slideInLeft" data-wow-delay=".5s">         
                <h3>Tüm Başvuruları</h3>
                <%
                  ArrayList<JSONObject> registerList = mongo.getRegistersByUserId(obj.getString("user"));
                  for(JSONObject registerObj:registerList){
                      int status = registerObj.getInt("status");
                      int advertCode = registerObj.getInt("advertCode");
                      String emailTo = obj.getString("emailAddress");
                      out.println("</br><p style=\"float:left;    margin-right: 50px;\">"
                              +"<a href=\"editForms.jsp\">"
                              +mongo.getElement("advert", advertCode+"").getString("header")
                              +"</a></p>");
                      out.println("<a class=\"btn btn-xs btn"+(status==1?"-warning":"-default")+"\" "
                              + "href=\"Actions/register.jsp?type=3&advertCode="+advertCode+"&id="+user+"&emailTo="+emailTo+"\">İşleme Al</a>&nbsp;&nbsp;&nbsp;"
                              + "<a class=\"btn btn-xs btn"+(status==2?"-success":"-default")+"\" "
                              + "href=\"Actions/register.jsp?type=4&advertCode="+advertCode+"&id="+user+"&emailTo="+emailTo+"\">Kabul Et</a>&nbsp;&nbsp;&nbsp;"
                              + "<a class=\"btn btn-xs btn"+(status==3?"-danger":"-default")+"\" "
                              + "href=\"Actions/register.jsp?type=5&advertCode="+advertCode+"&id="+user+"&emailTo="+emailTo+"\">Reddet</a>");
                  }

                %>
        </div>             
    </div>                 
</div> <!-- /container -->
 </body>
</html>
