/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mavenproject2;


public class Controller {
  static Controller controller;  
  
  
  
  
  
  
  public static Controller getController(){
    if(controller==null)
        controller = new Controller();
    return controller;
}

}
