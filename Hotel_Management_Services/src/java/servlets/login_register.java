/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import support.Utilities;

/**
 *
 * @author Harsha SlimShady
 */
public class login_register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Utilities ut = new Utilities();
            Connection con = ut.getAcess();
            int flag = Integer.parseInt(request.getParameter("flag"));
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            if(flag==1){
                String name = request.getParameter("name");
                String phone_no = (String)request.getParameter("phone_no");
                int age = Integer.parseInt(request.getParameter("age"));
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                try{
                int id = ut.generateCustomerid();
                PreparedStatement pstm = con.prepareStatement("insert into customer values(?,?,?,?,?,?,?,?)");
                pstm.setInt(1,id);
                pstm.setString(2,name);
                pstm.setString(3,phone_no);
                pstm.setString(4,address);
                pstm.setString(5,email);
                pstm.setString(6,password);
                pstm.setInt(7,age);
                pstm.setString(8,gender);
                pstm.executeUpdate();
                response.sendRedirect("index.jsp?out=Sucessfully registered with email: "+email);
                }catch(SQLException e){
                    e.printStackTrace();
                    response.sendRedirect("index.jsp?out=Sign up failed!! Email or phone number aready used");
                }
            }else if(flag==2){
                PreparedStatement pstm = con.prepareStatement("select * from customer where cust_email=? and cust_password=?");
                pstm.setString(1,email);
                pstm.setString(2,password);
                ResultSet rs = pstm.executeQuery();
                if(rs.next()){
                    HttpSession session = request.getSession();
                    session.setAttribute("cust_id",rs.getInt(1));
                    session.setAttribute("cust_name",rs.getString(2));
                    response.sendRedirect("account.jsp");
                }else{
                    response.sendRedirect("index.jsp?out=Invalid Credentials");
                }
            }else if(flag==3){
                PreparedStatement pstm = con.prepareStatement("select * from admins natural join employee where employee.emp_email=? and employee.password=?");
                pstm.setString(1,email);
                pstm.setString(2,password);
                ResultSet rs = pstm.executeQuery();
                if(rs.next()){
                    HttpSession session = request.getSession();
                    session.setAttribute("emp_id",rs.getInt(1));
                    session.setAttribute("emp_name",rs.getString(3));
                    session.setAttribute("admin_type",rs.getString(2));
                    response.sendRedirect("admin.jsp");
                }else{
                    response.sendRedirect("index.jsp?out=Invalid Credentials");
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
            response.sendRedirect("index.jsp?out=Login failed! try again");
        }finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
