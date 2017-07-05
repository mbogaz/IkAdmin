package com.mycompany.mavenproject2;


import java.util.Hashtable;
import javax.naming.*;
import javax.naming.ldap.*;
import javax.naming.directory.*;


public class LDAPLoginAuthentication {
    public LDAPLoginAuthentication() {
        // TODO Auto-generated constructor
    }


    public static void main(String[] args) {
        Hashtable<String, String> environment = new Hashtable<String, String>();

        environment.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        environment.put(Context.PROVIDER_URL, "ldap://localhost:389");
        environment.put(Context.SECURITY_AUTHENTICATION, "simple");
        environment.put(Context.SECURITY_PRINCIPAL, "cn=admin,dc=obss,dc=com");
        environment.put(Context.SECURITY_CREDENTIALS, "12119885768");

        try 
        {
            DirContext context = new InitialDirContext(environment);
            System.out.println("Connected..");
            System.out.println(context.getEnvironment());
            context.close();
        } 
        catch (AuthenticationNotSupportedException exception) 
        {
            System.out.println("The authentication is not supported by the server");
        }

        catch (AuthenticationException exception)
        {
            System.out.println("Incorrect password or username");
        }

        catch (NamingException exception)
        {
            System.out.println("Error when trying to create the context :"+exception);
        }
        }
    
    
}