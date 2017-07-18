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
 <jsp:include page="Views/navbarUser.jsp" />	

<div class="container">
	<div class="row">
		
        
        <div class="col-md-12">
            
        <div class="table-responsive">

                
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
       boolean blackList = !mongo.getElement("user", session.getAttribute("id")+"").getString("blackList").equals("");

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
        <td><p data-placement="top" data-toggle="tooltip">
                
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
                    <button class="btn btn-success btn-xs">Başvur</button></p>
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

<div class="clearfix"></div>

            </div>
            
        </div>
	</div>
</div>


<div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">Edit Your Detail</h4>
      </div>
          <div class="modal-body">
          <div class="form-group">
        <input class="form-control " type="text" placeholder="Mohsin">
        </div>
        <div class="form-group">
        
        <input class="form-control " type="text" placeholder="Irshad">
        </div>
        <div class="form-group">
        <textarea rows="2" class="form-control" placeholder="CB 106/107 Street # 11 Wah Cantt Islamabad Pakistan"></textarea>
    
        
        </div>
      </div>
          <div class="modal-footer ">
        <button type="button" class="btn btn-warning btn-lg" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span> Update</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
    </div>
    
    
    
    <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
      </div>
          <div class="modal-body">
       
       <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
       
      </div>
        <div class="modal-footer ">
        <button type="button" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span> Yes</button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
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
