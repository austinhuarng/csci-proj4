package HW4;


public class Restaurant {
	private String name;
	private Double latitude;
	private Double longitude;
	private String imgurl;
	private String address;
	private String pageurl;
	private Double rating;
	private String phone;
	private String cuisine;
	private String price;
	
	public Restaurant(String name, Double latitude, Double longitude, String imgurl, String pageurl, String address, Double rating, String phone, String cuisine, String price) {
		this.name = name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.imgurl=imgurl;
		String url = pageurl;
		int iend = url.indexOf("?");
		if (iend != -1) 
		{
		    pageurl= url.substring(0 , iend);
		} 
		this.pageurl = pageurl;
		this.address = address;
		this.rating = rating;
		this.cuisine = cuisine;
		this.phone = phone;
		this.price = price;
	}
	
	public String getName() {
		return name;
	}
	public Double getLatitude() {
		return latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public String getImgurl() {
		return imgurl;
	}
	public String getPageurl() {
		return pageurl;
	}
	public String getAddress() {
		return address;
	}
	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCuisine() {
		return cuisine;
	}

	public void setCuisine(String cuisine) {
		this.cuisine = cuisine;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
}
