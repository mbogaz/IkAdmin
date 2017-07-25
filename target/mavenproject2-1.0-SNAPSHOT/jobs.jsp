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
<html>

    <!-- BEGIN HEAD -->

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
        
        <meta charset="utf-8" />
        <title>IK Admin</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <link href="resource/css/tags.css" rel="stylesheet" >
        
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
                <div class="page-sidebar-wrapper">
                    <!-- BEGIN SIDEBAR -->
                    <div class="page-sidebar navbar-collapse collapse">
                        <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
                            <li class="nav-item start ">
                                        <a href="https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=86vvecy3ntqbft&scope=r_basicprofile%20r_emailaddress&redirect_uri=http://localhost:21222/mavenproject2/Actions/linkedinLogin.jsp?type=1" class="nav-link ">
                                            <i class="icon-bar-chart"></i>
                                            <span class="title">Linkedin ile Giriş Yap</span>
                                        </a>
                            </li>
                            <li class="nav-item start ">
                                        <a href="index.jsp" class="nav-link ">
                                            <i class="icon-bar-chart"></i>
                                            <span class="title">Çıkış</span>
                                        </a>
                            </li>
                            
                           
                        </ul>
                        <!-- END SIDEBAR MENU -->
                        <!-- END SIDEBAR MENU -->
                    </div>
                    <!-- END SIDEBAR -->
                </div>
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN VALIDATION STATES-->
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-settings font-dark"></i>
                                            <span class="caption-subject font-dark sbold uppercase">Aktif İlanlar</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        
                                       <table id="mytable" class="table table-bordred table-striped">
                   
                                                    <thead>

                                                     <th>İlan İsmi</th>
                                                     <th>Aktivasyon Tarihi</th>
                                                     <th>Kapanış Tarihi</th>
                                                     <th>Açıklama</th>

                                                    </thead>
                                     <tbody>

                                    <% 
                                        MongoDBJDBC mongo = new MongoDBJDBC();
                                        ArrayList<JSONObject> list = mongo.getList("advert");

                                        for(JSONObject obj:list){ 
                                             String activationTime = obj.getString("activationTime").replace("T", " ");
                                             String closeTime = obj.getString("closeTime").replace("T", " ");
                                             SimpleDateFormat formatter = new SimpleDateFormat("yyyy-dd-MM HH:mm");
                                             Date parsedDateA = formatter.parse(activationTime);
                                             Date parsedDateC = formatter.parse(closeTime);
                                             Date currDate = Calendar.getInstance().getTime(); 
                                             boolean showAdvert = (currDate.compareTo(parsedDateA)>=0) 
                                                     && (currDate.compareTo(parsedDateC)<0)
                                                     && obj.getBoolean("active");
                                             if(showAdvert){
                                    %>     
                                     <tr>
                                         <td><% out.println(obj.getString("header")); %></td>
                                         <td><% out.println(activationTime.replace(" ", "/")); %></td>
                                         <td><% out.println(closeTime.replace(" ", "/")); %></td>
                                         <td><% out.println(obj.getString("definition")); %></td>
                                     </tr>

                                     <%      } 
                                         } 
                                     %>




                                     </tbody>

                                 </table>
                                        
                                    </div>
                                    <!-- END VALIDATION STATES-->
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

</body>


</html>