<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    if ("POST".equalsIgnoreCase(request.getMethod())) { 
        MongoDBJDBC mongo = new MongoDBJDBC();
        request.setCharacterEncoding("UTF-8");
        String fn = request.getParameter("fn");
        String ln = request.getParameter("ln");
        String headline = request.getParameter("headline");
        String skills = request.getParameter("skills");
        mongo.updateUser(mongo.createDBOUser(session.getAttribute("id")+"", fn, ln, headline,skills));
        session.setAttribute("skills", skills);
        response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
        
    } else { 
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
     <jsp:include page="Views/navbarUser.jsp" />
<div class="container">
                <!-- Form Area -->
                <div class="form-signin" style="max-width: 1000px">
                    <!-- Form -->
                    <form method="post" action="userProfile.jsp">
                        <!-- Left Inputs -->
                        <div class="col-xs-6 wow animated slideInLeft" data-wow-delay=".5s">
                            İsim:<input type="text" name="fn" class="form" value="<% out.print(session.getAttribute("firstName")); %>" required/>
                            Soyisim:<input type="text" name="ln" class="form" value="<% out.print(session.getAttribute("lastName")); %>" required/>
                            Durum:<input type="text" name="headline" class="form" value="<% out.print(session.getAttribute("headline")); %>" required/>                           
                            
                            </div><!-- End Left Inputs -->
                        <!-- Right Inputs -->
                        <div class="col-xs-6 wow animated slideInRight" data-wow-delay=".5s">
                            
			<p><label>Kişisel Ve Profesyonel Özellikler</label>
                            <input class="form textarea" id="tags_2" name="skills" type="text" class="tags" value="<% out.print(session.getAttribute("skills")); %>" /></p>
                        </div><!-- End Right Inputs -->
                        <!-- Bottom Submit -->
                        <div class="relative fullwidth col-xs-12">
                            <!-- Send Button -->
                            <button type="submit" id="submit" name="submit" class="form-btn semibold">Oluştur</button> 
                        </div><!-- End Bottom Submit -->
                        <!-- Clear -->
                        <div class="clear"></div>
                    </form>

                    <!-- Your Mail Message -->
                    <div class="mail-message-area">
                        <!-- Message -->
                        <div class="alert gray-bg mail-message not-visible-message">
                            <strong>Thank You !</strong> Your email has been delivered.
                        </div>
                    </div>

                </div><!-- End Contact Form Area -->
</div> <!-- /container -->
 </body>
</html>
