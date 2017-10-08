/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import support.Utilities;

/**
 *
 * @author Harsha SlimShady
 */
public class bookRoom extends HttpServlet {

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
            Integer cust_id = Integer.parseInt(request.getParameter("cust_id"));
            String startdate = request.getParameter("sdate");
            String enddate = request.getParameter("edate");
            Integer rate = Integer.parseInt(request.getParameter("rate"));
            SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
            java.sql.Date sdate = new java.sql.Date(sd.parse(startdate).getTime());
            java.sql.Date edate = new java.sql.Date(sd.parse(enddate).getTime());
            String room_no = request.getParameter("room");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select count(*)+1 from booking");
            rs.next();
            int booking_id = rs.getInt(1);
            String q = "insert into booking(booking_id,cust_id,room_no,in_date,end_date,room_rate,job_id,room_amount,food_amount,service_amount) \n" +
            "values(?,?,?,?,?,?,4,?*datediff(?,?),0,0)";
            PreparedStatement pstm = con.prepareStatement(q);
            pstm.setInt(1,booking_id);
            pstm.setInt(2,cust_id);
            pstm.setString(3,room_no);
            pstm.setDate(4,sdate);
            pstm.setDate(5,edate);
            pstm.setInt(6,rate);
            pstm.setInt(7,rate);
            pstm.setDate(8,edate);
            pstm.setDate(9,sdate);
            pstm.execute();
            response.sendRedirect("roombook.jsp");
        }catch(ParseException pe){
            pe.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
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
