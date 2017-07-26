<%@page import="service.MongoDBJDBC"%>
<%@page import="Object.SimpleUser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="service.LinkedinAuthentication"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<%
    
    LinkedinAuthentication la = new LinkedinAuthentication();
    MongoDBJDBC mongo = new MongoDBJDBC();
    if (request.getParameter("type").equals("1")) {
        
        //get token
        String code = request.getParameter("code");
        String res = la.getToken(code);
        //parse linkedin response
        JSONObject obj = new JSONObject(res);
        String token = obj.getString("access_token").toString();
        //get info from linkedin
        String info = la.authLinkedin(token);
        JSONObject user = new JSONObject(info);
        String id = user.getString("id");
        
        //id her türlü linkedin den çekilecek
        String firstName = "", lastName = "", headline = "", skills = ""
                , location = "", pictureUrl = "", emailAddress = "",blackList="";
        
        if (mongo.isUserExist(id)) {//kayıtlıysa db den çek
            obj = mongo.getElement("user", id);
            firstName = obj.getString("fn");
            lastName = obj.getString("ln");
            headline = obj.getString("headline");
            location = obj.getString("location");
            pictureUrl = obj.getString("pictureUrl");
            emailAddress = obj.getString("emailAddress");
            
            if (!obj.isNull("skills")) 
                skills = obj.getString("skills");
            
            if (!obj.isNull("blackList")) 
                blackList = obj.getString("blackList");
            
        } else {//kayıtlı değilse linkedin den çek
            firstName = user.getString("firstName");
            lastName = user.getString("lastName");
            headline = user.getString("headline");
            JSONObject locationObj = user.getJSONObject("location");
            location = locationObj.getString("name");
            pictureUrl = user.getString("pictureUrl");
            emailAddress = user.getString("emailAddress");
            mongo.addItemToDB(mongo.createDBOUser(id, firstName, lastName, headline, "", location, pictureUrl, emailAddress,null), 0);
        }
        session.setAttribute("id", id);
        session.setAttribute("firstName", firstName);
        session.setAttribute("lastName", lastName);
        session.setAttribute("headline", headline);
        session.setAttribute("skills", skills);
        session.setAttribute("location", location);
        session.setAttribute("pictureUrl", pictureUrl);
        session.setAttribute("emailAddress", emailAddress);
        response.sendRedirect(request.getContextPath() + "/listJobs.jsp");
    }

%>

