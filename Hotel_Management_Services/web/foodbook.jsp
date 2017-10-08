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
                    <li><i class="fa fa-id-badge" aria-hidden="true"></i><a href="roombook.jsp"> Bookings</a></li>
                    <li class="menu_active"><i class="fa fa-cutlery" aria-hidden="true"></i><a href="foodbook.jsp"> Food & Beverages</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="cabbook.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="servicebook.jsp"> Services</a></li>
                    <li><i class="fa fa-info" aria-hidden="true"></i><a href="lodgecomplaint.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Welcome to Food and beverages section.
                    </div>
                    <div class="panel-body">
                        <ul class="nav nav-tabs">
                                <li class="active"><a href="#home" data-toggle="tab">Food Menu</a>
                                </li>
                                <li><a href="#profile" data-toggle="tab">current food orders</a>
                                </li>
                                <li><a href="#messages" data-toggle="tab">completed orders</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="home">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Menu</div>
                                        <div class="panel-body">
                                            <%
                                            if(request.getParameter("item_id")==null){
                                            %>
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Item name</th>
                                                            <th>Item rate</th>
                                                            <th>Item rating</th>
                                                            <th>category</th>
                                                            <th>Timings</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        ResultSet rs = ut.getfoodMenu();
                                                        while(rs.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=rs.getString(3)%></td>
                                                                <td><%=rs.getInt(4)%></td>
                                                                <td><%=rs.getFloat(5)%></td>
                                                                <td><%=rs.getString(6)%></td>
                                                                <td><%=rs.getInt(7)%> - <%=rs.getInt(8)%></td>
                                                                <td>
                                                                    <form action="foodbook.jsp" method="post">
                                                                        <input type="hidden" value="<%=rs.getInt(2)%>" name="item_id">
                                                                        <input type="hidden" value="<%=rs.getInt(4)%>" name="item_rate">
                                                                        <input type="hidden" value="<%=rs.getString(3)%>" name="item_name">
                                                                        <button class="btn btn-default">Order</button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        <%
                                                        }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <%}
                                            else{
                                            %>
                                            <h6>confirm order for <%=request.getParameter("item_name")%></h6>
                                            <form action="bookFood" method="post">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Quantity</label>
                                                    <input type="number" class="form-control" name="quantity">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Room</label>
                                                    <select name="book_id" class="form-control">
                                                        <%
                                                            ResultSet rs = ut.getBookedrooms(cust_id);
                                                            while(rs.next()){
                                                                %>
                                                                <option value="<%=rs.getInt(1)%>"><%=rs.getString(3)%></option>
                                                                <%
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                                    <input type="hidden" value="<%=request.getParameter("item_id")%>" name="item_id">
                                                    <input type="hidden" value="<%=request.getParameter("item_rate")%>" name="item_rate">
                                                    <button class="btn btn-default center-block">Complete order</button>
                                            </form>
                                            <%
                                            }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="profile">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">List of all pending orders</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <th>Item</th>
                                                        <th>Room no</th>
                                                        <th>Quantity</th>
                                                        <th>Amount</th>
                                                        <th>Time</th>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        ResultSet ry = ut.getuserFoodbookings(1,cust_id);
                                                        while(ry.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=ry.getString(9)%></td>
                                                                <td><%=ry.getString(14)%></td>
                                                                <td><%=ry.getInt(4)%></td>
                                                                <td><%=ry.getInt(5)%></td>
                                                                <td><%=ry.getDate(6)%></td>
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
                                <div class="tab-pane fade" id="messages">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">List of all completed orders</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <th>Item</th>
                                                        <th>Room no</th>
                                                        <th>Quantity</th>
                                                        <th>Amount</th>
                                                        <th>Time</th>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        ry = ut.getuserFoodbookings(2,cust_id);
                                                        while(ry.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=ry.getString(9)%></td>
                                                                <td><%=ry.getString(14)%></td>
                                                                <td><%=ry.getInt(4)%></td>
                                                                <td><%=ry.getInt(5)%></td>
                                                                <td><%=ry.getDate(6)%></td>
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
                </div>
            </div>
        </div>
        
    </body>
</html>
