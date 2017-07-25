<%@page import="service.MongoDBJDBC"%>
<%@page import="org.json.JSONObject"%>
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
<%
        if(session.getAttribute("userName")==null){
            response.sendRedirect(request.getContextPath() + "/Actions/logout.jsp");
        }
        String header="",definition="",requirements="",activationTime="",closeTime="";
        int advertId=0;
        boolean active=false;
        MongoDBJDBC mongo = new MongoDBJDBC();
        request.setCharacterEncoding("UTF-8");
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("use").equals("post")) { //post işlemi yapılmış
            advertId = Integer.parseInt(request.getParameter("advertId"));
            header = request.getParameter("header");
            definition = request.getParameter("definition");
            requirements = request.getParameter("skills");
            activationTime = request.getParameter("activationTime");
            closeTime = request.getParameter("closeTime");
            active = (request.getParameter("isActive")!=null && request.getParameter("isActive").equals("on")) ? true : false;
            mongo.updateAdvert(mongo.createDBOAdvert(advertId, header, definition, requirements, activationTime, closeTime, active));
            response.sendRedirect(request.getContextPath() + "/editForms.jsp");
        }else{
            advertId = Integer.parseInt(request.getParameter("advert"));
            JSONObject obj = mongo.getElement("advert", advertId+"");
            if(obj==null)
               response.sendRedirect(request.getContextPath() + "/createForm.jsp");
            header = obj.getString("header");
            definition = obj.getString("definition");
            requirements = obj.getString("requirements");
            activationTime = obj.getString("activationTime");
            closeTime = obj.getString("closeTime");
            active = obj.getBoolean("active");
        }
    %>
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
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-settings font-dark"></i>
                                            <span class="caption-subject font-dark sbold uppercase">İlan Oluştur</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <!-- BEGIN FORM-->
                                        <form action="editForm.jsp?use=post" class="form-horizontal" method="post">
                                            <div class="form-body">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">İlan Kodu
                                                        <span class="required"> * </span>
                                                    </label>
                                                    <div class="col-md-4">
                                                        <input type="text" value="<% out.print(advertId+""); %>" name="code" data-required="1" class="form-control" readonly/> </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">Başlık
                                                        <span class="required"> * </span>
                                                    </label>
                                                    <div class="col-md-4">
                                                        <input type="text" name="header" data-required="1" value="<% out.print(header); %>" class="form-control" required/> </div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <label class="control-label col-md-3">Aktivasyon Zamanı:
                                                        <span class="required"> * </span>
                                                    </label>
                                                    <div class="col-md-4">
                                                        <div class="input-group date " data-date-format="dd-mm-yyyy">
                                                            <input id="timeActive" value="<% out.print(activationTime); %>" type="datetime-local" class="form-control" name="activationTime" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <label class="control-label col-md-3">Kapanma Zamanı:
                                                        <span class="required"> * </span>
                                                    </label>
                                                    <div class="col-md-4">
                                                        <div class="input-group date " data-date-format="dd-mm-yyyy">
                                                            <input id="timeClose" value="<% out.print(closeTime); %>" type="datetime-local" class="form-control" name="closeTime" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">İlan aktif mi?</label>
                                                    <div class="col-md-4">
                                                        <div class="mt-checkbox-list" data-error-container="#form_2_services_error">
                                                            <label class="mt-checkbox">
                                                                <input type="checkbox" <% if(active)out.print("checked"); %> name="isActive" checked/> 
                                                                <span></span>
                                                            </label>
                                                        </div>
                                                        <div id="form_2_services_error"> </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">İş Tanımı
                                                    </label>
                                                    <div class="col-md-9">
                                                        <textarea class="wysihtml5 form-control" rows="6" name="definition" data-error-container="#editor1_error">
                                                            <% out.print(definition); %>
                                                        </textarea>
                                                        <div id="editor1_error"> </div>
                                                    </div>
                                                </div>
                                                <div class="form-group last">
                                                    <label class="control-label col-md-3">Adayda Bulunması Beklenen Kişisel Ve Profesyonel Özellikler
                                                    </label>
                                                    <div class="col-md-9">
                                                        <input class="form textarea tags" id="tags_2" name="skills" rows="6" value="<% out.print(requirements); %>" data-error-container="#editor2_error"></textarea>
                                                        <div id="editor2_error"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <div class="row">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button type="submit" class="btn green">Güncelle</button>
                                                    </div>
                                                </div>
                                            </div>
                                                         <input type="hidden" name="advertId" value="<% out.print(advertId); %>">
                                        </form>
                                        <!-- END FORM-->
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
                   var d = new Date() ; 
                   var time = d.getFullYear()+"-"+("0" + (d.getMonth()+1)).slice(-2)+"-"+("0" + d.getDate()).slice(-2)+"T"+("0" + d.getHours()).slice(-2)+":"+("0" + d.getMinutes()).slice(-2);
                   var time2 = d.getFullYear()+"-"+("0" + (d.getMonth()+2)).slice(-2)+"-"+("0" + d.getDate()).slice(-2)+"T"+("0" + d.getHours()).slice(-2)+":"+("0" + d.getMinutes()).slice(-2);
                   document.getElementById("timeActive").setAttribute("min", time);
                   document.getElementById("timeActive").setAttribute("value", time);
                   document.getElementById("timeClose").setAttribute("min", time);
                   document.getElementById("timeClose").setAttribute("value", time2);
                </script>
</body>



<!-- Mirrored from keenthemes.com/preview/metronic/theme/admin_1/form_validation.html by HTTrack Website Copier/3.x [XR&CO'2013], Tue, 25 Jul 2017 07:22:32 GMT -->
</html>
