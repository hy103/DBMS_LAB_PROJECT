<%--
    Document   : index
    Created on : Nov 6, 2016, 11:43:49 AM
    Author     : Harsha SlimShady
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOME | HMS</title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/passwordCheck.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body style="font-family: 'Open Sans'">
        <nav class="navbar navbar-default">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="index.jsp">Hotel Management Service</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li data-toggle="modal" data-target="#emplogin"><a href="#"><i class="fa fa-sign-in"></i> Management Login</a></li>
            </ul>
          </div>
        </nav>
        <div id="emplogin" class="modal fade" role="dialog">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Management login!</h4>
              </div>
              <div class="modal-body">
                <div class="panel panel-default">
                        <div class="panel-heading"><h3 class="panel-title"><strong>Log in with your credentials.</strong></h3></div>
                        <div class="panel-body">
                            <form role="form" action="login_register" method="post">
                          <div class="form-group">
                            <label for="Email1">Employee mail*</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                          </div>
                          <div class="form-group">
                            <label for="Password">Password*</label>
                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                          </div>
                          <input type="hidden" value="3" name="flag">
                          <button type="submit" class="btn btn-sm btn-default">Sign in</button>
                            </form>
                        </div>
                    </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>
        <div class="container" id="login_sin">
            <div class="row">
                <div class="col-md-6">
                    <div class="panel-heading"><h2><strong>Create a new account.</strong></h2><p>It's free and always will be.</p></div>
                    <button class="btn btn-block btn-default btn-lg" data-toggle="modal" data-target="#signup"><span class="glyphicon glyphicon-send"></span> Sign up</button>
                    <div id="signup" class="modal fade" role="dialog">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><strong>Fill all the details.</strong></h4>
                          </div>
                          <div class="modal-body">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form role="form"  action="login_register" method="post">
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
                                    <label for="age">Age*</label>
                                    <input type="number" class="form-control" name="age" placeholder="Enter age" required>
                                  </div>
                                  <div class="form-group">
                                    <label for="name">Gender*</label>
                                    <select class="form-control" name="gender" required>
                                        <option value="M">Male</option>
                                        <option value="F">Female</option>
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
                        </div>
                      </div>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading"><h3 class="panel-title"><strong>Already a member login here!</strong></h3></div>
                        <div class="panel-body">
                            <form role="form" action="login_register" method="post">
                          <div class="form-group">
                            <label for="Email1">Email*</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                          </div>
                          <div class="form-group">
                            <label for="Password">Password*</label>
                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                          </div>
                          <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-log-in"></span> Sign in</button>
                          <input type="hidden" value="2" name="flag">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            String message = request.getParameter("out");
            if(message==null||message==""){}else{
                %>
                <div class="container text-center">
                    <h3><%=message%></h3>
                </div>
        <%
            }
        %>
        <script src="js/passwordCheck.js"></script>
    </body>
</html>
