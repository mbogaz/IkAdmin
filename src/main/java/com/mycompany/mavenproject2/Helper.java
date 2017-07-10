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
        Helper h = new Helper();
        int[] arr = {5,1,4,2,3};
        int[] arr2 = new int[5];
        int lenght = 5;
        for(int i=0;i<lenght;i++){
            int maxIndex = h.getMaxIndex(arr);
            arr2[i] = arr[maxIndex];
            arr[maxIndex] = -1;
            //newList.add(list.get(maxIndex));
        }
        for(int a:arr2){
            System.out.println(a);
        }
    }
    public Helper(){
        
    }
    public void sortArrayList(ArrayList<JSONObject> list,final String skills){
       Collections.sort(list, new Comparator<JSONObject>() {

        @Override
        public int compare(JSONObject obj1, JSONObject obj2)
        {

            return  getConflictNumber(obj1, skills)<getConflictNumber(obj2, skills)?1:-1;
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
