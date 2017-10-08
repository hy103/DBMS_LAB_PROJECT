/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package support;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Harsha SlimShady
 */
public class Utilities {
    public Connection getAcess(){
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/hms","root","Nstatehs_1");
        }catch(SQLException e){
            e.printStackTrace();
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
        return conn;
    }
    public int generateCustomerid(){
        int id = 0;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery("select count(*) from customer");
            rs.next();
            id=rs.getInt(1)+1;
        }catch(SQLException e){
            
        }
        return id;
    }
    public ResultSet getemployeeNumGroup(){
        ResultSet rs =null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("SELECT dept_name,count(*) FROM departments natural join employee group by dept_id");
            
        }catch(SQLException e){
            
        }
        return rs;
    }
    public int getemployeeNum(){
        int num=0;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery("select count(*) from employee");
            rs.next();
            num=rs.getInt(1);
        }catch(SQLException e){
            
        }
        return num;
    }
    public ResultSet getemployeeSet(){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from employee natural join departments left outer join jobs on(employee.job_id=jobs.job_id)");
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getdepartmentSet(){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from departments left outer join employee on(mgnr_id=emp_id)");
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getCompliants(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from complaints natural join booking where completed='0'");
            }else if(i==2){
            rs = s.executeQuery("select * from complaints natural join booking where completed='1'");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getCabbookings(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from cab_bookings inner join booking on(cab_bookings.booking_id=booking.booking_id) where received='0'");
            }else if(i==2){
            rs = s.executeQuery("select * from cab_bookings inner join booking on(cab_bookings.booking_id=booking.booking_id) where received='1'");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getServices(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("SELECT * FROM hms.service_orders inner join booking on(service_orders.booking_id=booking.booking_id) where served='0'");
            }else if(i==2){
            rs = s.executeQuery("SELECT * FROM hms.service_orders inner join booking on(service_orders.booking_id=booking.booking_id) where served='1'");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getuserBookings(int i,int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from booking where cust_id="+cust_id);
            }else if(i==2){
            rs = s.executeQuery("select * from bookings_history where cust_id="+cust_id);    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getuserBookings(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from booking natural join customer");
            }else if(i==2){
            rs = s.executeQuery("select * from bookings_history natural join customer");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getCabdetails(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from destinations");
            }else if(i==2){
            rs = s.executeQuery("select * from cab_category");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getCabdetails(int i,int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from cab_bookings inner join booking on(cab_bookings.booking_id=booking.booking_id) where received='0' and cust_id="+cust_id);
            }else if(i==2){
            rs = s.executeQuery("select * from cab_bookings inner join booking on(cab_bookings.booking_id=booking.booking_id) where received='1' and cust_id="+cust_id);    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getBookedrooms(int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from booking where cust_id="+cust_id);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rs;
    }
    public ResultSet getComplaintcat(){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from complaint_category");
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getuserComplaint(int i,int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from complaints natural join booking where completed='0' and cust_id="+cust_id);
            }else if(i==2){
            rs = s.executeQuery("select * from complaints natural join booking where completed='1' and cust_id="+cust_id);    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getServicescat(){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from services");
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getuserServices(int i,int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from service_orders inner join booking on(service_orders.booking_id=booking.booking_id) where served='0' and cust_id="+cust_id);
            }else if(i==2){
            rs = s.executeQuery("select * from service_orders inner join booking on(service_orders.booking_id=booking.booking_id) where served='1' and cust_id="+cust_id);    
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rs;
    }
    public ResultSet getfoodMenu(){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            rs = s.executeQuery("select * from food_items natural join food_category");
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getFoodbookings(int i){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from food_orders natural join food_items natural join booking where served='0'");
            }else if(i==2){
            rs = s.executeQuery("select * from food_orders natural join food_items natural join booking where served='1'");    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
    public ResultSet getuserFoodbookings(int i,int cust_id){
        ResultSet rs=null;
        try{
            Connection con = getAcess();
            Statement s = con.createStatement();
            if(i==1){
            rs = s.executeQuery("select * from food_orders natural join food_items natural join booking where served='0' and cust_id="+cust_id);
            }else if(i==2){
            rs = s.executeQuery("select * from food_orders natural join food_items natural join booking where served='1' and cust_id="+cust_id);    
            }
        }catch(SQLException e){
            
        }
        return rs;
    }
}
