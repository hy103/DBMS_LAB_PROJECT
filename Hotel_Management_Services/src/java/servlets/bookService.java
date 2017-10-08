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
import java.sql.SQLException;
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
public class bookService extends HttpServlet {

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
            String service = request.getParameter("service_cat");
            PreparedStatement pstm = con.prepareStatement("select count(*)+1 from service_orders");
            ResultSet rs = pstm.executeQuery();
            rs.next();
            int comp_id = rs.getInt(1);
            pstm = con.prepareStatement("select serv_rate,job_id from services where serv_name=?");
            pstm.setString(1,service);
            rs = pstm.executeQuery();
            rs.next();
            int job_id = rs.getInt(2);
            int serv_rate = rs.getInt(1);
            pstm = con.prepareStatement("insert into service_orders(order_id,booking_id,job_id,serv_name,amount,served,serv_rating) \n" +
            "values(?,?,?,?,?,'0',null)");
            pstm.setInt(1,comp_id);
            pstm.setInt(2,book_id);
            pstm.setInt(3,job_id);
            pstm.setString(4,service);
            pstm.setInt(5,serv_rate);
            pstm.execute();
            response.sendRedirect("servicebook.jsp");
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
