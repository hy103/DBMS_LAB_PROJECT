<%-- 
    Document   : account
    Created on : Nov 9, 2016, 12:22:54 AM
    Author     : Harsha SlimShady
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="support.Utilities"%>
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
                    <li><i class="fa fa-cutlery" aria-hidden="true"></i><a href="foodbook.jsp"> Food & Beverages</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="cabbook.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="servicebook.jsp"> Services</a></li>
                    <li class="menu_active"><i class="fa fa-info" aria-hidden="true"></i><a href="lodgecomplaint.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Welcome to complaints lodging section.
                    </div>
                    <div class="panel-body">
                        <ul class="nav nav-tabs">
                                <li class="active"><a href="#home" data-toggle="tab">New complaints</a>
                                </li>
                                <li><a href="#profile" data-toggle="tab">current complaints</a>
                                </li>
                                <li><a href="#messages" data-toggle="tab">completed complaints</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="home">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Lodge a complaint if any</div>
                                        <div class="panel-body">
                                            <form action="newComplaint" method="post">
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
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Complaint category</label>
                                                        <select name="comp_cat" class="form-control">
                                                            <%
                                                            rs = ut.getComplaintcat();
                                                            while(rs.next()){
                                                                %>
                                                                <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                                                            <%
                                                            }
                                                            %>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label>Complaint description</label>
                                                        <textarea class="form-control" name="complaint"></textarea>
                                                    </div>
                                                </div>
                                                        <div class="col-md-12"><button class="btn btn-default center-block">Submit</button></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="profile">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">List of all unsolved complaints</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Room no</th>
                                                            <th>Complaint</th>
                                                            <th>Category</th>
                                                            <th>Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        rs = ut.getuserComplaint(1,cust_id);
                                                        while(rs.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=rs.getString(9)%></td>
                                                                <td><%=rs.getString(3)%></td>
                                                                <td><%=rs.getString(5)%></td>
                                                                <td><%=rs.getDate(4)%></td>
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
                                        <div class="panel-heading">List of all completed raids</div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Room no</th>
                                                            <th>Complaint</th>
                                                            <th>Category</th>
                                                            <th>Time</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        rs = ut.getuserComplaint(2,cust_id);
                                                        while(rs.next()){
                                                            %>
                                                            <tr>
                                                                <td><%=rs.getString(9)%></td>
                                                                <td><%=rs.getString(3)%></td>
                                                                <td><%=rs.getString(5)%></td>
                                                                <td><%=rs.getDate(4)%></td>
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
        </div>
        
    </body>
</html>
