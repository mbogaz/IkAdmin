<%@page import="com.mycompany.mavenproject2.Helper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
if(session.getAttribute("userName")==null){
        response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
    }
%>

<html>

    <!-- BEGIN HEAD -->

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
        <link href="resource/css/signin.css" rel="stylesheet" >
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
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN VALIDATION STATES-->
                                <div class="portlet light profile-sidebar-portlet">
                                    <!-- BEGIN PAGE TITLE-->
                                    <h1 class="page-title"> Tüm İlanlar </h1>
                                    <!-- END PAGE TITLE-->

                                        
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">


<%  MongoDBJDBC mongo = new MongoDBJDBC();
       Helper h = new Helper();
       ArrayList<JSONObject> list = mongo.getList("advert");
       h.sortArrayListById(list);
       int i = 0;
       for(JSONObject obj:list){ 
        int advertCode = obj.getInt("advert");
        String requirements = obj.getString("requirements");
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
                    <div class="text-center"> 
                        <div class="btn-group row">
                            <div class="col-xs-2">
                        <input class="form-control input-sm" type="text" id="searchInput<% out.print(i);%>" onkeyup="search(<% out.print(i);%>)" 
                               placeholder="Ara..">
                            </div>
                        <button type="button" data-filter="filt0" class="btn btn-default btn-sm filter-button">
                            Hepsi
                        </button>
                        <button type="button" data-filter="filt1" class="btn btn-default btn-sm filter-button">
                            Yanıtlanmamışlar
                        </button> 
                        <button type="button" data-filter="filt2" class="btn btn-default btn-sm filter-button">
                            İşleme Alınanlar
                        </button> 
                        <button type="button" data-filter="filt3" class="btn btn-default btn-sm filter-button">
                            Kabul Edilenler
                        </button>     
                        <button type="button" data-filter="filt4" class="btn btn-default btn-sm filter-button">
                            Reddedilenler
                        </button> 
                        <button type="button" data-filter="filt5" class="btn btn-default btn-sm filter-button">
                            Kara Listedekiler
                        </button> 
                        </div>
                    </div>
                            
                    </br>
                    <div id="items<%out.print(i);%>">
                        <%
                            
                            ArrayList<JSONObject> subList = mongo.getRegistersByAdvertCode(advertCode);
                            int innerCount = 0;
                            h.sortArrayListByRelevance(subList, requirements);
                            for(JSONObject subObj:subList){
                                innerCount++;
                                int status = subObj.getInt("status");
                                String user = subObj.getString("userId");
                                JSONObject userObj = mongo.getElement("user",user );
                                String emailTo = userObj.getString("emailAddress");
                                String fn = userObj.getString("fn");
                                String ln = userObj.getString("ln");
                                if(!userObj.isNull("blackList")){
                                   
                        %>     
                            <div class="row filter filt5">
                            <span id="searchSpan" class="col-sm-2 span<%out.print(i+"_"+innerCount);%>"><% out.print(fn+" "+ln); %></span>
                            <a href="userDetail.jsp?user=<%out.print(user);%>" class="col-sm-1" style="text-decoration:none;">
                                    <button class="btn btn-primary btn-xs">Detay</button></a> 
                            <span class="col-sm-3" style="color:red;"> KARA LİSTEDE</span>
                                </br></br>
                            </div>
                                    
                        <%
                            continue;
                                }
                        %>
                        <div class="row filter filt<%out.print(status+1);%>">
                               <span id="searchSpan" class="col-sm-2 span<%out.print(i+"_"+innerCount);%>"><% out.print(fn+" "+ln); %></span>
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
                                </br></br>
                        </div>    
                                    
                            
                            
                          <% } %>
                    </div> 
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
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
                <!-- END CONTENT -->
            </div>
            <!-- END CONTAINER -->
            <jsp:include page="Views/footer.jsp" />
        </div>
        
        <script>
function search(index) {
  input = document.getElementById("searchInput"+index);
  filter = input.value.toUpperCase();
  divId = "items"+index;
  var searchEles = document.getElementById(divId).children;
  for (var i = 0; i < searchEles.length; i++) {
     

    var name = "span"+index+"_"+(i+1);
    spann = document.getElementsByClassName(name)[0];
    if (spann) {
      if (spann.innerHTML.toUpperCase().indexOf(filter) > -1) {
        searchEles[i].style.display = "block";
      } else {
        searchEles[i].style.display = "none";
      }
    }       
  }
}
</script>
<script>
$(document).ready(function(){

    $(".filter-button").click(function(){
        var value = $(this).attr('data-filter');
        
        if(value == "filt0")
        {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else
        {
//            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
//            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
            
        }
    });
    
    if ($(".filter-button").removeClass("active")) {
$(this).removeClass("active");
}
$(this).addClass("active");

});
</script>
        <!-- END THEME LAYOUT SCRIPTS -->

</body>



<!-- Mirrored from keenthemes.com/preview/metronic/theme/admin_1/form_validation.html by HTTrack Website Copier/3.x [XR&CO'2013], Tue, 25 Jul 2017 07:22:32 GMT -->
</html>