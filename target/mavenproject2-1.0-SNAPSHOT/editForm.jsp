<%@page import="service.MongoDBJDBC"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
     <link rel="stylesheet" href="resource/css/bootstrap.min.css">
     <link rel="stylesheet" href="resource/css/form.css">
     <link rel="stylesheet" href="resource/css/hastag.css">
     <link href="resource/css/signin.css" rel="stylesheet" >
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
     <script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js'></script>
     <script type="text/javascript" src="resource/js/hastag.js"></script>
     <script type="text/javascript" src="resource/js/jquery.tagsinput.js"></script>
  

 </head>
 <body>
    <jsp:include page="Views/navbarIk.jsp" />
    <%
        String header="",definition="",requirements="",activationTime="",closeTime="";
        int advertId=0;
        boolean active=false;
        MongoDBJDBC mongo = new MongoDBJDBC();
        request.setCharacterEncoding("UTF-8");
        if ("POST".equalsIgnoreCase(request.getMethod())&& request.getParameter("use").equals("post")) { //post işlemi yapılmış
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
<div class="container">
                <!-- Form Area -->
                <div class="form-signin" style="max-width: 1000px">
                    
                    
                    
                    <form id="form1" method="post" action="editForm.jsp?use=post">
                        
                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            
                            <input type="number" name="code" class="form" value="<% out.print(advertId+""); %>" placeholder="İlan Kodu" />
                            
                            <input type="text" name="header" class="form" value="<% out.print(header); %>" placeholder="Başlık" />
                            
                            Aktivasyon Zamanı: <input type="date" value="<% out.print(activationTime); %>" name="activationTime" class="form" />                            
                            
                            Kapanma Zamanı: <input type="date" value="<% out.print(closeTime); %>" name="closeTime" class="form" />
                            
                            <div class="form">
                                İlan Aktif mi: <input type="checkbox" name="isActive" data-toggle="toggle" <% if(active)out.print("checked"); %>>
                            </div>
                        
                        </div>
                        
                        <div class="col-xs-6 wow animated slideInRight" data-wow-delay=".5s">
                            
                        <textarea name="definition" class="form textarea" placeholder="İş Tanımı"><% out.print(definition); %></textarea>
                            
			<p><label>Adayda Bulunması Beklenen Kişisel Ve Profesyonel Özellikler</label>
			<input id="tags_2" name="skills" type="text" class="tags" value="<% out.print(requirements); %>" /></p>
                        
                        </div>
                        
                        <div class="relative fullwidth col-xs-12">
                            <button type="submit" id="submit" name="submit" class="form-btn semibold">Güncelle</button> 
                        </div>
                        <div class="clear"></div>
                        
                        <input type="hidden" name="advertId" value="<% out.print(advertId); %>">
                    </form>

                    

                </div><!-- End Contact Form Area -->
</div> <!-- /container -->
 </body>
</html>
