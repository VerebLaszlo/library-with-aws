<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Welcome</title>
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Books</h1>
        <c:forEach var="book" items="${books}">
            <div>
                <h2>${book.title}</h2>
                <div class="row">
                    <div class="column">
                        <img src="<c:url value="${book.coverUrl}"/>">
                    </div>
                    <div class="column">
                        <table>
                            <tr>
                            <th><span>Author</span></th>
                            <td><span>${book.author}</span></td>
                          </tr>
                          <tr>
                            <th><span>Publisher</span></th>
                            <td><span>${book.publisher}</span></td>
                          </tr>
                          <tr>
                            <th><span>Isbn</span></th>
                            <td><span>${book.isbn}</span></td>
                          </tr>
                        </table>
                    </div>
                </div>
                <hr>
            </div>
        </c:forEach>
    </div>
    <script src="js/main.js"></script>
</body>
