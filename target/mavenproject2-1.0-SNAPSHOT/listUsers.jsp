<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="com.mycompany.mavenproject2.Helper"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
 if(session.getAttribute("userName")==null){
        response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
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
        
        <jsp:include page="Views/imports.jsp" />
</head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
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
                        <h1 class="page-title"> Tüm Adaylar </h1>
                        <!-- END PAGE TITLE-->
                        <!-- END PAGE HEADER-->
                        <div class="row">
                            
                            <div id="custom-search-input">
                                <form method="post" class="input-group col-md-6 col-lg-offset-3" action="listUsers.jsp">
                                                 <input type="text" name="search" class="  search-query form-control" placeholder="Aramak istediğiniz kelimeyi giriniz" />
                                                 <span class="input-group-btn">
                                                     <button class="btn btn-danger" type="submit">
                                                         <span class=" glyphicon glyphicon-search"></span>
                                                     </button>
                                                     <a href="" class="btn btn-primary">
                                                         <span class=" glyphicon glyphicon-refresh"></span>
                                                     </a>
                                                 </span>
                                             </form>
                             </div>
                        </div>    
                        
                             <%
                                boolean isSearch = false;
                                ArrayList<JSONObject> searchList = null;
                                String search = request.getParameter("search");
                            if(search!=null && !search.isEmpty()){
                                out.print("<h3>\"<span style=\"color:darkred;\">"+search+"</span>\" aramasının sonuçları:</h3>");
                                MongoDBJDBC mongo = new MongoDBJDBC();
                                searchList = mongo.freeTextSearch(search);
                                isSearch = true;
                            }

                            %>

                            </br></br>

                <div class="row">


                    <div class="col-md-12">

                              
                        <div class="portlet light portlet-fit bordered">
                        <div class="portlet-body">            
                        <div class="table-scrollable table-scrollable-borderless">
                        <table id="mytable" class="table table-hover table-light">

                                           <thead>

                                            <th style="cursor: s-resize;" onclick="sortTable(0)">İsim</th>
                                            <th style="cursor: s-resize;" onclick="sortTable(1)">Soy İsim</th>
                                            <th>email</th>
                                            <th>Kodu</th>
                                            <th>Kara Liste Durumu</th>
                                            <th>Eylemler</th>

                                           </thead>
                            <tbody>

                           <% 
                               MongoDBJDBC mongo = new MongoDBJDBC();
                               final Helper h = new Helper();
                               //out.print(session.getAttribute("skills"));
                               ArrayList<JSONObject> list = isSearch?searchList:mongo.getList("user");
                               //h.sortArrayListByRelevance(list, skills);

                               int i = 0;
                               for(JSONObject obj:list){ 
                                   /*if(isSearch)
                                   obj = new JSONObject(obj.toString().replaceAll("(?i)"+search, "<strong>"+search+"</strong>"));*/
                           %>     
                            <tr>
                                <td><% out.println(obj.getString("fn")); %></td>
                                <td><% out.println(obj.getString("ln")); %></td>
                                <td><% out.println(obj.getString("emailAddress")); %></td>
                                <td><% out.println(obj.getString("user")); %></td>
                                <td><% out.println(obj.isNull("blackList")?"-":obj.getString("blackList")); %></td>
                                <td>
                                        <a href="userDetail.jsp?user=<%out.print(obj.getString("user"));%>" >
                                        <button type="button" class="btn btn-info btn-xs">Detayları Gör</button>
                                        </a>
                                </td>
                            </tr>

                            <%      
                                } 
                            %>




                            </tbody>

                        </table>
                        </div>  
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