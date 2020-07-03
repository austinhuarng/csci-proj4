package HW4;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.xml.internal.ws.api.pipe.PipelineAssembler;

/**
 * Servlet implementation class servlet
 */
@WebServlet("/loginservlet")
public class loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/HTML");
		try {
			String next = "/index.jsp";
			String name ="";
			String bt = request.getParameter("signinbutton");
			if(bt==null){
				String idToken = request.getParameter("id_token");
	            name = request.getParameter("username");
	            String email = request.getParameter("email");
	            System.out.println("User name: " + name);
	            System.out.println("User email: " + email);
	            System.out.println("id: " + idToken);
	            HttpSession session = request.getSession(true);
	            session.setAttribute("username", name);
	            session.setAttribute("isgoogle", "yes");
	            SQLConnection.SQLConnection_init();
	            SQLConnection.createUser(email, name, "password");
			}
			else if(bt.equals("signup")){
				String email = request.getParameter("email");
	            name = request.getParameter("username");
	            String password = request.getParameter("password");
	            String confirm = request.getParameter("confirmpassword");
	            System.out.println("User name: " + name);
	            System.out.println("works");
	            SQLConnection.SQLConnection_init();
	            System.out.println(email + " " + SQLConnection.getEmail(name));
	            System.out.println("username is there" + SQLConnection.getUsername(name));
	            if( name.equals(SQLConnection.getUsername(name)) || !password.equals(confirm) ||
	            		SQLConnection.checkEmail(email).equals("same")){
	            	System.out.println("user already exists");
	            	next = "/login.jsp";
	            	request.setAttribute("signuperror", "Error signing up. Ensure you are a new user, your email is valid, and passwords match");
	            }
	            else{
	            	SQLConnection.createUser(email, name, password);
	            	HttpSession session = request.getSession(true);
	                session.setAttribute("username", name);
	            }
			}
			else{
	            String password = request.getParameter("password");
	            name = request.getParameter("username");
	            System.out.println("User name: " + name);
	            System.out.println("id: " + password);
	            SQLConnection.SQLConnection_init();
	            if(SQLConnection.getUsername(name)==null || !SQLConnection.getPassword(name).equals(password)){
	            	next = "/login.jsp";
	            	System.out.println("user doesnt exist");
	            	request.setAttribute("signinerror", "User does not exist/ invalid username + password!!");
	            }
	            else{
		            HttpSession session = request.getSession(true);
		            session.setAttribute("username", name);
	            }
			}
            RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
    		dispatch.forward(request,response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
	}
}
