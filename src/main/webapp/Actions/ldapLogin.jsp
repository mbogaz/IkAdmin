<%@page import="service.LDAPLoginAuthentication"%>
<%@page import="Object.IKUser"%>
<%@page import="java.util.ArrayList"%>
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
       if(!isLogin)
           response.sendRedirect(request.getContextPath() + "/index.jsp?err_no=1");
       else
            response.sendRedirect(request.getContextPath() + "/createForm.jsp");
     %>
<%
    /*if ("POST".equalsIgnoreCase(request.getMethod())) {
        out.println("POST:"+request.getParameter("name"));
    } else {
    }*/
%>