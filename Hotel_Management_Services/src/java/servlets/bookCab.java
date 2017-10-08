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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import support.Utilities;

/**
 *
 * @author Harsha SlimShady
 */
public class bookCab extends HttpServlet {

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
            Integer book_id = Integer.parseInt(request.getParameter("book_id"));
            String destination = request.getParameter("destination");
            String roomtype = request.getParameter("roomtype");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select count(*)+1 from cab_bookings");
            rs.next();
            int cab_book_id = rs.getInt(1);
            PreparedStatement pstm = con.prepareStatement("select (rate_per_km*sest_distance) from cab_category,destinations where cat_name=? and dest_name=?");
            pstm.setString(1,roomtype);
            pstm.setString(2,destination);
            rs = pstm.executeQuery();
            rs.next();
            int amount = rs.getInt(1);
            PreparedStatement cstm = con.prepareStatement("insert into cab_bookings(cab_book_id,booking_id,cat_name,dest_name,amount,received,rating,job_id)\n" +
            "values(?,?,?,?,?,'0',null,9)");
            cstm.setInt(1,cab_book_id);
            cstm.setInt(2,book_id);
            cstm.setString(3,roomtype);
            cstm.setString(4,destination);
            cstm.setInt(5,amount);
            cstm.execute();
            response.sendRedirect("cabbook.jsp");
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
