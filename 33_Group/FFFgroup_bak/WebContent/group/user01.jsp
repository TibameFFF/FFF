<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>

<%
    GroupService groupSvc = new GroupService();
    List<GroupVO> list1 = groupSvc.getAllFromState_no(1);
    pageContext.setAttribute("list1",list1);
    
    List<GroupVO> list2 = groupSvc. getAllFromState_no(2);
    pageContext.setAttribute("list2",list2);
    
    List<GroupVO> list3 = groupSvc.getAllFromState_no(3);
    pageContext.setAttribute("list3",list3);
    
    List<GroupVO> list0 = groupSvc.getAllFromState_no(0);
    pageContext.setAttribute("list0",list0);  
    
    MemberService memberSvc = new MemberService();
    List<MemberVO> listm =memberSvc.find_User_ID_M(1);
        
%>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<p>
<c:forEach var="mygroup"  items="${listm}">
 ${GroupVO.findByPrimaryKey(mygroup.g_no)}
</c:forEach>
</p>
</body>
</html>