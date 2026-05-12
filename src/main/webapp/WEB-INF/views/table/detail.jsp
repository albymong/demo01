<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>테이블 상세</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>테이블 상세 - ${tableName}</h1>
    <p><strong>테이블 코멘트:</strong> ${columns[0].tableComment}</p>
    <table>
        <thead>
            <tr>
                <th>테이블이름</th>
                <th>컬럼명</th>
                <th>컬럼코멘트</th>
                <th>Data Type</th>
                <th>Not Null</th>
                <th>Default</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="col" items="${columns}">
                <tr>
                    <td>${tableName}</td>
                    <td>${col.name}</td>
                    <td>${col.description}</td>
                    <td>${col.price}</td>
                    <td>${col.createdAt}</td>
                    <td>${col.columnDefault}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <br>
    <a href="/table">테이블 목록으로</a>
</body>
</html>