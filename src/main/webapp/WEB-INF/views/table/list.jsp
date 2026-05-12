<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>테이블(TABLE)</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>테이블(TABLE)</h1>
    <table>
        <thead>
            <tr>
                <th>테이블 이름</th>
                <th>테이블 설명</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="table" items="${tables}">
                <tr>
                    <td><a href="/table/${table.name}">${table.name}</a></td>
                    <td>${table.description}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>