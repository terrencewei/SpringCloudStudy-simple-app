<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
</head>
<body>
<%@ include file="./header.jsp" %>
<br/>
<table>
    <thead>
    <tr>
        <td>product id</td>
        <td>name</td>
        <td>price</td>
        <td>stock</td>
        <td>priority</td>
        <td>createdDate</td>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${productResult.pageProducts_es.content}">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.stock}</td>
            <td>${product.priority}</td>
            <td>${product.createdDate}</td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="3">
            Rank:<br/>
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=id&sortValue=asc">Id ASC</a> &nbsp;
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=id&sortValue=desc">Id DESC</a>&nbsp;
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=priority&sortValue=asc">Priority ASC</a>&nbsp;
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=priority&sortValue=desc">Priority DESC</a>&nbsp;
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=createdDate&sortValue=asc">CreatedDate ASC</a>&nbsp;
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&sortName=createdDate&sortValue=desc">CreatedDate DESC</a>&nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="3">

            <c:if test="${not empty productResult.request.sortName}">
                <c:set var="sortQuery" value="&sortName=${productResult.request.sortName}&sortValue=${productResult.request.sortValue}"/>
            </c:if>


            Total items:${productResult.pageProducts_es.totalElements}, Page:${productResult.request.page}/${productResult.pageProducts_es.totalPages }
            <br/>
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=1${sortQuery}">First</a>

            <c:if test="${productResult.request.page==1}">
                <c:forEach begin="${1}" end="${productResult.pageProducts_es.totalPages>=4?4:productResult.pageProducts_es.totalPages}" step="1" var="i">
                    <c:if test="${productResult.request.page == i}">
                        ${i}
                    </c:if>
                    <c:if test="${productResult.request.page != i}">
                        <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${i}${sortQuery}">${i}</a>
                    </c:if>
                </c:forEach>
                <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${productResult.request.page+1}${sortQuery}">Next</a>
            </c:if>

            <c:if test="${productResult.request.page > 1 && productResult.request.page < productResult.pageProducts_es.totalPages}">
                <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${productResult.request.page-1}${sortQuery}">Previous</a>
                <c:forEach begin="${productResult.request.page>4?productResult.request.page-4:1}" end="${productResult.request.page+4>productResult.pageProducts_es.totalPages?productResult.pageProducts_es.totalPages:productResult.request.page+4}" step="1" var="i">
                    <c:if test="${productResult.request.page == i}">
                        ${i}
                    </c:if>
                    <c:if test="${productResult.request.page != i}">
                        <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${i}${sortQuery}">${i}</a>
                    </c:if>
                </c:forEach>
                <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${productResult.request.page+1}${sortQuery}">Next</a>
            </c:if>

            <c:if test="${productResult.pageProducts_es.totalPages==productResult.request.page}">
                <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${productResult.request.page-1}${sortQuery}">Previous</a>
                <c:forEach begin="${productResult.request.page>4?productResult.request.page-4:1}" end="${productResult.pageProducts_es.totalPages}" step="1" var="i">
                    <c:if test="${productResult.request.page == i}">
                        ${i}
                    </c:if>
                    <c:if test="${productResult.request.page != i}">
                        <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${i}${sortQuery}">${i}</a>
                    </c:if>
                </c:forEach>
            </c:if>
            <a href="/product/search_es?productId=${productResult.request.productId}&name=${productResult.request.name}&page=${productResult.pageProducts_es.totalPages}${sortQuery}">last</a>


        </td>
    </tr>
    </tfoot>
</table>

</body>
</html>