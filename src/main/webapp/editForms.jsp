<%@page import="com.mycompany.mavenproject2.Helper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
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
    <script type="text/javascript">
        window.alert = function(){};
        var defaultCSS = document.getElementById('bootstrap-css');
        function changeCSS(css){
            if(css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="'+ css +'" type="text/css" />'); 
            else $('head > link').filter(':first').replaceWith(defaultCSS); 
        }
    </script>
</head>
<body>
 <jsp:include page="Views/navbarIk.jsp" />	

<div class="container">
	<div class="row">
		
        
        <div class="col-md-12">
            
        <div class="table-responsive">

                
              <table id="mytable" class="table table-bordred table-striped">
                   
                   <thead>
                   
                    <th>İlan İsmi</th>
                    <th>Aktivasyon Tarihi</th>
                    <th>Kapanış Tarihi</th>
                    <th>Açıklama</th>
                    <th>Aktiflik Durumu</th>
                    <th>Düzenle</th>
                    
                   </thead>
    <tbody>
    
   <% 
       MongoDBJDBC mongo = new MongoDBJDBC();
       Helper h = new Helper();
       ArrayList<JSONObject> list = mongo.getList("advert");
       h.sortArrayListById(list);
       int i = 0;
       for(JSONObject obj:list){ 
        int advertCode = obj.getInt("advert");
   %>     
    <tr>
        <td><% out.println(obj.getString("header")); %></td>
        <td><% out.println(obj.getString("activationTime")); %></td>
        <td><% out.println(obj.getString("closeTime")); %></td>
        <td><% out.println(obj.getString("definition")); %></td>
        <td><% out.println(obj.getBoolean("active")==true?"Aktif":"Aktif Değil"); %></td>
        <td><p data-placement="top" data-toggle="tooltip">
                <button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#myModal<%out.print(i);%>">Başvurular</button>
                <a href="editForm.jsp?advert=<% out.println(obj.getInt("advert")); %>">
                <button class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" >Düzenle</button></p>
                </a>
                
                <!-- Modal -->
                <div id="myModal<%out.print(i);%>" class="modal fade" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><% out.println("Başvuru Yapanlar"); %></h4>
                      </div>
                      <div class="modal-body">
                        <p><%
                            
                            ArrayList<JSONObject> subList = mongo.getRegistersByAdvertCode(advertCode);
                            for(JSONObject subObj:subList){
                                JSONObject userObj = mongo.getElement("user", subObj.getString("userId"));
                                out.println(userObj.getString("fn")+"</br>");    
                            }
                            
                            
                            %></p>
                        </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                            </div>
                          </div>

                        </div>
                      </div> 

                
        </td>
    </tr>
    
    <% i++;} %>
   
    
   
    
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
	<script type="text/javascript">
	$(document).ready(function(){
$("#mytable #checkall").click(function () {
        if ($("#mytable #checkall").is(':checked')) {
            $("#mytable input[type=checkbox]").each(function () {
                $(this).prop("checked", true);
            });

        } else {
            $("#mytable input[type=checkbox]").each(function () {
                $(this).prop("checked", false);
            });
        }
    });
    
    $("[data-toggle=tooltip]").tooltip();
});

	</script>
</body>
</html>
