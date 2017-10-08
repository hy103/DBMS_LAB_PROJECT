<%--
    Document   : hr
    Created on : Nov 8, 2016, 3:06:46 AM
    Author     : Harsha SlimShady
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="support.Utilities"%>
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
            String admin_type = (String)session.getAttribute("admin_type");
            if(admin_type.equals("FOOD")) response.sendRedirect("food.jsp");
            if(admin_type.equals("SERVICES")) response.sendRedirect("services.jsp");
            if(admin_type.equals("BOOKINGS")) response.sendRedirect("bookings.jsp");
            if(admin_type.equals("COMPLAINTS")) response.sendRedirect("complaints.jsp");
            if(admin_type.equals("CAB")) response.sendRedirect("cabs.jsp");
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
                    <li><i class="fa fa-id-badge" aria-hidden="true"></i><a href="bookings.jsp"> Bookings</a></li>
                    <li><i class="fa fa-cutlery" aria-hidden="true"></i><a href="food.jsp"> Food & Beverages</a></li>
                    <li class="menu_active"><i class="fa fa-line-chart" aria-hidden="true"></i><a href="hr.jsp"> HR</a></li>
                    <li><i class="fa fa-taxi" aria-hidden="true"></i><a href="cabs.jsp"> Cabs</a></li>
                    <li><i class="fa fa-cogs" aria-hidden="true"></i><a href="services.jsp"> Services</a></li>
                    <li><i class="fa fa-info" aria-hidden="true"></i><a href="complaints.jsp"> Complaints</a></li>
                </ul>
            </div>
            <div class="col-md-10">
                <h4>Human Resources Department</h4>
                <hr/>
                <div class="panel panel-default">
                        <div class="panel-heading">Welcome to HR panel</div>
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#employee" data-toggle="tab">Employees</a>
                                </li>
                                <li><a href="#departments" data-toggle="tab">departments</a>
                                </li>
                                <li><a href="#addemp" data-toggle="tab">New employee</a>
                                </li>
                                <li><a href="#managers" data-toggle="tab">Managers</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="employee">
                                    <div class="panel panel-default">
                                    <div class="panel-heading">List of all Employees</div>
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Salary</th>
                                                        <th>Department</th>
                                                        <th>Job</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        ResultSet rs = ut.getemployeeSet();
                                                        while(rs.next()){
                                                            %>
                                                    <tr>
                                                        <td><%=rs.getInt(2)%></td>
                                                        <td><%=rs.getString(3)%></td>
                                                        <td><%=rs.getString(5)%></td>
                                                        <td><%=rs.getInt(8)%></td>
                                                        <td><%=rs.getString(10)%></td>
                                                        <td><%=rs.getString(13)%></td>
                                                        <td>
                                                            <form action="deleteEmp" method="post">
                                                                <input type="hidden" name="emp_id" value="<%=rs.getInt(2)%>">
                                                                <button class="btn btn-default">Delete</button>
                                                            </form>
                                                        </td>
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
                                <div class="tab-pane fade" id="departments">
                                    <div class="panel panel-default">
                                    <div class="panel-heading">List of all Employees</div>
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Department</th>
                                                        <th>Manager</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        ResultSet ry = ut.getdepartmentSet();
                                                        while(ry.next()){
                                                            %>
                                                    <tr>
                                                        <td><%=ry.getInt(1)%></td>
                                                        <td><%=ry.getString(2)%></td>
                                                        <td><%=ry.getString(5)%></td>
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
                                <div class="tab-pane fade" id="addemp">
                                    <div class="panel panel-default" style="width: 50%;align-content: center">
                                <div class="panel-body">
                                    <form role="form"  action="new_employee" method="post">
                                  <div class="form-group">
                                    <label for="name">Name*</label>
                                    <input type="text" class="form-control" name="name" placeholder="Enter name" required>
                                  </div>
                                  <div class="form-group">
                                    <label for="phone">Phone number*</label>
                                    <input type="number" class="form-control" name="phone_no" placeholder="Contact number" required>
                                  </div>
                                  <div class="form-group">
                                    <label for="Email1">Email*</label>
                                    <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                                  </div>
                                  <div class="form-group">
                                    <label for="Password">Password*</label>
                                    <input type="password" id="password" class="form-control" name="password" placeholder="Password" required>
                                    <span id="result"></span>
                                  </div>
                                  <div class="form-group">
                                    <label for="age">Salary*</label>
                                    <input type="number" class="form-control" name="salary" placeholder="Enter Salary" required>
                                  </div>
                                  <div class="form-group">
                                    <label for="name">Department*</label>
                                    <select class="form-control" name="department" required>
                                        <option value="1">HR</option>
                                        <option value="2">FOOD AND BEVERAGES</option>
                                        <option value="3">SERVICES</option>
                                        <option value="4">DESK</option>
                                        <option value="5">MAINTAINENCE</option>
                                    </select>
                                  </div>
                                  <div class="form-group">
                                    <label for="address">Address*</label>
                                    <textarea class="form-control" rows="5" name="address" required></textarea>
                                  </div>
                                  <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok-circle"></span> Create account</button>
                                  <input type="hidden" value="1" name="flag">
                                    </form>
                                </div>
                            </div>
                                </div>
                                <div class="tab-pane fade" id="managers">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Change your Managers</div>
                                        <div class="panel-body">
                                            
                                            <form action="managerChange" method="post">
                                                <div class="form-group">
                                                    <label>HUMAN RESOURCES : select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                    <select name="name">
                                                        <%
                                                        rs.beforeFirst();
                                                        while(rs.next()){
                                                            if(rs.getInt(1)==1){
                                                            %>
                                                            <option value="<%=rs.getInt(2)%>"><%=rs.getString(3)%></option>
                                                        <%
                                                        }}
                                                        %>
                                                    </select>
                                                </div>
                                                        <input type="hidden" value="1"  name="dept_id">
                                                        <button class="btn btn-default">Change</button>
                                            </form>
                                            <form action="managerChange" method="post">
                                                <div class="form-group">
                                                    <label>FOOD AND BEVERAGES : select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                    <select name="name">
                                                        <%
                                                        rs.beforeFirst();
                                                        while(rs.next()){
                                                        if(rs.getInt(1)==1){
                                                            %>
                                                            <option value="<%=rs.getInt(2)%>"><%=rs.getString(3)%></option>
                                                        <%
                                                        }}
                                                        %>
                                                    </select>
                                                            <input type="hidden" value="2" name="dept_id">
                                                            <button class="btn btn-default">Change</button>
                                                </div>
                                            </form>
                                            <form action="managerChange" method="post">
                                                <div class="form-group">
                                                    <label>SERVICES : select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                    <select name="name">
                                                        <%
                                                        rs.beforeFirst();
                                                        while(rs.next()){
                                                            if(rs.getInt(1)==1){
                                                            %>
                                                            <option value="<%=rs.getInt(2)%>"><%=rs.getString(3)%></option>
                                                        <%
                                                        }}
                                                        %>

                                                    </select>
                                                        <input type="hidden" value="3" name="dept_id">
                                                        <button class="btn btn-default">Change</button>
                                                </div>
                                            </form>
                                            <form action="managerChange" method="post">
                                                <div class="form-group">
                                                    <label>DESK : select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                    <select name="name">
                                                        <%
                                                        rs.beforeFirst();
                                                        while(rs.next()){
                                                            if(rs.getInt(1)==1){
                                                            %>
                                                            <option value="<%=rs.getInt(2)%>"><%=rs.getString(3)%></option>
                                                        <%
                                                        }}
                                                        %>
                                                    </select>
                                                    <input type="hidden" value="4" name="dept_id">
                                                    <button class="btn btn-default">Change</button>
                                                </div>
                                            </form>
                                            <form action="managerChange" method="post">
                                                <div class="form-group">
                                                    <label>MAINTENANCE : select &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                    <select name="name">
                                                        <%
                                                        rs.beforeFirst();
                                                        while(rs.next()){
                                                            if(rs.getInt(1)==1){
                                                            %>
                                                            <option value="<%=rs.getInt(2)%>"><%=rs.getString(3)%></option>
                                                        <%
                                                        }}
                                                        %>
                                                    </select>
                                                    <input type="hidden" value="5" name="dept_id">
                                                    <button class="btn btn-default">Change</button>
                                                </div>
                                            </form>
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
