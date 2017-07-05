
package com.mycompany.mavenproject2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;


public class LinkedinTest {
   
    public static void main(String[] args) throws IOException{
        StringBuilder sb =new StringBuilder();
       
        try {
            Process p = Runtime.getRuntime().exec("ldapsearch -x -LLL -b dc=obss,dc=com");
            p.waitFor();
                        BufferedReader reader =
                    new BufferedReader(new InputStreamReader(p.getInputStream()));

               String line = "";
               while ((line = reader.readLine())!= null) {
               sb.append(line + "\n");
               }
        } catch (InterruptedException ex) {
            Logger.getLogger(LinkedinTest.class.getName()).log(Level.SEVERE, null, ex);

        }

        System.out.println("res:"+sb.toString());
    }
}
