<%@page import="Object.IKUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.mavenproject2.LDAPLoginAuthentication"%>
<%
     LDAPLoginAuthentication ldap = new LDAPLoginAuthentication();
       ArrayList<IKUser> ikList = ldap.getIKList();
       boolean isLogin = false;
       for (IKUser ik : ikList) {
              if(ik.getUserName().equals(request.getParameter("userName"))
                      &&
                 ik.getPasssword().equals(request.getParameter("password"))){
                  session.setAttribute( "userName",request.getParameter("userName") );
                  isLogin = true;
              } 
           }
       if(!isLogin){
            String redirectURL = "index.jsp?err_no=1";
            response.sendRedirect(redirectURL);
       }
       response.sendRedirect(request.getContextPath() + "/createForm.jsp");
%>
<%
    /*if ("POST".equalsIgnoreCase(request.getMethod())) {
        out.println("POST:"+request.getParameter("name"));
    } else {
    }*/
%>