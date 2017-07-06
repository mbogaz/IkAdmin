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

   public static void main( String args[] ) {
	
      try{   
		
         // To connect to mongodb server
         MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
			
         // Now connect to your databases
         DB db = mongoClient.getDB( "obss" );
         System.out.println("Connect to database successfully");
			
         char[] password= new char[10];
         boolean auth = db.authenticate("admin", password);
         System.out.println("Authentication: "+auth);         
			
         DBCollection coll = db.getCollection("Users");
         System.out.println("Collection mycol selected successfully");
			
         DBCursor cursor = coll.find();
         int i = 1;
			
         while (cursor.hasNext()) { 
            System.out.println("Inserted Document: "+i); 
            System.out.println(cursor.next()); 
            i++;
         }
			
      }catch(Exception e){
         System.err.println( e.getClass().getName() + ": " + e.getMessage() );
      }
   }
}