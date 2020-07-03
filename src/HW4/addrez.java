package HW4;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.RestoreAction;

/**
 * Servlet implementation class addrez
 */
@WebServlet("/addrez")
public class addrez extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addrez() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String username = request.getParameter("name");
		String restoname = request.getParameter("resto");
		String address = request.getParameter("address");
		String pageurl = request.getParameter("pageurl");
		String imgurl = request.getParameter("imgurl");
		double rating = Double.parseDouble(request.getParameter("rating"));
		String phone = request.getParameter("phone");
		String cuisine = request.getParameter("cuisine");
		String price = request.getParameter("price");
		SQLConnection.SQLConnection_init();
		if(request.getParameter("savetodb").equals("no")){
			SQLConnection.SQLConnection_init();
			System.out.println("got before add stsmnt");
			SQLConnection.addRestaurant(username, restoname, address, pageurl, imgurl, rating, phone, cuisine, price);
			System.out.println("added to the db");
		}
		else{
			SQLConnection.removeRestaurant(username, address);
			System.out.println("deleted from the db");
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
