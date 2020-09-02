<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang=en>
<head>
    <title>Welcome</title>
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Books</h1>
        <c:forEach var="book" items="${books}">
            <div class="row">
                <div class="column">
                    <img src="<c:url value="${book.coverUrl}"/>" alt="Cover image">
                </div>
                <div class="column">
                    <table>
                      <caption>${book.title}</caption>
                      <tr>
                        <th id=authorHeader><span>Author</span></th>
                        <td><span>${book.author}</span></td>
                      </tr>
                      <tr>
                        <th id=publisherHeader><span>Publisher</span></th>
                        <td><span>${book.publisher}</span></td>
                      </tr>
                      <tr>
                        <th id=isbnHeader><span>Isbn</span></th>
                        <td><span>${book.isbn}</span></td>
                      </tr>
                    </table>
                </div>
                <hr>
            </div>
        </c:forEach>
    </div>
    <script src="js/main.js"></script>
</body>
