<%@ Page Title="主页" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="jquery.min.js"></script>
    <script type="text/javascript">
        function preview() {
            bdhtml = window.document.body.innerHTML;
            sprnstr = "<!--startprint-->";
            eprnstr = "<!--endprint-->";
            prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
            prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
            window.document.body.innerHTML = prnhtml;
            window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="true" Height="16px"
            Width="240px">
            <asp:ListItem>分部分项工程量清单及计价表</asp:ListItem>
            <asp:ListItem>技术措施项目清单及计价表</asp:ListItem>
            <asp:ListItem>单位工程报价汇总表</asp:ListItem>
            <asp:ListItem>工程项目报价汇总表</asp:ListItem>
            <asp:ListItem>组织措施项目（整体）清单及计价表</asp:ListItem>
            <asp:ListItem>工程形象进度完成情况</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp; 选择导入文件：<asp:FileUpload ID="FileUpload1" runat="server" />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnImpot" Text="导入Excel" OnClick="btnImpot_Click"
            Height="27px" Width="79px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"
            AutoPostBack="true">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="Submit3" value="提交" onclick="GetTableData(document.getElementById('billhead'),document.getElementById('tabProduct'));return false;"
            style="height: 26px; width: 90px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
                type="button" name="Submit3" value="打印预览" onclick="preview();" style="height: 26px;
                width: 90px" /><br />
        <br />
        &nbsp;<br />
        <!--startprint-->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="billhead">
            <tr>
                <td width="100%" colspan="11" style="font-size: xx-large" align="center" name="billname"
                    edittype="TextBox">
                    表1-2 分部分项工程量清单及计价表( 号清单)
                </td>
            </tr>
            <tr>
                <td width="100%" colspan="11" align="left" name="dname" edittype="TextBox">
                    <%=unitpname%>
                </td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProducthead">
            <tr>
                <td width="0.5%" align="center" bgcolor="#EFEFEF" name="Num">
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="3.5%" align="center" bgcolor="#EFEFEF">
                    序号
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    项目编码
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    项目名称
                </td>
                <td width="23.5%" align="center" bgcolor="#EFEFEF">
                    项目特征描述
                </td>
                <td width="5%" align="center" bgcolor="#EFEFEF">
                    计量单位
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    清单工程量
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    上报完成工程量
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    至上月累计完成工程量
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    监理审核工程量
                </td>
                <td width="7.5%" align="center" bgcolor="#EFEFEF">
                    综合单价（元）
                </td>
                <td width="15%" style="border: 0px none" align="center" bgcolor="#EFEFEF">
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td bgcolor="#EFEFEF" colspan="2" align="center">
                                合价（元）
                            </td>
                        </tr>
                        <tr>
                            <td align="center" width="50%" bgcolor="#EFEFEF">
                                申报合价
                            </td>
                            <td align="center" width="50%" bgcolor="#EFEFEF">
                                监理审核
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProduct">
            <%
                int m = 1;
                float ctotal = 0;
                float stotal = 0;
                foreach (ImportDemo.Detailbill d in listdetailbill)
                {           
            %>
            <tr>
                <td width="0.5%" align="center" bgcolor="#FFFFFF">
                    <input type="checkbox" name="checkbox2" value="checkbox" />
                </td>
                <td width="3.5%" edittype="TextBox" name="no" align="center">
                    <%=m%>
                </td>
                <td width="7.5%" name="NO" edittype="TextBox" align="center">
                    <%=d.NO%>
                </td>
                <td width="7.5%" name="pname" edittype="TextBox" align="center">
                    <%=d.pname%>
                </td>
                <td width="23.5%" name="pdescription" edittype="TextBox">
                    <%=d.pdescription%>
                </td>
                <td width="5%" name="punite" edittype="TextBox" align="center">
                    <%=d.punite%>
                </td>
                <td width="7.5%" name="pquantity" edittype="TextBox" align="center">
                    <%=d.pquantity%>
                </td>
                <td width="7.5%" edittype="TextBox" name="cAmount" align="center">
                    <%=d.completequantity%>
                </td>
                <td width="7.5%" name="ccompletedquantity" edittype="TextBox" align="center">
                    <%=d.ccompletedquantity%>
                </td>
                <td width="7.5%" edittype="TextBox" name="sAmount" align="center">
                    <%=d.scompletequantity%>
                </td>
                <td width="7.5%" edittype="TextBox" name="Price" align="center">
                    <%=d.price%>
                </td>
                <% float cctotalprice = d.completequantity * d.price;
                   if (cctotalprice == d.ctotalprice)
                   {
                %>
                <td width="7.5%" name="ctotalprice" expression="cAmount*Price" align="center">
                    <%=d.ctotalprice%>
                </td>
                <%
}
                   else
                   {%>
                <td width="7.5%" name="ctotalprice" expression="cAmount*Price" bgcolor="#FFFFE0"
                    align="center">
                    <%=cctotalprice%>
                </td>
                <% 
}
                   float sstotalprice = d.scompletequantity * d.price;
                   if (sstotalprice == d.stotalprice)
                   {
                %>
                <td width="7.5%" name="stotalprice" expression="sAmount*Price" align="center">
                    <%=d.stotalprice%>
                </td>
                <%}
               else
               { %>
                <td width="7.5%" name="stotalprice" expression="sAmount*Price" bgcolor="#FFFFE0"
                    align="center">
                    <%=sstotalprice%>
                </td>
                <%} %>
            </tr>
            <% 
m++;
ctotal = ctotal + cctotalprice;
stotal = stotal + sstotalprice;
                }    
            %>
            <tr>
                <td width="0.5%" align="center" bgcolor="#FFFFFF">
                    <input type="checkbox" name="checkbox2" value="checkbox" />
                </td>
                <td width="84.5%" colspan="10" align="center">
                    合计
                </td>
                <%if (ctotal == cctotal)
                  {
                %>
                <td align="center" width="7.5%">
                    <%=ctotal%>
                </td>
                <%}
                  else
                  { %>
                <td align="center" width="7.5%" bgcolor="#FFFFE0" expression="sum" onmouseover="请确认此值的正确性！！！">
                    <%=cctotal%>
                </td>
                <%
                    } if (stotal == sstotal)
                  {%><td align="center" width="7.5%">
                      <%=stotal%>
                  </td>
                <%
                    }
                    else
                    { %>
                <td align="center" width="7.5%" bgcolor="#FFFFE0" expression="sum" onmouseover="请确认此值的正确性！！！">
                    <%=sstotal%>
                </td>
                <% } %></tr>
        </table>
        <!--endprint-->
        <br />
        <br />
        <input type="button" name="Submit" value="新增" onclick="AddRow(document.getElementById('tabProduct'),1)" />
        <input type="button" name="Submit2" value="删除" onclick="DeleteRow(document.getElementById('tabProduct'),1)" />&nbsp;&nbsp;
    </div>
    </form>
</body>
<script type="text/javascript" src="GridEdit.js"></script>
<script type="text/javascript">
    var tabProduct = document.getElementById("tabProduct");

    // 设置表格可编辑
    // 可一次设置多个，例如：EditTables(tb1,tb2,tb2,......)

    //SetRowCanEdit(newRow);
    EditTables(tabProduct);
   

</script>
</html>
