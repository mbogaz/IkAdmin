<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    if(session.getAttribute("id")==null){
        response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
    }
    MongoDBJDBC mongo = new MongoDBJDBC();
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        String fn = request.getParameter("fn");
        String ln = request.getParameter("ln");
        String headline = request.getParameter("headline");
        String skills = request.getParameter("skills");
        String location = request.getParameter("location");
        String emailAddress = request.getParameter("emailAddress");
        String blackList = request.getParameter("blackList");
        mongo.updateUser(mongo.createDBOUser(session.getAttribute("id")+"", fn, ln,
                headline,skills,location,session.getAttribute("pictureUrl")+"",emailAddress,blackList));
        session.setAttribute("firstName", fn);
        session.setAttribute("lastName", ln);
        session.setAttribute("headline", headline);
        session.setAttribute("location", location);
        session.setAttribute("emailAddress", emailAddress);
        session.setAttribute("blackList", blackList);
        session.setAttribute("skills", skills);
        response.sendRedirect(request.getContextPath() + "/userProfile.jsp");
        
    } else { 
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
        <link href="resource/css/tags.css" rel="stylesheet" >
        <link href="http://keenthemes.com/preview/metronic/theme/assets/pages/css/profile.min.css" rel="stylesheet" type="text/css" />
        <jsp:include page="Views/imports.jsp" />
</head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-content-white">
        <div class="page-wrapper">
            <!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <jsp:include page="Views/navbarUser.jsp" />
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
                <jsp:include page="Views/sidebarUser.jsp" />
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                        
                     <div class="page-content">
                        <h1 class="page-title"> Profil
                        </h1>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PROFILE SIDEBAR -->
                                <div class="profile-sidebar">
                                    <!-- PORTLET MAIN -->
                                    <div class="portlet light profile-sidebar-portlet">
                                        <!-- SIDEBAR USERPIC -->
                                        <div class="profile-userpic">
                                            <img src="<% out.println(session.getAttribute("pictureUrl")); %>" class="img-responsive" alt=""> </div>
                                        <!-- END SIDEBAR USERPIC -->
                                        <!-- SIDEBAR USER TITLE -->
                                        <div class="profile-usertitle">
                                            <div class="profile-usertitle-name"> <% out.print(session.getAttribute("firstName")+" "+session.getAttribute("lastName"));%> </div>
                                            <div class="profile-usertitle-job"> <% out.print(session.getAttribute("headline"));%> </div>
                                        </div>
                                        
                                        <!-- SIDEBAR MENU -->
                                        <div class="profile-usermenu">
                                        </div>
                                        <!-- END MENU -->
                                    </div>
                                </div>
                                <!-- END BEGIN PROFILE SIDEBAR -->
                                <!-- BEGIN PROFILE CONTENT -->
                                <div class="profile-content">
                                    <div class="row">
                                        <div class="col-md-12">
                                            
                                            <div class="portlet light ">
                                                <div class="portlet-title tabbable-line">
                                                    <div class="caption caption-md">
                                                        <i class="icon-globe theme-font hide"></i>
                                                        <span class="caption-subject font-blue-madison bold uppercase">Bilgileri Güncelle</span>
                                                    </div>
                                                </div>
                                                <div class="portlet-body">
                                                    <div class="tab-content">
                                                        <div class="tab-pane active" id="tab_1_1">
                                                            <form method="post" action="userProfile.jsp">
                                                                <div class="form-group">
                                                                    <label class="control-label">İsim</label>
                                                                    <input name="fn" type="text" value="<% out.print(session.getAttribute("firstName")); %>" class="form-control"> </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">Soyisim</label>
                                                                    <input name="ln" type="text" value="<% out.print(session.getAttribute("lastName")); %>" class="form-control"> </div>
                                                                <div class="form-group">
                                                                    <label class="control-label">Durum</label>
                                                                    <input name="headline" type="text" value="<% out.print(session.getAttribute("headline")); %>" class="form-control"> </div>
                                                                    <div class="form-group">
                                                                    <label class="control-label">Lokasyon</label>
                                                                    <input name="location" type="text" value="<% out.print(session.getAttribute("location")); %>" class="form-control"> </div>
                                                                    <div class="form-group">
                                                                    <label class="control-label">Email Adresi</label>
                                                                    <input name="emailAddress" type="text" value="<% out.print(session.getAttribute("emailAddress")); %>" class="form-control"> </div>
                                                                    <div class="form-group">
                                                                    <label class="control-label">Yetenekler</label>
                                                                        <input class="form textarea tags" value="<% out.print(session.getAttribute("skills")); %>" id="tags_2" name="skills" rows="6" data-error-container="#editor2_error"></textarea>
                                                                        <div id="editor2_error"> </div>
                                                                    </div>
                                                                <div class="margiv-top-10">
                                                                    <input type="submit" class="btn green" value="Kaydet" />  
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <!-- END PERSONAL INFO TAB -->
                                                    </div>
                                                </div>
                                            </div>      
                                                                        
                                            <div class="portlet light ">
                                                <div class="portlet-title tabbable-line">
                                                    <div class="caption caption-md">
                                                        <i class="icon-globe theme-font hide"></i>
                                                        <span class="caption-subject font-blue-madison bold uppercase">Başvurulan İlanlar</span>
                                                    </div>
                                                </div>
                                                <div class="portlet-body">
                                                    <div class="tab-content">
                                                       <%
                                                        ArrayList<JSONObject> registerList = mongo.getRegistersByUserId(session.getAttribute("id")+"");
                                                        int i = 0;
                                                        for(JSONObject registerObj:registerList){
                                                            int status = registerObj.getInt("status");
                                                            int advertCode = registerObj.getInt("advertCode");
                                                            String emailTo = session.getAttribute("emailAddress")+"";
                                                            int isRegistered = mongo.isUserRegistered(session.getAttribute("id")+"", advertCode);
                                                            JSONObject obj = mongo.getElement("advert", advertCode+"");
                                                            %>
                                                            <div class="row">
                                                                    <div class="col-sm-3" data-toggle="modal" data-target="#myModal<%out.print(i);%>">
                                                                    <% out.println(obj.getString("header")); %>
                                                                    </div>
                                                                    <!-- Modal -->
                                                                    <div id="myModal<%out.print(i);%>" class="modal fade" role="dialog">
                                                                      <div class="modal-dialog">

                                                                        <!-- Modal content-->
                                                                        <div class="modal-content">
                                                                          <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title"><% out.println(obj.getString("header")); %></h4>
                                                                          </div>
                                                                          <div class="modal-body">
                                                                            <p>İş Tanımı:<% out.println(obj.getString("definition")); %></p>
                                                                            </br></br>
                                                                            <p>Adayda Bulunması Beklenen Özellikler:<% out.println(obj.getString("requirements")); %></p>
                                                                          </div>
                                                                          <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                                                                          </div>
                                                                        </div>

                                                                      </div>
                                                                    </div> 
                                                            
                                                         <span style="color:crimson;"><%
                                                          switch(isRegistered){
                                                              case 0: out.print("Başvuruldu");break;
                                                              case 1: out.print("İşleme Alındı");break;
                                                              case 2: out.print("Kabul Edildi");break;
                                                              case 3: out.print("Reddedildi");break;
                                                          }
                                                      %></span>   
                                                       <%

                                                            out.println("</div>\n</br>");
                                                            i++;
                                                      }
                                                      %>
                                              
                                                    </div>
                                                </div>
                                            </div>                            
                                        </div>
                                    </div>
                                </div>
                                <!-- END PROFILE CONTENT -->
                            </div>
                        </div>
                    </div>    
                        
            <!-- END CONTAINER -->
            <jsp:include page="Views/footer.jsp" />
        </div>


        <script>
        function sortTable(n) {
          var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
          table = document.getElementById("mytable");
          switching = true;
          //Set the sorting direction to ascending:
          dir = "asc"; 
          /*Make a loop that will continue until
          no switching has been done:*/
          while (switching) {
            //start by saying: no switching is done:
            switching = false;
            rows = table.getElementsByTagName("TR");
            /*Loop through all table rows (except the
            first, which contains table headers):*/
            for (i = 1; i < (rows.length - 1); i++) {
              //start by saying there should be no switching:
              shouldSwitch = false;
              /*Get the two elements you want to compare,
              one from current row and one from the next:*/
              x = rows[i].getElementsByTagName("TD")[n];
              y = rows[i + 1].getElementsByTagName("TD")[n];
              /*check if the two rows should switch place,
              based on the direction, asc or desc:*/
              if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                  //if so, mark as a switch and break the loop:
                  shouldSwitch= true;
                  break;
                }
              } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                  //if so, mark as a switch and break the loop:
                  shouldSwitch= true;
                  break;
                }
              }
            }
            if (shouldSwitch) {
              /*If a switch has been marked, make the switch
              and mark that a switch has been done:*/
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
              //Each time a switch is done, increase this count by 1:
              switchcount ++; 
            } else {
              /*If no switching has been done AND the direction is "asc",
              set the direction to "desc" and run the while loop again.*/
              if (switchcount == 0 && dir == "asc") {
                dir = "desc";
                switching = true;
              }
            }
          }
        }
        </script>
        <!-- END THEME LAYOUT SCRIPTS -->

<!-- End -->
</body>


</html>