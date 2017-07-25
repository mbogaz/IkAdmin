<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    if(session.getAttribute("userName")==null){
        response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
    }
    MongoDBJDBC mongo = new MongoDBJDBC();

    String user = request.getParameter("user");
    JSONObject obj = mongo.getElement("user", user);
    if(obj==null){
        response.sendRedirect(request.getContextPath() + "createForm.jsp");
    }
%> 
<!DOCTYPE html>
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    
<!-- Mirrored from keenthemes.com/preview/metronic/theme/admin_1/page_user_profile_1_account.html by HTTrack Website Copier/3.x [XR&CO'2013], Tue, 25 Jul 2017 07:23:19 GMT -->
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
<head>
        <meta charset="utf-8" />
        <title>IK Admin</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <link href="http://keenthemes.com/preview/metronic/theme/assets/pages/css/profile.min.css" rel="stylesheet" type="text/css" />
        <jsp:include page="Views/imports.jsp" />
        
        
        
</head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-content-white">
        <div class="page-wrapper">
            <!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <!-- BEGIN HEADER INNER -->
                <div class="page-header-inner ">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <p style="color:white">IK ADMIN</p>
                    </div>
                    <!-- END LOGO -->
                    <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                    <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                        <span></span>
                    </a>
                    <!-- END RESPONSIVE MENU TOGGLER -->

                </div>
                <!-- END HEADER INNER -->
            </div>
            <!-- END HEADER -->
            <!-- BEGIN HEADER & CONTENT DIVIDER -->
            <div class="clearfix"> </div>
            <!-- END HEADER & CONTENT DIVIDER -->
            <!-- BEGIN CONTAINER -->
            <div class="page-container">
                <jsp:include page="Views/sidebarIk.jsp" />
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <!-- BEGIN PAGE HEADER-->
                        <!-- BEGIN PAGE TITLE-->
                        <h1 class="page-title"> Aday Profili
                        </h1>
                        <!-- END PAGE TITLE-->
                        <!-- END PAGE HEADER-->
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PROFILE SIDEBAR -->
                                <div class="profile-sidebar">
                                    <!-- PORTLET MAIN -->
                                    <div class="portlet light profile-sidebar-portlet">
                                        <!-- SIDEBAR USERPIC -->
                                        <div class="profile-userpic">
                                            <img src="<% out.println(obj.getString("pictureUrl")); %>" class="img-responsive" alt=""> </div>
                                        <!-- END SIDEBAR USERPIC -->
                                        <!-- SIDEBAR USER TITLE -->
                                        <div class="profile-usertitle">
                                            <div class="profile-usertitle-name"> <% out.print(obj.getString("fn")+" "+obj.getString("ln"));%> </div>
                                            <div class="profile-usertitle-job"> <% out.print(obj.getString("headline"));%> </div>
                                        </div>
                                        <!-- END SIDEBAR USER TITLE -->
                                        <% if(!obj.isNull("blackList")){%>
                                        <!-- SIDEBAR BUTTONS -->
                                        <div class="note note-danger">
                                            <p> <% out.print(obj.getString("blackList")); %> </p>
                                        </div>
                                        <!-- END SIDEBAR BUTTONS -->
                                        <% } %>
                                        <!-- SIDEBAR MENU -->
                                        <div class="profile-usermenu">
                                        </div>
                                        <!-- END MENU -->
                                    </div>
                                    <!-- END PORTLET MAIN -->
                                </div>
                                <!-- END BEGIN PROFILE SIDEBAR -->
                                <!-- BEGIN PROFILE CONTENT -->
                                <div class="profile-content">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="portlet light ">
                                                <% if(obj.isNull("blackList")){%>
                                                    <a data-toggle="modal" data-target="#myModal" href="#" class="btn btn-danger btn-block">Kara Listeye Al !</a>
                                                <% } else {%>
                                                    <a href="Actions/toBlackList.jsp?type=1&userId=<% out.print(user); %>" class="btn btn-danger btn-block">Kara Listeden Çıkar !</a>
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
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="portlet light ">
                                                <div class="portlet-title tabbable-line">
                                                    <div class="caption caption-md">
                                                        <i class="icon-globe theme-font hide"></i>
                                                        <span class="caption-subject font-blue-madison bold uppercase">Bilgiler</span>
                                                    </div>
                                                </div>
                                                <div class="portlet-body">
                                                    <div class="tab-content">
                                                        <!-- PERSONAL INFO TAB -->
                                                        <div class="tab-pane active" id="tab_1_1">
                                                            <p><label>Kişisel Ve Profesyonel Özellikler:&nbsp;<% out.print(obj.getString("skills")); %></label></p>
                                                            <p><label>Durum:&nbsp;<% out.print(obj.getString("headline")); %></label></p>
                                                            <p><label>Lokasyon:&nbsp;<% out.print(obj.getString("location")); %></label></p>
                                                            <p><label>E mail:&nbsp;<% out.print(obj.getString("emailAddress")); %></label></p>   
                                                        </div>
                                                        <!-- END PERSONAL INFO TAB -->
                                              
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="portlet light ">
                                                <div class="portlet-title tabbable-line">
                                                    <div class="caption caption-md">
                                                        <i class="icon-globe theme-font hide"></i>
                                                        <span class="caption-subject font-blue-madison bold uppercase">Tüm Başvuruları</span>
                                                    </div>
                                                </div>
                                                
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
                                                        <div class="btn-group col-sm-6">
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
                                        </div>
                                    </div>
                                </div>
                                <!-- END PROFILE CONTENT -->
                            </div>
                        </div>
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
                <!-- END CONTENT -->
            </div>
            <!-- END CONTAINER -->
            <jsp:include page="Views/footer.jsp" />
        </div>


       

<!-- End -->
</body>


</html>