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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.catalina.connector.Connector;
import support.Utilities;

/**
 *
 * @author Harsha SlimShady
 */
public class checkavail extends HttpServlet {

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
            String startdate = request.getParameter("startdate");
            String enddate = request.getParameter("enddate");
            Integer category = Integer.parseInt(request.getParameter("roomtype"));
            SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
            java.sql.Date sdate = new java.sql.Date(sd.parse(startdate).getTime());
            java.sql.Date edate = new java.sql.Date(sd.parse(enddate).getTime());
            PreparedStatement pstm = con.prepareStatement("select * from rooms natural join room_categories where rooms.room_no not in (select room_no from booking where (? between in_date and end_date) or (? between in_date and end_date) or (in_date>=? and end_date<=?)) and cat_id=?");
            pstm.setDate(1,sdate);
            pstm.setDate(2,edate);
            pstm.setDate(3,sdate);
            pstm.setDate(4,edate);
            pstm.setInt(5,category);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                rs.beforeFirst();
                HttpSession session = request.getSession();
                session.setAttribute("availlist",rs);
                session.setAttribute("sdate", startdate);
                session.setAttribute("edate",enddate);
            }
            response.sendRedirect("roombook.jsp");
        }catch(ParseException pe){}catch(SQLException e){} finally {
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
