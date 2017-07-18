<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    MongoDBJDBC mongo = new MongoDBJDBC();

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
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <script type="text/javascript" src="resource/js/hastag.js"></script>
     <script type="text/javascript" src="resource/js/jquery.tagsinput.js"></script>
  

 </head>
 <body>
     <jsp:include page="Views/navbarIk.jsp" />
<div class="container">
                <div class="form-signin" style="max-width: 1000px">


                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            <image src="<% out.println(obj.getString("pictureUrl")); %>" class="img-thumbnail center-block">
                            </br>
                            <% if(!obj.isNull("blackList")){%>
                              <div class="alert alert-danger">
                                  <strong>Kara Listede : </strong><% out.print(obj.getString("blackList")); %>
                              </div>
                            <% } %>
                            <p><label>İsim:&nbsp;&nbsp;<% out.print(obj.getString("fn"));%></label></p> 
                            <p><label>Soyisim:&nbsp;<% out.print(obj.getString("ln")); %></label></p>
                            
                            <p><label>Kişisel Ve Profesyonel Özellikler:&nbsp;<% out.print(obj.getString("skills")); %></label></p>
                        </div>
                </div>
                        
                <div class="col-xs-6 wow animated slideInRight " data-wow-delay=".5s">
                    <% if(obj.isNull("blackList")) {%>
                            <a href="#" class="btn btn-s btn-primary btn-block" data-toggle="modal" data-target="#myModal" style="width:50%">Kara Listeye Al</a>
                    <% } else {%>
                            <a href="Actions/toBlackList.jsp?type=1&userId=<% out.print(user); %>" 
                               class="btn btn-s btn-primary btn-block" style="width:50%">Kara Listeden Çıkar</a>
                    <% } %>
                    
                    
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" role="dialog">
                              <div class="modal-dialog">
                                  <form action="Actions/toBlackList.jsp?type=0" method="post">
                                      <input type="hidden" name="userId" value="<% out.print(user); %>">
                                      
                                <!-- Modal content-->
                                <div class="modal-content">
                                  <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title"><% out.print(obj.getString("fn")+" "+obj.getString("ln")+" Kara Listeye Alınsın mı?");%></h4>
                                  </div>
                                  <div class="modal-body">
                                    
                                        Açıklama:<br>
                                        <textarea class="form-control" name="commend" 
                                                  placeholder="Lütfen açıklamanızı Giriniz"
                                                  rows="6" style="resize: none;"></textarea>
                                  </div>
                                  <div class="modal-footer">
                                      <input type="submit" value="İşlemi Tamamla" class="btn btn-default">
                                  </div>
                                </div>
                                </form>


                              </div>                                 
                            </div>
                                  
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
                
                      
                      out.println("<div class=\"row\">\n"
                              + "<div class=\"col-sm-3\"><a href=\"editForms.jsp\">"
                              +mongo.getElement("advert", advertCode+"").getString("header")
                              +"</a></div>");
                      if(obj.isNull("blackList")){
                      %>
                      <div class="btn-group col-sm-3">
                      <a class="btn btn-xs btn<% out.print(status==1?"-warning":"-default"); %>" 
                         href="Actions/register.jsp?return=0&type=3&advertCode=<% out.print(advertCode); %>&id=<% out.print(user); %>&emailTo=<% out.print(emailTo); %>"
                        >İşleme Al</a>&nbsp;&nbsp;&nbsp;
                      <a class="btn btn-xs btn<% out.print(status==2?"-success":"-default"); %>" 
                         href="Actions/register.jsp?return=0&type=4&advertCode=<% out.print(advertCode); %>&id=<% out.print(user); %>&emailTo=<% out.print(emailTo); %>"
                        >Kabul Et</a>&nbsp;&nbsp;&nbsp;
                      <a class="btn btn-xs btn<% out.print(status==3?"-danger":"-default"); %>" 
                         href="Actions/register.jsp?return=0&type=5&advertCode=<% out.print(advertCode); %>&id=<% out.print(user); %>&emailTo=<% out.print(emailTo); %>"
                        >Reddet</a>&nbsp;&nbsp;&nbsp;
                      </div>
                 <% 
                     }
                      out.println("</div>\n</br>");
                }
                %>
                    
    </div>                 
</div> <!-- /container -->
 </body>
</html>
