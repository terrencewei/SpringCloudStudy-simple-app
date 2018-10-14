<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.aaxis.microservice.training.demo1.service.FeignCatalogServiceProxy" %>
<%-- <<<<<<<<<<<< origin --%>
<%--<%@ page import="com.aaxis.microservice.training.demo1.service.CategoryService" %>--%>
<%-- ============ --%>
<%@ page import="com.aaxis.microservice.training.demo1.util.SpringUtil" %>
<%-- >>>>>>>>>>>> terrencewei updated --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
</head>
<body>
Username: ${user.username} <br/>
<a href="/logout">Logout</a> &nbsp;
<a href="/regist">Regist</a> &nbsp;
<a href="/login">SignIn</a> &nbsp;
<a href="/product/searchPage">Product Search</a> <br/>
<%
    // <<<<<<<<<<<< origin
    //    request.setAttribute("allCategories",((CatalogService)SpringUtil.getBean("catalogService")).findAllCategories());
    // ============
    FeignCatalogServiceProxy proxy = (FeignCatalogServiceProxy) SpringUtil.getBean("feignCatalogServiceProxy");
    if (proxy == null) {
        System.out.println("cannot get feignCatalogService");
    } else {
        request.setAttribute("allCategories", proxy.findAllCategories());
    }
    // >>>>>>>>>>>> terrencewei updated
    System.out.println("header.jsp:"+request.getAttribute("allCategories"));
%>

Category:<br/>
<c:forEach var="category" items="${allCategories}">
    <a href="/category/${category.id}/1">${category.name}</a> &nbsp;&nbsp;&nbsp;
</c:forEach>
<br/>

</body>
</html>