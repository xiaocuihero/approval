<%@ Page Language="C#" AutoEventWireup="true" CodeFile="approveflow.aspx.cs" Inherits="approveflow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            height: 18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <p style="font-size:x-large;text-align:center">审批进度表</p>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProducthead">  
    <tr style=" height:50px" > 
      <td width="20%" align="center" bgcolor="#EFEFEF" class="style1">流程名称</td>
      <td width="20%" align="center" bgcolor="#EFEFEF" class="style1">项目名称</td>
      <td width="8%" align="center" bgcolor="#EFEFEF" class="style1">经办人</td>
      <td width="8%" align="center" bgcolor="#EFEFEF" class="style1">负责人</td>
      <td width="8%" align="center" bgcolor="#EFEFEF" class="style1">开始时间</td>
      <td width="8%" align="center" bgcolor="#EFEFEF" class="style1">阶段截止时间</td>
      <td width="8%" align="center" bgcolor="#EFEFEF" class="style1">流程截止时间</td>
      <td width="20%" align="center" bgcolor="#EFEFEF" class="style1">进度</td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
