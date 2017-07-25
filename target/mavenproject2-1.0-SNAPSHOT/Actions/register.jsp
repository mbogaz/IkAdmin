<%@page import="service.MailService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    MongoDBJDBC mongo = new MongoDBJDBC();
    String userId = session.getAttribute("id") + "";
    String emailTo = request.getParameter("emailTo");
    String id = request.getParameter("id");
    int advertCode = Integer.parseInt(request.getParameter("advertCode"));
    int proc = Integer.parseInt(request.getParameter("type"));
    if (proc == 1) {//userın başvurması
        mongo.addItemToDB(mongo.createDBORegister(userId, advertCode, 0), 2);
        response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
    } else if (proc == 2) {//userın başruvu geri çekmesi
        mongo.deleteRegister(userId, advertCode);
        response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
    } else if (proc == 3) {//iknın başvuruyu işleme alması
        mongo.updateRegister(mongo.createDBORegister(id, advertCode, 1));
        MailService.generateAndSendEmail(advertCode + " nolu ilana olan basvurunuz isleme alınmıştır", emailTo);
        response.sendRedirect(request.getContextPath() + "/userDetail.jsp?user=" + id);
    } else if (proc == 4) {//iknın başvuruyu kabul etmesi
        mongo.updateRegister(mongo.createDBORegister(id, advertCode, 2));
        MailService.generateAndSendEmail(advertCode + " nolu ilana olan başvurunuz kabul edilmiştir", emailTo);
        response.sendRedirect(request.getContextPath() + "/userDetail.jsp?user=" + id);
    } else if (proc == 5) {//iknın başvuruyu reddetmesi
        mongo.updateRegister(mongo.createDBORegister(id, advertCode, 3));
        MailService.generateAndSendEmail(advertCode + " nolu ilana olan başvurunuz reddedilmiştir", emailTo);
        response.sendRedirect(request.getContextPath() + "/userDetail.jsp?user=" + id);
    }


%>
