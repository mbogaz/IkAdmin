package service;


import Object.IKUser;
import java.util.ArrayList;
import java.util.Hashtable;
import javax.naming.*;
import javax.naming.ldap.*;
import javax.naming.directory.*;


public class LDAPLoginAuthentication {
    ArrayList<IKUser> IkUserList = new ArrayList<IKUser>();
    public LDAPLoginAuthentication() {
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
        catch (AuthenticationNotSupportedException exception) {
            System.out.println("The authentication is not supported by the server");
        }catch (AuthenticationException exception){
            System.out.println("Incorrect password or username");
        }catch (NamingException exception){
            System.out.println("Error when trying to create the context :"+exception);
        }
        
         try {
            LdapContext ctx = new InitialLdapContext(environment, null);
            ctx.setRequestControls(null);
            NamingEnumeration<?> namingEnum = ctx.search("ou=people,dc=obss,dc=com", "(objectclass=person)", getSimpleSearchControls());
            
            while (namingEnum.hasMore ()) {
                SearchResult result = (SearchResult) namingEnum.next ();    
                Attributes attrs = result.getAttributes ();
                   
                String userName = attrs.get("uid").get(0).toString();
                String password = attrs.get("gecos").get(0).toString();
                IKUser iku = new IKUser(userName, password);
                IkUserList.add(iku);
            } 
            namingEnum.close();
        } catch (Exception e) {}
        
    }

    
    public static void main(String[] args) {
        LDAPLoginAuthentication ldap = new LDAPLoginAuthentication();
    }
    private static SearchControls getSimpleSearchControls() {
    SearchControls searchControls = new SearchControls();
    searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
    searchControls.setTimeLimit(30000);
    //String[] attrIDs = {"objectGUID"};
    //searchControls.setReturningAttributes(attrIDs);
    return searchControls;
}
    public ArrayList<IKUser> getIKList(){
        return IkUserList;
    }
}