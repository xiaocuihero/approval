<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrganizationMeasure.aspx.cs"
    Inherits="OrganizationMeasure" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
            Height="27px" Width="79px" />
        <asp:DropDownList Style="position: absolute; right: 100px; top: 15px;" ID="DropDownList1"
            runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
        </asp:DropDownList>
        <br />
    </div>
    <div>
        <center>
            <input type="submit" name="Submit3" value="提交" onclick="GetTableOrganizationBillData(document.getElementById('tabProduct'));return false;"
                style="height: 26px; width: 90px; position: relative; left: -100px; top: 20px" />
            <input type="button" name="Submit3" value="打印预览" onclick="preview();" style="height: 26px;
                width: 90px; position: relative; left: 100px; top: 20px" />
            <br />
            <br />
            <br />
        </center>
    </div>
    <!--startprint-->
    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="billhead">
            <tr>
                <td width="100%" colspan="11" style="font-size: xx-large" align="center" name="billname"
                    edittype="TextBox">
                    表1-? 组织措施项目（整体）清单及计价表 ( 号清单)
                </td>
            </tr>
            <tr>
                <%--<td width="100%" colspan="11" align="left" name="dname" edittype="TextBox" id="unitpname">
                    <%=organizationName%>
                </td>--%>
            </tr>
        </table>
    </div>
    <div>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProducthead">
            <tr>
                <td width="1%" align="center" bgcolor="#EFEFEF" name="Num">
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="3%" align="center" bgcolor="#EFEFEF">
                </td>
                <td width="4%" align="center" bgcolor="#EFEFEF">
                    序号
                </td>
                <td width="16%" align="center" bgcolor="#EFEFEF">
                    项目名称
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF">
                    单位
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF">
                    数量
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    金额（元）
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    至上期累计支付（元）
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    本期上报金额
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    监理审核
                </td>
                <td width="20%" align="center" bgcolor="#EFEFEF">
                    备注
                </td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProduct">
            <%  
                if (dataList.Count == 10)
                {
                    string normalColor = "#FFFFFF";
                    string errorColor = "#FFFFE0";
                    //Double price3 = dataList[3].price + dataList[4].price + dataList[5].price + dataList[6].price + dataList[7].price + dataList[8].price;
                    //Double total3 = dataList[3].totalcompleteprice + dataList[4].totalcompleteprice + dataList[5].totalcompleteprice +
                    //    dataList[6].totalcompleteprice + dataList[7].totalcompleteprice + dataList[8].totalcompleteprice;
                    Double cc3 = dataList[3].ccompleteprice + dataList[4].ccompleteprice + dataList[5].ccompleteprice +
                        dataList[6].ccompleteprice + dataList[7].ccompleteprice + dataList[8].ccompleteprice;
                    Double sc3 = dataList[3].scompleteprice + dataList[4].scompleteprice + dataList[5].scompleteprice +
                        dataList[6].scompleteprice + dataList[7].scompleteprice + dataList[8].scompleteprice;
                    for (int i = 0; i < dataList.Count - 1; i++)
                    {
                        ImportDemo.OrganizationMeasureBill bill = dataList[i];
                        
            %>
            <tr>
                <td width="1%" align="center" bgcolor="#FFFFFF" name="Num">
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="3%" align="center" bgcolor="#FFFFFF" name="num">
                    <%=(i + 1).ToString() %>
                </td>
                <td width="4%" align="center" bgcolor="#FFFFFF" name="NO">
                    <%=bill.NO %>
                </td>
                <td width="16%" align="center" bgcolor="#FFFFFF" name="contentname">
                    <%=bill.contentname %>
                </td>
                <td width="8%" align="center" bgcolor="#FFFFFF" name="unite">
                    <%=bill.unite %>
                </td>
                <td width="8%" align="center" bgcolor="#FFFFFF" name="quantity">
                    <%=bill.quantity%>
                </td>
                <td width="10%" align="center" bgcolor="<%=normalColor %>"
                    name="price">
                    <%=bill.price == 0 ? "" : bill.price.ToString("0")%>
                </td>
                <td width="10%" align="center" bgcolor="<%=normalColor %>" name="totalcompleteprice">
                    <%=bill.totalcompleteprice == 0 ? "" : bill.totalcompleteprice.ToString("0")%>
                </td>
                <td width="10%" align="center" bgcolor="<%=i == 2 && cc3 != bill.ccompleteprice ? errorColor : normalColor %>" edittype="<%=i < 3 ? "null" : "TextBox" %>" name="ccompleteprice"><%=i != 2 ? (bill.ccompleteprice == 0 ? "" : bill.ccompleteprice.ToString("0")) : (cc3 == 0 ? "" : cc3.ToString("0"))%></td>
                <td width="10%" align="center" bgcolor="<%=i == 2 && sc3 != bill.scompleteprice ? errorColor : normalColor %>" edittype="<%=i < 3 ? "null" : "TextBox" %>" name="scompleteprice"><%=i != 2 ? (bill.scompleteprice == 0 ? "" : bill.scompleteprice.ToString("0")) : (sc3 == 0 ? "" : sc3.ToString("0"))%></td>
                <td width="20%" align="center" bgcolor="#FFFFFF" checkNum="false" edittype="TextBox" name="bak"><%=bill.bak %></td>
            </tr>
            <%
                }// foreach
            %>
            <%
                int last = dataList.Count - 1;
                ImportDemo.OrganizationMeasureBill billAll = dataList[last];
                Double ccAll = dataList[0].ccompleteprice + dataList[1].ccompleteprice + dataList[2].ccompleteprice;
                Double scAll = dataList[0].scompleteprice + dataList[1].scompleteprice + dataList[2].scompleteprice;
            %>
            <tr>
                <td width="1%" align="center" bgcolor="#FFFFFF" name="Num">
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="39%" align="center" bgcolor="#FFFFFF" colspan="5" name="NO">
                    <%=billAll.NO%>
                </td>
                <td width="10%" align="center" bgcolor="<%=normalColor%>"
                    name="price" expression="sum">
                    <%=billAll.price%>
                </td>
                <td width="10%" align="center" bgcolor="<%=normalColor%>"
                    name="totalcompleteprice" expression="sum">
                    <%=billAll.totalcompleteprice%>
                </td>
                <td width="10%" align="center" bgcolor="<%=ccAll == billAll.ccompleteprice ? normalColor : errorColor %>"
                    name="ccompleteprice" expression="sum">
                    <%=ccAll%>
                </td>
                <td width="10%" align="center" bgcolor="<%=scAll == billAll.scompleteprice ? normalColor : errorColor%>"
                    name="scompleteprice" expression="sum">
                    <%=scAll%>
                </td>
                <td width="20%" align="center" bgcolor="#FFFFFF" name="bak" edittype="TextBox">
                    <%=billAll.bak%>
                </td>
            </tr>
            <%
                } // if
            %>
        </table>
        <br />
        <br />
    </div>
    </form>
</body>
<script type="text/javascript" src="GridEditOrganization.js"></script>
<script type="text/javascript">
    var tabProduct = document.getElementById("tabProduct");
    EditTables(tabProduct);
</script>
</html>
