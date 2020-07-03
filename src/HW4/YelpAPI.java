package HW4;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Vector;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.sun.javafx.scene.control.behavior.TwoLevelFocusPopupBehavior;

public class YelpAPI {
	
    private static final String API_KEY = "API_KEY";

    private static String buildURL(String name, double latitude, double longitude, String sorttype) {

    	// Handling special cases for the Yelp API
    	name = name.replaceAll("\\s+", "-");
		name = name.replaceAll(" ", "-");
		name = name.replaceAll("��", "'");

        return "https://api.yelp.com/v3/businesses/search?" +
                "term=" + name +
                "&latitude=" + latitude +
                "&longitude=" + longitude +
                "&sort_by=" + sorttype + 
                "&limit=10";
    }

    private static String getRequest(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization","Bearer " + API_KEY);
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        return in.readLine();
    }

    public static Vector<Restaurant> yelpcall(String name, double latitude, double longitude, String sorttype) throws IOException {
        // Get JSON string
        String jsonString = getRequest(buildURL(name, latitude, longitude, sorttype));

        // Parse the JSON using JSON.Simple
        JSONParser parser = new JSONParser();
        JSONArray data = null;
		try {
			data = (JSONArray) ((JSONObject) parser.parse(jsonString)).get("businesses");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Go through array of restaurants and pick the first match
        Vector<Restaurant>yelpvector = new Vector<Restaurant>();
        for (Object restaurant: data) {
            String restaurantName = (String) ((JSONObject) restaurant).get("name");
            JSONObject coordinates = (JSONObject) ((JSONObject) restaurant).get("coordinates");
            double restaurantLat = (double) coordinates.get("latitude");
            double restaurantLong = (double) coordinates.get("longitude");
            String imgurl= (String)((JSONObject) restaurant).get("image_url");
            String pageurl= (String)((JSONObject) restaurant).get("url");
            double rating = (double) ((JSONObject) restaurant).get("rating");
            JSONObject locAdd = (JSONObject) ((JSONObject) restaurant).get("location");
            String phone= (String)((JSONObject) restaurant).get("phone");
            String price= (String)((JSONObject) restaurant).get("price");
            JSONArray cuisinearr = null;
            cuisinearr = (JSONArray)((JSONObject) restaurant).get("categories");
            String cuisinetitle = "N/A";
			if(cuisinearr!=null){
	            cuisinetitle = (String)((JSONObject)cuisinearr.get(0)).get("title");
			}
            String one = (String)locAdd.get("address1");
            String city = (String)locAdd.get("city");
            String state = (String)locAdd.get("state");
            String zip = (String)locAdd.get("zip_code");
            String address = one + " " + city + ", " + state+ " " + zip;
            if(price==null){
            	price = "N/A";
            }
            if(phone==null){
            	phone = "N/A";
            }
            if(imgurl==null){
            	imgurl = "N/A";
            }
            yelpvector.add(new Restaurant(restaurantName, restaurantLat, restaurantLong, imgurl, pageurl, address, rating, phone, cuisinetitle, price));
        }
        if(!yelpvector.isEmpty()){
        	return yelpvector;
        }
        // Return null if restaurant not found
        return null;
    }
	
}
