package com.mycompany.mavenproject2;

import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;

import com.mongodb.ServerAddress;
import java.util.Arrays;

public class MongoDBJDBC {
DBCollection coll;
   public MongoDBJDBC(){
       try{   
		
         // To connect to mongodb server
         MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
			
         // Now connect to your databases
         DB db = mongoClient.getDB( "obss" );
			
         char[] password= new char[10];
         db.authenticate("admin", password);        
			
         coll = db.getCollection("Users");
	
     		
      }catch(Exception e){
         System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      }
   }
   public static void main( String args[] ) {
	MongoDBJDBC mongo = new MongoDBJDBC();
        BasicDBObject doc = new BasicDBObject("user", "mbogaz").
            append("fn", "Mahmut").
            append("ln", "Boğaz").
            append("headline", "Marmara");
        //mongo.addUser(doc);
        mongo.printAll();
        //System.out.println(mongo.isUserExist("mbMahmutogaz"));
   }
   public void deleteAll(){
       BasicDBObject document = new BasicDBObject();

        // Delete All documents from collection Using blank BasicDBObject
        coll.remove(document);

        // Delete All documents from collection using DBCursor
        DBCursor cursor = coll.find();
        while (cursor.hasNext()) {
            coll.remove(cursor.next());
        }
   }
   public void printAll(){
       DBCursor cursor = coll.find();
         int i = 1;
			
         while (cursor.hasNext()) { 
            System.out.println("Inserted Document: "+i); 
            System.out.println(cursor.next()); 
            i++;
         }
   }
   public void addUser(BasicDBObject doc){
        coll.insert(doc);
   }
   public void deleteUser(String id){
       DBCursor cursor = coll.find();
         int i = 1;
			
         while (cursor.hasNext()){   
            DBObject obj = cursor.next();
             if(obj.get("user").equals(id))
                coll.remove(obj);
         }
                
   }
   public BasicDBObject createDBObject(String id,String firstName,String lastName,String headline){
       BasicDBObject doc = new BasicDBObject("user", id).
            append("fn", firstName).
            append("ln", lastName).
            append("headline", headline);
       return doc;
   }
   public boolean isUserExist(String val){
       DBCursor cursor = coll.find();
         int i = 1;
			
         while (cursor.hasNext())   
            if(cursor.next().get("user").equals(val))
                    return true;
       
       return false;
   }
}