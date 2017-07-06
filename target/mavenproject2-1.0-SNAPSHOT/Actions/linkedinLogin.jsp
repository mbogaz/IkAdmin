<%@page import="com.mycompany.mavenproject2.MongoDBJDBC"%>
<%@page import="Object.SimpleUser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.mycompany.mavenproject2.LinkedinAuthentication"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<%
    LinkedinAuthentication la = new LinkedinAuthentication();
    MongoDBJDBC mongo = new MongoDBJDBC();
    if(request.getParameter("type").equals("1")){
        String code = request.getParameter("code");
        String res = la.getToken(code);
        JSONObject obj = new JSONObject(res);
        String token = obj.getString("access_token").toString();
        //out.println("token:"+token);
        String info = la.authLinkedin(token);
        JSONObject user = new JSONObject(info);
        String firstName = user.getString("firstName");
        String lastName = user.getString("lastName");
        String id = user.getString("id");
        String headline = user.getString("headline");
        if(mongo.isUserExist(id)){
            
        }else{
            mongo.addUser(mongo.createDBObject(id, firstName, lastName, headline));
        }
        
    }
  //String code = request.getParameter("code");
  
  /*String res = la.authLinkedin();
  out.println(res);*/
    %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
