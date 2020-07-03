package HW4;


import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class landingservlet
 */
@WebServlet("/landingservlet")
public class landingservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public landingservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String next = "";
		String restoname = request.getParameter("restaurantname");
		String lat = request.getParameter("latitude");
		String lng = request.getParameter("longitude");
		String search = request.getParameter("searchtype");
		if(restoname.isEmpty() || lat.isEmpty() || lng.isEmpty() || search==null){
			next = "/index.jsp";
			request.setAttribute("landingerror", "Please provide proper inputs!!");
		}
		else{
			request.setAttribute("restaurantname", restoname);
			request.setAttribute("latitude", lat);
			request.setAttribute("longitude", lng);
			request.setAttribute("searchtype", search);
			Double lati = Double.parseDouble(lat);
			Double longi = Double.parseDouble(lng);
			System.out.println(restoname);
			System.out.println(lat);
			System.out.println(lng);
			System.out.println(search);
			Vector<Restaurant> reslist = new Vector<Restaurant>();
			reslist = YelpAPI.yelpcall(restoname, lati, longi, search);
			request.setAttribute("resultlist", reslist);
			next = "/SearchResults.jsp";
		}
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request,response);
	}

}
