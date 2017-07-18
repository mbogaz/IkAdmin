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
<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta name="robots" content="noindex">

    
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="resource/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="resource/css/signin.css" rel="stylesheet" >
    <style type="text/css">
    
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
    <jsp:include page="Views/navbarIk.jsp" />	

<div class="container">

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
    <%
    if(request.getParameter("search")!=null && !request.getParameter("search").isEmpty()){
        out.print("<h3>\"<span style=\"color:darkred;\">"+request.getParameter("search")+"</span>\" aramasının sonuçları:</h3>");
    }
    
    %>
    
    </br></br>

	<div class="row">
		
        
        <div class="col-md-12">
            
        <div class="table-responsive">

                
              <table id="mytable" class="table table-bordred table-striped">
                   
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
       ArrayList<JSONObject> list = mongo.getList("user");
       //h.sortArrayListByRelevance(list, skills);
       
       int i = 0;
       for(JSONObject obj:list){ 
           
   %>     
    <tr>
        <td><% out.println(obj.getString("fn")); %></td>
        <td><% out.println(obj.getString("ln")); %></td>
        <td><% out.println(obj.getString("emailAddress")); %></td>
        <td><% out.println(obj.getString("user")); %></td>
        <td><% out.println(obj.isNull("blackList")?"-":obj.getString("blackList")); %></td>
        <td><p data-placement="top" data-toggle="tooltip">
                <a href="userDetail.jsp?user=<%out.print(obj.getString("user"));%>" style="text-decoration:none;">
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
