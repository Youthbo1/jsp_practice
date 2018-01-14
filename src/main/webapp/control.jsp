<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/14
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp"
         import="com.DBUtil,com.Emp" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%= response.getCharacterEncoding()%>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");

    Emp emp = new Emp(account, null, password, null);
    boolean flag = DBUtil.selectEmpByAccountAndPassword(emp);
    Map<String,Emp> map = DBUtil.map;


    if (flag) {

        Object o = application.getAttribute("count");
        if(o == null){
            application.setAttribute("count", 1);

        }else{
            int count = Integer.parseInt(o.toString());
            application.setAttribute("count", count + 1);

        }

        session.setAttribute("account",account);
%>
<h3 align="right"><%=session.getAttribute("account")%></h3>
<h3 align="right">登录账户：<%= session.getAttribute("account") %></h3>
<h3 align="center">欢迎来到人事管理系统的首页</h3>
<hr>
<table align="center" border="1" width="500px">
    <tr>
        <td>
            账号
        </td>
        <td>
            员工姓名
        </td>
        <td>
            邮箱
        </td>
        <td>
            修改
        </td>
    </tr>
    <%
        for (String key : map.keySet()) {
            Emp e = map.get(key);
    %>
    <tr>
        <td>
            <%= e.getAccount() %>
        </td>
        <td>
            <%= e.getName() %>
        </td>
        <td>
            <%= e.getEmail() %>
        </td>
        <td>
            <!--
            相邻两个JSP页面传递数据的时候。通过URL参数的方式来传递数据。
            规则：
            资源?key=value&key=value
             -->
            <a href="update.jsp?account=<%= e.getAccount() %>&name=<%= e.getName() %>&email=<%= e.getEmail() %>">修改</a>
        </td>
    </tr>
    <%

        }
    %>
</table>
<%

       // out.print("true");

       }else{
    throw new Exception("账号和密码错误");
    }


%>

</body>
</html>
