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
public class bookFood extends HttpServlet {

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
            Integer item_id = Integer.parseInt(request.getParameter("item_id"));
            Integer item_rate = Integer.parseInt(request.getParameter("item_rate"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select count(*)+1 from food_orders");
            rs.next();
            int order_id = rs.getInt(1);
            PreparedStatement pstm = con.prepareStatement("insert into food_orders(order_id,booking_id,item_id,item_quantity,amount,served,food_rating)\n" +
            "values(?,?,?,?,?,'0',null)");
            pstm.setInt(1,order_id);
            pstm.setInt(2,book_id);
            pstm.setInt(3,item_id);
            pstm.setInt(4,quantity);
            pstm.setInt(5,quantity*item_rate);
            pstm.execute();
            response.sendRedirect("foodbook.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(bookFood.class.getName()).log(Level.SEVERE, null, ex);
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
