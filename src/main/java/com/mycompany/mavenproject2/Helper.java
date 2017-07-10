/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mavenproject2;

import java.util.ArrayList;
import java.util.Collections;
import static java.util.Collections.list;
import java.util.Comparator;
import org.json.JSONObject;

/**
 *
 * @author mahmut
 */
public class Helper {
    public static void main(String[]args){

    }
    public Helper(){
        
    }
    public void sortArrayListByRelevance(ArrayList<JSONObject> list,final String skills){
       Collections.sort(list, new Comparator<JSONObject>() {
            @Override
            public int compare(JSONObject obj1, JSONObject obj2)
            {

                return  getConflictNumber(obj1, skills)<getConflictNumber(obj2, skills)?1:-1;
            }
        });
    }
    public void sortArrayListById(ArrayList<JSONObject> list){
               Collections.sort(list, new Comparator<JSONObject>() {
            @Override
            public int compare(JSONObject obj1, JSONObject obj2)
            {

                return  obj1.getInt("advert")<obj2.getInt("advert")?-1:1;
            }
        });
    }
    
    public int getConflictNumber(JSONObject obj,String skills){
        int conflict=0;
        String data = obj.getString("requirements");
        String[] arr = data.split(",");
        String[] arr2 = skills.split(",");
        for(String str:arr){
            if(isContainStr(arr2, str))
                conflict++;
        }
        return conflict;
    }
    public boolean isContainStr(String[] arr,String key){
        for(String str:arr)
            if(str.equals(key))
                return true;
        return false;
    }
}
