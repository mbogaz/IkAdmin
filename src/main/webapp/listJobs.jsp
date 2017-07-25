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
    if(session.getAttribute("id")==null){
        response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
    }
%>
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

                                                         <th onclick="sortTable(0)">İlan İsmi</th>
                                                         <th >İstenilen Özellikler</th>
                                                         <th onclick="sortTable(2)">Kapanış Tarihi</th>
                                                         <th>Kodu</th>
                                                         <th>Eylemler</th>

                                                        </thead>
                                         <tbody>

                                        <% 
                                            MongoDBJDBC mongo = new MongoDBJDBC();
                                            final Helper h = new Helper();
                                            final String skills = session.getAttribute("skills")+"";
                                            //out.print(session.getAttribute("skills"));
                                            ArrayList<JSONObject> list = mongo.getList("advert");
                                            h.sortArrayListByRelevance(list, skills);
                                            boolean blackList = !mongo.getElement("user", session.getAttribute("id")+"").isNull("blackList");

                                            int i = 0;
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
                                                 if(obj.getBoolean("active")){
                                                     String userId = session.getAttribute("id")+"";
                                                     int advertCode = obj.getInt("advert");
                                                     int isRegistered = mongo.isUserRegistered(userId, advertCode);

                                        %>     
                                         <tr>
                                             <td><% out.println(obj.getString("header")); %></td>
                                             <td><% out.println(obj.getString("requirements")); %></td>
                                             <td><% out.println(closeTime.replace(" ", "/")); %></td>
                                             <td><% out.println(obj.getInt("advert")); %></td>
                                             <td>

                                                     <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#myModal<%out.print(i);%>">Detayları Gör</button>

                                                     <%if(isRegistered!=-1 || blackList) {%>
                                                     <span style="color:crimson;"><%
                                                         switch(isRegistered){
                                                             case 0: out.print("Başvuruldu");break;
                                                             case 1: out.print("İşleme Alındı");break;
                                                             case 2: out.print("Kabul Edildi");break;
                                                             case 3: out.print("Reddedildi");break;
                                                         }
                                                     %></span>
                                                     <% }else{ %>
                                                     <a href="Actions/register.jsp?type=1&advertCode=<%out.print(advertCode);%>">
                                                         <button class="btn btn-success btn-xs">Başvur</button>
                                                     </a>
                                                     <% } %>    

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


                                                     <% i++;  %>


                                             </td>
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



<!-- Mirrored from keenthemes.com/preview/metronic/theme/admin_1/form_validation.html by HTTrack Website Copier/3.x [XR&CO'2013], Tue, 25 Jul 2017 07:22:32 GMT -->
</html>