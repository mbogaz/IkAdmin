<%@page import="org.json.JSONObject"%>
<%@page import="service.MongoDBJDBC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("userId");
String commend = request.getParameter("commend");
MongoDBJDBC mongo = new MongoDBJDBC();
JSONObject userObj = mongo.getElement("user", userId);
String type = request.getParameter("type");
if(type.equals("0")){
    userObj.put("blackList", commend);
    mongo.banUser(userId);
    
}else if(type.equals("1")){
    userObj.put("blackList", "");
}
    String firstName = userObj.getString("fn"); 
    String lastName = userObj.getString("ln");
    String headline = userObj.getString("headline");
    String skills = userObj.getString("skills");
    String location = userObj.getString("location");
    String pictureUrl = userObj.getString("pictureUrl");
    String emailAddress = userObj.getString("emailAddress");
    mongo.updateUser(mongo.createDBOUser(userId, firstName, lastName, headline, skills, location, pictureUrl, emailAddress,commend));

response.sendRedirect(request.getContextPath() + "/userDetail.jsp?user=" + userId);
%>