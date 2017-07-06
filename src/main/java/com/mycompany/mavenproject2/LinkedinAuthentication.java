package com.mycompany.mavenproject2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.HttpEntity;
import static org.apache.http.HttpHeaders.USER_AGENT;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.LinkedInApi;
import org.scribe.model.Token;
import org.scribe.model.Verifier;
import org.scribe.oauth.OAuthService;


public class LinkedinAuthentication {
    
    
    public static void main(String[] args) {
        //LinkedinAuthentication la = new LinkedinAuthentication();
        //la.authLinkedin();
    }

    public LinkedinAuthentication() {
        //this.code = code;
    }
    
    public String authLinkedin(String token){
        String res;
        HttpClient httpClient = new DefaultHttpClient();
        HttpGet httpGet = new HttpGet("https://api.linkedin.com/v1/people/~?format=json");
        /*httpGet.addHeader(BasicScheme.authenticate(
         new UsernamePasswordCredentials("Authorization", "Bearer AQVxLlx7B8zZ64HgmZ6jkWkzN0qOPJxUhqEyIRdvjVzBFoRT7U4V_d0yB0-pH8fFl69ebNYQfuQC4bE07bI5jp-GI0qmPbvP02iO8IN3knmTpVo17PH7F1Morz94Vl-d3QcP18fbsyeaK45MsFoldjmHd8jxAFXb9bpt8xNdjoe2_5l5Q5M"),
         "UTF-8", false));*/
        httpGet.addHeader("Authorization", "Bearer "+token);

        HttpResponse httpResponse;
        try {
            httpResponse = httpClient.execute(httpGet);
            HttpEntity entity = httpResponse.getEntity();
            String responseString = EntityUtils.toString(entity, "UTF-8");
            System.out.println("response: "+responseString);
            res = responseString;
        } catch (IOException ex) {
            System.out.println("error:"+ex);
            res = "error :"+ex;
        }
        
        
        return res;
    }
    public String getToken(String code){
        String res="init";
        String url = "https://www.linkedin.com/oauth/v2/accessToken";

        HttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("grant_type", "authorization_code"));
        urlParameters.add(new BasicNameValuePair("code", code));
        urlParameters.add(new BasicNameValuePair("redirect_uri", "http://localhost:26201/mavenproject2/Actions/linkedinLogin.jsp?type=1"));
        urlParameters.add(new BasicNameValuePair("client_id", "86vvecy3ntqbft"));
        urlParameters.add(new BasicNameValuePair("client_secret", "5CxvPtnPobeEKkga"));

        try {
            post.setEntity(new UrlEncodedFormEntity(urlParameters));
            HttpResponse response = client.execute(post);
            System.out.println("Response Code : "
                            + response.getStatusLine().getStatusCode());

            BufferedReader rd = new BufferedReader(
                    new InputStreamReader(response.getEntity().getContent()));

            StringBuffer result = new StringBuffer();
            String line = "";
            while ((line = rd.readLine()) != null) {
                    result.append(line);
            }
            res = result.toString();
        } catch (UnsupportedEncodingException ex) { } catch (IOException ex) { }

        return res;
    }
}
