<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>컬럼 목록</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>컬럼 목록 - ${tableName}</h1>
    <table>
        <thead>
            <tr>
                <th>컬럼명</th>
                <th>타입</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="col" items="${columns}">
                <tr>
                    <td>${col.name}</td>
                    <td>${col.description}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <br>
    <a href="/table">테이블 목록으로</a>
</body>
</html>