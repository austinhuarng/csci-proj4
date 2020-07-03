package HW4;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import org.apache.jasper.tagplugins.jstl.core.Catch;
import org.apache.tomcat.util.security.Escape;
import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;

import java.sql.Connection;
import java.sql.ResultSet;

public class SQLConnection {
	public static Connection conn = null;
	public static Statement st = null;
	PreparedStatement ps = null;
	
	public static void SQLConnection_init(){
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/hw4?user=USERNAME&password=PASSWORD");
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public static void createUser(String email, String username, String password) throws SQLException{
		try {
			PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO Users(email, username, pw) VALUES (?,?,?)");
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, username);
			preparedStatement.setString(3, password);
			preparedStatement.execute();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getUsername(String username) throws SQLException{
		String name="";
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT username FROM Users WHERE username='" + username + "'");
			if(rs.next()) name = rs.getString("username");
			else name = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return name;
	}
	
	public static String getPassword(String username) throws SQLException{
		String password="";
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT pw FROM Users WHERE username='" + username + "'");
			if(rs.next()) password = rs.getString("pw");
			else password = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return password;
	}
	
	public static String getEmail(String username) throws SQLException{
		String email="";
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT email FROM Users WHERE username='" + username + "'");
			if(rs.next()) email = rs.getString("email");
			else email = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return email;
	}
	public static String checkEmail(String email) throws SQLException{
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT email FROM Users");
			if(rs.next()){
				if(email.equals(rs.getString("email"))){
					return "same";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "lel";
	}
	
	public static void addRestaurant(String username, String restoname, String address, String pageurl, String imgurl, double rating, String phone, String cuisine, String price){
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(
					"INSERT INTO Favorites(username, restoname, address, pageurl, imgurl, rating, phone, cuisine, price) VALUES (?,?,?,?,?,?,?,?,?)");
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, restoname);
			preparedStatement.setString(3, address);
			preparedStatement.setString(4, pageurl);
			preparedStatement.setString(5, imgurl);
			preparedStatement.setDouble(6, rating);
			preparedStatement.setString(7,  phone);
			preparedStatement.setString(8, cuisine);
			preparedStatement.setString(9, price);
			preparedStatement.execute();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void removeRestaurant(String username, String address){
		try {
			st = conn.createStatement();
			st.executeUpdate("DELETE FROM Favorites WHERE username='" + username + "' AND address='" + address + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Vector<Restaurant> getList(String username){
		Vector<Restaurant> favs = new Vector<Restaurant>();
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM Favorites WHERE username='" + username + "'");
			while(rs.next()){
				String name = rs.getString("restoname");
				String imgurl = rs.getString("imgurl");
				String pageurl = rs.getString("pageurl");
				String address = rs.getString("address");
				double rating = rs.getDouble("rating");
				String phone = rs.getString("phone");
				String cuisine = rs.getString("cuisine");
				String price = rs.getString("price");
				Restaurant r = new Restaurant(name, 0.0, 0.0, imgurl, pageurl, address, rating, phone, cuisine, price);
				favs.add(r);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return favs;
	}
	
}