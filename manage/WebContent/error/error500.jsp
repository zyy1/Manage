<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css" />
<link href="${pageContext.request.contextPath }/css/error.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="content">
  <div id="content-header">
    <h1>Error 500</h1>
  </div>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="
glyphicon glyphicon-info-sign"></i> </span>
            <h5>Error 500</h5>
          </div>
          <div class="widget-content">
            <div class="error_ex">
              <h1>500</h1>
              <h3>Opps, You're lost.</h3>
              <p>We can not find the page you're looking for.</p>
              <a class="btn btn-success btn-big"  href="index.jsp">Back to Home</a> </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
