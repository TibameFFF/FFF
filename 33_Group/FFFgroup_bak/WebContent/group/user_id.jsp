<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>

<jsp:useBean id="group" scope="session" class="com.group.model.GroupVO" />

<jsp:setProperty name="group" property="user_id" value="1"/>

<html>
<head><title>user_id.jsp</title></head>
<body>

<h3>user_id¡G${group.user_id}<br></h3>

</body>
</html>