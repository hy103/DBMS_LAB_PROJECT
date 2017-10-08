<%-- 
    Document   : hr
    Created on : Nov 8, 2016, 3:06:46 AM
    Author     : Harsha SlimShady
--%>

<%@page import="java.sql.Connection"%>
<%@page import="support.Utilities"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMINS | HSM</title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <style>
            #menu-list{
                margin: 0;
                height: 100%;
                background-color: #F8F8F8;
                color: #5E5E5E;
                padding: 0;
            }
            #menu-list li {
                display: block;
                font-size: 17px;
                padding: 10px;
                margin: 0;
            }
            #menu-list li:hover{
                background-color: #e5e5e5;
            }
            .menu_active{
                background-color: #e5e5e5;
            }
        </style>
    </head>
    <body style="font-family: 'Open Sans'">
        <%
            Integer emp_id = (Integer)session.getAttribute("emp_id");
            String emp_name = (String)session.getAttribute("emp_name");
            if(emp_id==null){
                response.sendRedirect("index.jsp");
            }
            Utilities ut = new Utilities();
        %>
        <nav class="navbar navbar-default navbar-fixed-top">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="index.jsp">Hotel Management Service</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">
                    <div class="dropdown">
                    <li data-toggle="dropdown"><a><%=emp_name%> <span class="caret"></span></a></li>
                    <ul class="dropdown-menu">
                        <li><a href="logout">Logout</a></li>
                    </ul>
                    </div>
                </a></li>
            </ul>
          </div>
        </nav>
        <div class="row" style="margin-top: 51px;">
            <div class="col-md-2" id="menu-list">
                <ul style="list-style: none" >
                    <li><i class="fa fa-superpowers" aria-hidden="true"></i><a href="admin.jsp"> Admin</a></li>
                    <li class="menu_active"><i class="fa fa-id-badge" aria-hidden="true"></i><a href="bookings.jsp"> Bookings</a></li>
                    <li><i class="fa fa-cutlery" aria-hidden="true"></i><a href="food.jsp"> Food & Beverages</a></li>
                    <li><i class="fa fa-line-chart" aria-hidden="true"></i><a href="hr.jsp"> HR</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="hr.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="hr.jsp"> Services</a></li>
                    <li><i class="fa fa-info" aria-hidden="true"></i><a href="complaints.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <h4>Bookings management panel</h4>
                <hr/>
                <div class="panel panel-default">
                    <div class="panel-heading">Welcome to room booking panel</div>
                    <div class="panel-body">
                        <ul class="nav nav-tabs">
                                <li class="active"><a href="#unsolved" data-toggle="tab">Current bookings</a>
                                </li>
                                <li><a href="#oldproblems" data-toggle="tab">Completed bookings</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="unsolved">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">List of all current bookings</div>
                                        <table class="table table-striped table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Booking ID</th>
                                                    <th>Room</th>
                                                    <th>Customer name</th>
                                                    <th>Check in date</th>
                                                    <th>Check out date</th>
                                                    <th>Room amount</th>
                                                    <th>Food amount</th>
                                                    <th>Service amount</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    ResultSet ry = ut.getuserBookings(1);
                                                    while(ry.next()){
                                                %>
                                                <tr>
                                                    <td><%=ry.getInt(2)%></td>
                                                    <td><%=ry.getString(3)%></td>
                                                    <td><%=ry.getString(12)%></td>
                                                    <td><%=ry.getDate(4)%></td>
                                                    <td><%=ry.getDate(5)%></td>
                                                    <td><%=ry.getInt(9)%></td>
                                                    <td><%=ry.getInt(10)%></td>
                                                    <td><%=ry.getInt(11)%></td>
                                                    <td>
                                                        <form action="checkOut" method="post">
                                                            <input type="hidden" name="book_id" value="<%=ry.getInt(2)%>">
                                                            <button type="submit" class="btn btn-default">Checkout</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="oldproblems">
                                    <p><div class="panel panel-default">
                                        <div class="panel-heading">List of all completed bookings</div>
                                        <table class="table table-striped table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Room</th>
                                                    <th>Customer name</th>
                                                    <th>Check in date</th>
                                                    <th>Days stayed</th>
                                                    <th>Room amount</th>
                                                    <th>Food amount</th>
                                                    <th>Service amount</th>
                                                    <th>Rating</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    ry = ut.getuserBookings(2);
                                                    while(ry.next()){
                                                %>
                                                <tr>
                                                    <td><%=ry.getString(3)%></td>
                                                    <td><%=ry.getString(12)%></td>
                                                    <td><%=ry.getDate(4)%></td>
                                                    <td><%=ry.getInt(5)%></td>
                                                    <td><%=ry.getInt(6)%></td>
                                                    <td><%=ry.getInt(7)%></td>
                                                    <td><%=ry.getInt(8)%></td>
                                                    <td><%=ry.getFloat(10)%></td>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
