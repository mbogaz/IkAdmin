/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

/**
 *
 * @author mahmut
 */
public class IKUser {
    private String userName;
    private String password;
    
    public IKUser(String userName,String password){
        this.userName = userName;
        this.password = password;
    }
    
    public void setUserName(String userName){
        this.userName = userName;    
    }
    public String getUserName(){
        return userName;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    public String getPasssword(){
        return password;
    }
    @Override
    public String toString(){
        return "userName:"+userName+" password:"+password;
    }
 }
