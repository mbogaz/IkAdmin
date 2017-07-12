<%-- 
    Document   : register
    Created on : Jul 10, 2017, 9:04:01 AM
    Author     : mahmut
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%
  
    MongoDBJDBC mongo = new MongoDBJDBC();
    String userId = session.getAttribute("id")+"";
    out.print(request.getParameter("advertCode"));
    int advertCode = Integer.parseInt(request.getParameter("advertCode"));
    
    if(request.getParameter("type").equals("1"))
        mongo.addItemToDB(mongo.createDBORegister(userId,advertCode),2);
    else if(request.getParameter("type").equals("2"))
        mongo.deleteRegister(userId,advertCode);
    
    response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
%>
