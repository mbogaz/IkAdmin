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
import java.util.Set;
import org.json.JSONObject;

public class MongoDBJDBC {

    DBCollection collUser;
    DBCollection collAdvert;
    DBCollection collRegister;

    public MongoDBJDBC() {
        try {

            // To connect to mongodb server
            MongoClient mongoClient = new MongoClient("localhost", 27017);

            // Now connect to your databases
            DB db = mongoClient.getDB("obss");

            char[] password = new char[10];
            db.authenticate("admin", password);

            collUser = db.getCollection("Users");
            collAdvert = db.getCollection("Advert");
            collRegister = db.getCollection("Register");

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
    }

    public static void main(String args[]) {
        MongoDBJDBC mongo = new MongoDBJDBC();
        //mongo.deleteAll(0);
        mongo.printAll();
        
    }

    public void deleteAll() {
        //use wisely,removes every entry in db
        BasicDBObject document = new BasicDBObject();

        DBCursor[] cursors = {collUser.find(), collAdvert.find(), collRegister.find()};
        DBCollection[] colls = {collUser, collAdvert, collRegister};
        for (int i = 0; i < 3; i++) {
            colls[i].remove(document);
            while (cursors[i].hasNext()) {
                colls[i].remove(cursors[i].next());
            }
        }
    }

    public void deleteAll(int section) {
        /*
        section 0 -> user
        section 1 -> advert
        section 2 -> register
        */
        BasicDBObject document = new BasicDBObject();

        DBCursor[] cursors = {collUser.find(), collAdvert.find(), collRegister.find()};
        DBCollection[] colls = {collUser, collAdvert, collRegister};

        colls[section].remove(document);
        while (cursors[section].hasNext()) {
            colls[section].remove(cursors[section].next());
        }

    }

    public void printAll() {
        DBCursor[] cursors = {collUser.find(), collAdvert.find(), collRegister.find()};
        for (int index = 0; index < 3; index++) {
            System.out.println(index + "- start");
            while (cursors[index].hasNext()) {
                System.out.println(cursors[index].next());
            }
            System.out.println(index + "- done");
        }
    }

    public void deleteUser(String id) {
        DBCursor cursor = collUser.find();
        int i = 1;

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("user").equals(id)) {
                collUser.remove(obj);
            }
        }

    }

    public void deleteRegister(String userId, int advertCode) {
        DBCursor cursor = collRegister.find();
        int i = 1;
        
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("userId").equals(userId)
                    && obj.get("advertCode").equals(advertCode)) {
                collRegister.remove(obj);
            }

        }

    }

    public boolean isUserExist(String val) {
        DBCursor cursor = collUser.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("user").equals(val)) {
                return true;
            }
        }

        return false;
    }
    
    public void banUser(String userId){
        DBCursor cursor = collRegister.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("userId").equals(userId)) {
                collRegister.update(obj, createDBORegister(userId, Integer.parseInt(obj.get("advertCode")+""), 3));
            }
        }

    }

    public int isUserRegistered(String userId, int advertCode) {
        DBCursor cursor = collRegister.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("userId").equals(userId) && obj.get("advertCode").equals(advertCode)) {
                return Integer.parseInt(obj.get("status")+"");
            }
        }

        return -1;
    }

    public ArrayList<JSONObject> getList(String type) {
        ArrayList<JSONObject> list = new ArrayList<>();
        DBCursor cursor = null;
        switch (type) {
            case "user":
                cursor = collUser.find();
                break;
            case "advert":
                cursor = collAdvert.find();
                break;
            case "register":
                cursor = collRegister.find();
                break;
        }

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            list.add(new JSONObject(JSON.serialize(obj)));
        }

        return list;
    }

    public ArrayList<JSONObject> getRegistersByAdvertCode(int advertCode) {
        ArrayList<JSONObject> list = new ArrayList<>();

        DBCursor cursor = collRegister.find();
        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("advertCode").equals(advertCode)) {
                list.add(new JSONObject(JSON.serialize(obj)));
            }
        }

        return list;
    }

    public ArrayList<JSONObject> getRegistersByUserId(String userId) {
        ArrayList<JSONObject> list = new ArrayList<>();

        DBCursor cursor = collRegister.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("userId").equals(userId)) {
                list.add(new JSONObject(JSON.serialize(obj)));
            }
        }

        return list;
    }

    public JSONObject getElement(String key, String val) {

        DBCursor cursor = null;
        switch (key) {
            case "user":
                cursor = collUser.find();
                break;
            case "advert":
                cursor = collAdvert.find();
                break;
            case "register":
                cursor = collRegister.find();
                break;
        }

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if ((obj.get(key) + "").equals(val)) {
                return new JSONObject(JSON.serialize(obj));
            }
        }

        return null;
    }


    public BasicDBObject createDBOUser(String id, String firstName, String lastName,
            String headline, String skills, String location, String pictureUrl, String emailAddress,String blackList) {
        BasicDBObject doc = new BasicDBObject("user", id).
                append("fn", firstName).
                append("ln", lastName).
                append("skills", skills).
                append("headline", headline).
                append("location", location).
                append("pictureUrl", pictureUrl).
                append("emailAddress", emailAddress).
                append("blackList",blackList);
        return doc;
    }

    public BasicDBObject createDBORegister(String userId, int advertCode, int status) {
        BasicDBObject doc = new BasicDBObject("userId", userId).
                append("advertCode", advertCode).
                append("status", status);
        return doc;
    }

    public BasicDBObject createDBOAdvert(int code, String header, String definition, String requirements,
            String activationTime, String closeTime, boolean active) {
        BasicDBObject doc = new BasicDBObject("advert", code).
                append("header", header).
                append("definition", definition).
                append("requirements", requirements).
                append("activationTime", activationTime).
                append("closeTime", closeTime).
                append("active", active);
        return doc;
    }

    public void addItemToDB(BasicDBObject doc, int collNumber) {
        DBCollection coll = null;
        switch (collNumber) {
            case 0:
                coll = collUser;
                break;
            case 1:
                coll = collAdvert;
                break;
            case 2:
                coll = collRegister;
                break;
        }
        coll.insert(doc);
    }

    public void updateAdvert(BasicDBObject newObj) {
        DBCursor cursor = collAdvert.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("advert").equals(newObj.get("advert"))) {
                collAdvert.update(obj, newObj);
                return;
            }

        }
    }

    public void updateUser(BasicDBObject newObj) {
        DBCursor cursor = collUser.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("user").equals(newObj.get("user"))) {
                collUser.update(obj, newObj);
                return;
            }

        }
    }
    

    public void updateRegister(BasicDBObject newObj) {
        DBCursor cursor = collRegister.find();

        while (cursor.hasNext()) {
            DBObject obj = cursor.next();
            if (obj.get("userId").equals(newObj.get("userId"))
                    && obj.get("advertCode").equals(newObj.get("advertCode"))) {
                collRegister.update(obj, newObj);
                return;
            }

        }
    }
    
}
