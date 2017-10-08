<%-- 
    Document   : account
    Created on : Nov 9, 2016, 12:22:54 AM
    Author     : Harsha SlimShady
--%>

<%@page import="support.Utilities"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>USERS | HSM</title>
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
            Integer cust_id = (Integer)session.getAttribute("cust_id");
            String cust_name = (String)session.getAttribute("cust_name");
            if(cust_id==null){
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
                    <li data-toggle="dropdown"><a><%=cust_name%> <span class="caret"></span></a></li>
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
                    <li><i class="fa fa-superpowers" aria-hidden="true"></i><a href="account.jsp"> Account</a></li>
                    <li class="menu_active"><i class="fa fa-id-badge" aria-hidden="true"></i><a href="roombook.jsp"> Bookings</a></li>
                    <li><i class="fa fa-cutlery" aria-hidden="true"></i><a href="foodbook.jsp"> Food & Beverages</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="cabbook.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="servicebook.jsp"> Services</a></li>
                    <li><i class="fa fa-info" aria-hidden="true"></i><a href="lodgecomplaint.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <div class="panel panel-default">
                        <div class="panel-heading">Manage your bookings here</div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#home" data-toggle="tab">Check availability</a>
                                </li>
                                <li><a href="#profile" data-toggle="tab">Current records</a>
                                </li>
                                <li><a href="#tab3" data-toggle="tab">Old records</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="home">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Room availability</div>
                                        <div class="panel-body">
                                            <form method="get" action="checkavail">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label>Start date :</label>
                                                    <input type="date" class="form-control" name="startdate">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label>End date :</label>
                                                    <input type="date" class="form-control" name="enddate">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label>Room Type</label>
                                                    <select name="roomtype" class="form-control">
                                                        <option value="6">--SELECT--</option>
                                                        <option value="4">STANDARD</option>
                                                        <option value="1">COMFORT</option>
                                                        <option value="3">LUXURY</option>
                                                        <option value="2">KING</option>
                                                        <option value="5">SUITE</option>
                                                    </select>
                                                </div>
                                            </div>
                                                <div class="col-md-12"><button class="btn btn-default center-block">CHECK</button></div>
                                                
                                            </form>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Results (<%=session.getAttribute("sdate")+" - "+session.getAttribute("edate")%>)</div>
                                        <div class="panel-body">
                                            <%
                                            if((ResultSet)session.getAttribute("availlist")!=null){
                                                ResultSet rs =(ResultSet)session.getAttribute("availlist");
                                            %>
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Room no</th>
                                                            <th>Category</th>
                                                            <th>Rate per day</th>
                                                            <th>Rating</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        while(rs.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=rs.getString(2)%></td>
                                                                <td><%=rs.getString(4)%></td>
                                                                <td><%=rs.getInt(5)%></td>
                                                                <td><%=rs.getFloat(3)%></td>
                                                                <td>
                                                                    <form method="post" action="bookRoom">
                                                                        <input type="hidden" name="cust_id" value="<%=cust_id%>">
                                                                        <input type="hidden" name="sdate" value="<%=session.getAttribute("sdate")%>">
                                                                        <input type="hidden" name="edate" value="<%=session.getAttribute("edate")%>">
                                                                        <input type="hidden" name="rate" value="<%=rs.getInt(5)%>">
                                                                        <input type="hidden" name="room" value="<%=rs.getString(2)%>">
                                                                        <button type="submit" class="btn btn-default">Book now</button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        <%
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%
                                                session.setAttribute("availlist",null);
                                                session.setAttribute("sdate", null);
                                                session.setAttribute("edate",null);
                                            }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="profile">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Current bookings</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Booking ID</th>
                                                            <th>Room no</th>
                                                            <th>Start date</th>
                                                            <th>End date</th>
                                                            <th>Room amount</th>
                                                            <th>Food amount</th>
                                                            <th>Service amount</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        ResultSet ry = ut.getuserBookings(1,cust_id);
                                                        while(ry.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=ry.getInt(1)%></td>
                                                                <td><%=ry.getString(3)%></td>
                                                                <td><%=ry.getDate(4)%></td>
                                                                <td><%=ry.getDate(5)%></td>
                                                                <td><%=ry.getInt(9)%></td>
                                                                <td><%=ry.getInt(10)%></td>
                                                                <td><%=ry.getInt(11)%></td>
                                                            </tr>
                                                        <%
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="tab-pane fade" id="tab3">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Past bookings</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <td>Booking ID</td>
                                                            <th>Room no</th>
                                                            <th>Start date</th>
                                                            <th>End date</th>
                                                            <th>Room amount</th>
                                                            <th>Food amount</th>
                                                            <th>Service amount</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        ry = ut.getuserBookings(2,cust_id);
                                                        while(ry.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=ry.getInt(1)%></td>
                                                                <td><%=ry.getString(3)%></td>
                                                                <td><%=ry.getDate(4)%></td>
                                                                <td><%=ry.getInt(5)%></td>
                                                                <td><%=ry.getInt(6)%></td>
                                                                <td><%=ry.getInt(7)%></td>
                                                                <td><%=ry.getInt(8)%></td>
                                                            </tr>
                                                        <%
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>       
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
            </div>
        </div>
        
    </body>
</html>
