package service;

import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;

import com.mongodb.ServerAddress;
import com.mongodb.util.JSON;
import java.util.ArrayList;
import java.util.Arrays;
import org.json.JSONObject;

public class MongoDBJDBC {

    DBCollection coll;

    public MongoDBJDBC() {
        try {

            // To connect to mongodb server
            MongoClient mongoClient = new MongoClient("localhost", 27017);

            // Now connect to your databases
            DB db = mongoClient.getDB("obss");

            char[] password = new char[10];
            db.authenticate("admin", password);

            coll = db.getCollection("Users");

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
    }

    public static void main(String args[]) {
        MongoDBJDBC mongo = new MongoDBJDBC();
        /*BasicDBObject doc = new BasicDBObject("user", "mbogaz").
                append("fn", "Mahmut").
                append("ln", "Boğaz").
                append("headline", "Marmara");*/
        //mongo.addUser(doc);
        //mongo.updateAdvert(mongo.createDBOAdvert(1, "İlan aAa", "Çok kod yazılmalı", "c,java", "2017-07-01", "2017-08-01", true));
        //System.out.println(mongo.isUserRegistered("RfBtpuSTyl", 3));
        mongo.printAll();
        //System.out.println(mongo.getElement("advert", 1+""));
        //see records for a type
        /*for(JSONObject obj:mongo.getList("advert")){
            System.out.println(obj.get("header"));
        }*/
        //mongo.deleteAll();
        //System.out.println(mongo.isUserExist("mbMahmutogaz"));
    }

    public void deleteAll() {
        //use wisely,removes every entry in db
        BasicDBObject document = new BasicDBObject();

        // Delete All documents from collection Using blank BasicDBObject
        coll.remove(document);

        // Delete All documents from collection using DBCursor
        DBCursor cursor = coll.find();
        while (cursor.hasNext()) {
            coll.remove(cursor.next());
        }
    }

    public void printAll() {
        DBCursor cursor = coll.find();
        int i = 1;

        while (cursor.hasNext()) {
            System.out.println("Inserted Document: " + i);
            System.out.println(cursor.next());
            i++;
        }
    }

    public void deleteUser(String id) {
        DBCursor cursor = coll.find();
        int i = 1;

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("user").equals(id)) {
                coll.remove(obj);
            }
        }

    }
    public void deleteRegister(String userId,int advertCode) {
        DBCursor cursor = coll.find();
        int i = 1;

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("type").equals("register") 
                    && obj.get("userId").equals(userId)
                    && obj.get("advertCode").equals(advertCode)) {
                coll.remove(obj);
            }
            
        }

    }
    

    public boolean isUserExist(String val) {
        DBCursor cursor = coll.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("type").equals("user") && obj.get("user").equals(val)) {
                return true;
            }
        }

        return false;
    }
    public boolean isUserRegistered(String userId,int advertCode){
        DBCursor cursor = coll.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("type").equals("register") 
                    && obj.get("userId").equals(userId)
                    && obj.get("advertCode").equals(advertCode)) {
                return true;
            }
        }

        return false;
    }
    
    public ArrayList<JSONObject> getList(String type){
        ArrayList<JSONObject> list = new ArrayList<>();
        
        DBCursor cursor = coll.find();
        
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if(obj.get("type").equals(type))
                list.add(new JSONObject(JSON.serialize(obj)));
        }
        
        return list;
    }
    public ArrayList<JSONObject> getRegistersByAdvertCode(int advertCode){
        ArrayList<JSONObject> list = new ArrayList<>();
        
        DBCursor cursor = coll.find();
        
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if(obj.get("type").equals("register") && obj.get("advertCode").equals(advertCode))
                list.add(new JSONObject(JSON.serialize(obj)));
        }
        
        return list;
    }
    
    public JSONObject getElement(String key,String val){
        
        DBCursor cursor = coll.find();
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if(obj.get("type").equals(key) && (obj.get(key)+"").equals(val))
                return new JSONObject(JSON.serialize(obj));
        }
        
        return null;
    }
    

    public BasicDBObject createDBOUser(String id, String firstName, String lastName, String headline,String skills) {
        BasicDBObject doc = new BasicDBObject("user", id).
                append("fn", firstName).
                append("ln", lastName).
                append("skills", skills).
                append("headline", headline).
                append("type","user");
        return doc;
    }
    public BasicDBObject createDBORegister(String userId,int advertCode){
        BasicDBObject doc = new BasicDBObject("userId", userId).
                append("advertCode", advertCode).
                append("type","register");
        return doc;
    }
    public BasicDBObject createDBOAdvert(int code, String header, String definition, String requirements
            , String activationTime, String closeTime,boolean active) {
        BasicDBObject doc = new BasicDBObject("advert", code).
                append("header", header).
                append("definition", definition).
                append("requirements", requirements).
                append("activationTime", activationTime).
                append("closeTime", closeTime).
                append("active", active).
                append("type","advert");
        return doc;
    }

    public void addItemToDB(BasicDBObject doc) {
        coll.insert(doc);
    }
    public void updateAdvert(BasicDBObject newObj){
        DBCursor cursor = coll.find();
			
         while (cursor.hasNext()) { 
            DBObject obj = cursor.next();
            if(obj.get("type").equals("advert") && obj.get("advert").equals(newObj.get("advert"))){
                coll.update(obj, newObj);
                return;
            }
            
         }
    }
    public void updateUser(BasicDBObject newObj){
        DBCursor cursor = coll.find();
			
         while (cursor.hasNext()) { 
            DBObject obj = cursor.next();
            if(obj.get("type").equals("user") && obj.get("user").equals(newObj.get("user"))){
                coll.update(obj, newObj);
                return;
            }
            
         }
    }    
}
