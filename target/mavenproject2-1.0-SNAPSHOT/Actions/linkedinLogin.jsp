<%@page import="service.MongoDBJDBC"%>
<%@page import="Object.SimpleUser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.LinkedinAuthentication"%>
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
        
        String id = user.getString("id");
        //id her türlü linkedin den çekilecek
        String firstName="",lastName="",headline="",skills="";
        if(mongo.isUserExist(id)){//kayıtlıysa db den çek
            obj = mongo.getElement("user", id);
            firstName = obj.getString("fn"      );
            lastName  = obj.getString("ln"      );
            headline  = obj.getString("headline");
            if(obj.isNull("skills")) skills ="";
            else skills    = obj.getString("skills"  );
        }else{//kayıtlı değilse linkedin den çek
            firstName = user.getString("firstName");
            lastName  = user.getString("lastName" );
            headline  = user.getString("headline" );
            mongo.addItemToDB(mongo.createDBOUser(id, firstName, lastName, headline,""));
        }
        session.setAttribute( "id"       ,       id);
        session.setAttribute( "firstName",firstName);
        session.setAttribute( "lastName" , lastName);
        session.setAttribute( "headline" , headline);
        session.setAttribute( "skills"   ,   skills);
        response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
    }
  //String code = request.getParameter("code");
  
  /*String res = la.authLinkedin();
  out.println(res);*/
    %>

