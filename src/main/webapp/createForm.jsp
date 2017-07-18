<%@page import="java.util.Date"%>
<%@page import="java.util.UUID"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    int uniqeId = 0;
    if ("POST".equalsIgnoreCase(request.getMethod())) { 
        MongoDBJDBC mongo = new MongoDBJDBC();
        request.setCharacterEncoding("UTF-8");
        int code = Integer.parseInt(request.getParameter("code"));
        String header = request.getParameter("header"); 
        String activationTime = request.getParameter("activationTime"); 
        String closeTime = request.getParameter("closeTime"); 
        boolean active =request.getParameter("isActive").equals("on") ? true : false; 
        String definition = request.getParameter("definition"); 
        String requirements = request.getParameter("skills"); 
        mongo.addItemToDB(mongo.createDBOAdvert(code, header, definition, requirements
                , activationTime, closeTime, active),1);
        response.sendRedirect(request.getContextPath() + "/editForms.jsp");
    } else { 
        uniqeId = (int) (new Date().getTime()/1000);
    }
%> 
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
<div class="container">
                <!-- Form Area -->
                <div class="form-signin" style="max-width: 1000px">
                    <!-- Form -->
                    <form method="post" action="createForm.jsp">
                        <!-- Left Inputs -->
                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            
                            <input type="number" name="code" class="form" placeholder="İlan Kodu" value="<%out.print(uniqeId);%>" readonly/>
                            <input type="text" name="header" class="form" placeholder="Başlık" required/>
                            Aktivasyon Zamanı: <input id="timeActive" type="datetime-local" name="activationTime" class="form" required/>                            
                            Kapanma Zamanı: <input id="timeClose" type="datetime-local" name="closeTime" class="form" required/>
                            <div class="form">
                                İlan Aktif mi: <input type="checkbox" name="isActive" checked data-toggle="toggle">
                            </div>
                            </div><!-- End Left Inputs -->
                        <!-- Right Inputs -->
                        <div class="col-xs-6 wow animated slideInRight" data-wow-delay=".5s">
                            <!-- Message -->
                            <textarea name="definition" class="form textarea"  placeholder="İş Tanımı" required></textarea>
                            
			<p><label>Adayda Bulunması Beklenen Kişisel Ve Profesyonel Özellikler</label>
                            <input class="form textarea" id="tags_2" name="skills" type="text" class="tags" value="" /></p>
                        </div><!-- End Right Inputs -->
                        <!-- Bottom Submit -->
                        <div class="relative fullwidth col-xs-12">
                            <!-- Send Button -->
                            <button type="submit" id="submit" name="submit" class="form-btn semibold">Oluştur</button> 
                        </div><!-- End Bottom Submit -->
                        <!-- Clear -->
                        <div class="clear"></div>
                    </form>


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
</div>
 </body>
</html>
