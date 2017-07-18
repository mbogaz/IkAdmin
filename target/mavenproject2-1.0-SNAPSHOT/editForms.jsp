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
    <link href="resource/css/accordion.css" rel="stylesheet" >
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
            
            
            
            
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">


<%  MongoDBJDBC mongo = new MongoDBJDBC();
       Helper h = new Helper();
       ArrayList<JSONObject> list = mongo.getList("advert");
       h.sortArrayListById(list);
       int i = 0;
       for(JSONObject obj:list){ 
        int advertCode = obj.getInt("advert");
%>
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="heading<% out.print(i);%>">
                <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<% out.print(i);%>" aria-expanded="true" aria-controls="collapse<% out.print(i);%>">
                        <i class="more-less glyphicon glyphicon-plus">Başvuruları Göster</i>
                        <% out.println(obj.getString("header")); %>
                    </a>
                </h4>
            </div>
            <div id="collapse<% out.print(i);%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<% out.print(i);%>">
                <div class="panel-body">
                   
                        <%
                            
                            ArrayList<JSONObject> subList = mongo.getRegistersByAdvertCode(advertCode);
                            for(JSONObject subObj:subList){
                                int status = subObj.getInt("status");
                                String user = subObj.getString("userId");
                                JSONObject userObj = mongo.getElement("user",user );
                                String emailTo = userObj.getString("emailAddress");
                                String fn = userObj.getString("fn");
                                String ln = userObj.getString("ln");
                                if(!userObj.isNull("blackList")){
                                    
                        %>     
                        <div class="row">
                            <span class="col-sm-2"><% out.print(fn+" "+ln); %></span>
                            <a href="userDetail.jsp?user=<%out.print(user);%>" class="col-sm-1" style="text-decoration:none;">
                                    <button class="btn btn-primary btn-xs">Detay</button></a> 
                            <span class="col-sm-3" style="color:red;"> KARA LİSTEDE</span>
                        </div>
                                    </br>
                        <%
                            continue;
                                }
                        %>
                        <div class="row">
                               <span class="col-sm-2"><% out.print(fn+" "+ln); %></span>
                                <a href="userDetail.jsp?user=<%out.print(user);%>" class="col-sm-1" style="text-decoration:none;">
                                    <button class="btn btn-primary btn-xs">Detay</button></a> 
                                <div class="btn-group col-sm-3">
                                     <a class="btn btn-xs btn<% out.print(status==1?"-warning":"-default");%>"
                              href="Actions/register.jsp?return=1&type=3&advertCode=<%out.print(advertCode);%>&id=<%out.print(user);%>&emailTo=<%out.print(emailTo);%>">İşleme Al</a>&nbsp;&nbsp;&nbsp;
                              <a class="btn btn-xs btn<% out.print(status==2?"-success":"-default");%>"
                              href="Actions/register.jsp?return=1&type=3&advertCode=<%out.print(advertCode);%>&id=<%out.print(user);%>&emailTo=<%out.print(emailTo);%>">Kabul Et</a>&nbsp;&nbsp;&nbsp;
                              <a class="btn btn-xs btn<% out.print(status==3?"-danger":"-default");%>"
                              href="Actions/register.jsp?return=1&type=3&advertCode=<%out.print(advertCode);%>&id=<%out.print(user);%>&emailTo=<%out.print(emailTo);%>">Reddet</a>
                                    </div>
                        </div>    
                                    </br>
                            
                            
                          <% } %>
                     
                </div>
                <div class="panel-footer" style="background-color: #333333;">
                    <a href="editForm.jsp?advert=<% out.println(obj.getInt("advert")); %>" style=" color: blanchedalmond;text-decoration: none;">İlanı Düzenle</a>
                </div>
                

            </div>
        </div>

<% i++;} %>
    </div><!-- panel-group -->

        </div>
	</div>
</div>


</body>
</html>
