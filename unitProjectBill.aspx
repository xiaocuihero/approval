<%@ Page Language="C#" AutoEventWireup="true" CodeFile="unitProjectBill.aspx.cs"
    Inherits="unitProjectBill" %>

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
            <input type="submit" name="Submit3" value="提交" onclick="GetTableUnitProjectBillData(document.getElementById('unitpname').innerHTML,document.getElementById('tabProduct'));return false;"
                style="height: 26px; width: 90px; position: relative; left: -100px; top: 20px" />
            <input type="button" name="Submit3" value="打印预览" onclick="preview();" style="height: 26px;
                width: 90px; position: relative; left: 100px; top: 20px" />
            <br />
            <br />
            <br />
        </center>
    </div>
    <div>
        <!--startprint-->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="billhead">
            <tr>
                <td width="100%" colspan="11" style="font-size: xx-large" align="center" name="billname"
                    edittype="TextBox">
                    表1-? 单位工程报价汇总表( 号清单)
                </td>
            </tr>
            <tr>
                <td width="100%" colspan="11" align="left" name="dname" edittype="TextBox" id="unitpname">
                    <%=unitpname%>
                </td>
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
                <td width="14%" align="center" bgcolor="#EFEFEF">
                    内容
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF">
                    报价合计（元）
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF">
                    累计完成百分比
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    至上期末累计完成
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF">
                    至上期末监理审核完成（元）
                </td>
                <td width="21%" align="center" bgcolor="#EFEFEF">
                    <table border="1" cellpadding="0" cellspacing="0" width="100%" frame="void">
                        <tr>
                            <td bgcolor="#EFEFEF" colspan="3" align="center">
                                本期完成（元）
                            </td>
                        </tr>
                        <tr>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                建筑工程
                            </td>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                安装工程
                            </td>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                合计
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="21%" align="center" bgcolor="#EFEFEF">
                    <table border="1" cellpadding="0" cellspacing="0" width="100%" frame="void">
                        <tr>
                            <td bgcolor="#EFEFEF" colspan="3" align="center">
                                本期监理审核（元）
                            </td>
                        </tr>
                        <tr>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                建筑工程
                            </td>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                安装工程
                            </td>
                            <td align="center" width="33%" bgcolor="#EFEFEF">
                                合计
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProduct">
            <%                                           
                int index = 0;
                if (dataList.Count == 11)
                {
                    string nomalColor = "#EFEFEF";
                    string errorColor = "#FFFFE0";
                    Single re_totalprice2 = dataList[2].totalprice + dataList[3].totalprice;
                    Single re_totalprice4 = dataList[6].totalprice + dataList[7].totalprice + dataList[8].totalprice;
                    Single re_totalprice6 = dataList[0].totalprice + dataList[1].totalprice + dataList[4].totalprice + dataList[5].totalprice + dataList[9].totalprice;
                    Single re_ctotalcomplete2 = dataList[2].ctotalcomplete + dataList[3].ctotalcomplete;
                    Single re_ctotalcomplete4 = dataList[6].ctotalcomplete + dataList[7].ctotalcomplete + dataList[8].ctotalcomplete;
                    Single re_ctotalcomplete6 = dataList[0].ctotalcomplete + dataList[1].ctotalcomplete + dataList[4].ctotalcomplete + dataList[5].ctotalcomplete + dataList[9].ctotalcomplete;
                    Single re_stotalcomplete2 = dataList[2].stotalcomplete + dataList[3].stotalcomplete;
                    Single re_stotalcomplete4 = dataList[6].stotalcomplete + dataList[7].stotalcomplete + dataList[8].stotalcomplete;
                    Single re_stotalcomplete6 = dataList[0].stotalcomplete + dataList[1].stotalcomplete + dataList[4].stotalcomplete + dataList[5].stotalcomplete + dataList[9].stotalcomplete;
                    Single re_ccomplete2 = dataList[2].ccomplete + dataList[3].ccomplete;
                    Single re_ccomplete4 = dataList[6].ccomplete + dataList[7].ccomplete + dataList[8].ccomplete;
                    Single re_ccomplete6 = dataList[0].ccomplete + dataList[1].ccomplete + dataList[4].ccomplete + dataList[5].ccomplete + dataList[9].ccomplete;
                    Single re_scomplete2 = dataList[2].scomplete + dataList[3].scomplete;
                    Single re_scomplete4 = dataList[6].scomplete + dataList[7].scomplete + dataList[8].scomplete;
                    Single re_scomplete6 = dataList[0].scomplete + dataList[1].scomplete + dataList[4].scomplete + dataList[5].scomplete + dataList[9].scomplete;
                    foreach (ImportDemo.UnitProjectBill bill in dataList)
                    {
                        Single re_totalpriceTemp = 0;
                        Single re_ctotalcompleteTemp = 0;
                        Single re_stotalcompleteTemp = 0;
                        Single re_ccompleteTemp = 0;
                        Single re_scompleteTemp = 0;
                        switch (index)
                        {
                            case 1:
                                {
                                    re_totalpriceTemp = re_totalprice2;
                                    re_ctotalcompleteTemp = re_ctotalcomplete2;
                                    re_stotalcompleteTemp = re_stotalcomplete2;
                                    re_ccompleteTemp = re_ccomplete2;
                                    re_scompleteTemp = re_scomplete2;
                                    break;
                                }
                            case 5:
                                {
                                    re_totalpriceTemp = re_totalprice4;
                                    re_ctotalcompleteTemp = re_ctotalcomplete4;
                                    re_stotalcompleteTemp = re_stotalcomplete4;
                                    re_ccompleteTemp = re_ccomplete4;
                                    re_scompleteTemp = re_scomplete4;
                                    break;
                                }
                            case 10:
                                {
                                    re_totalpriceTemp = re_totalprice6;
                                    re_ctotalcompleteTemp = re_ctotalcomplete6;
                                    re_stotalcompleteTemp = re_stotalcomplete6;
                                    re_ccompleteTemp = re_ccomplete6;
                                    re_scompleteTemp = re_scomplete6;
                                    break;
                                }
                            default: { break; }
                        }
                        if (index != 1 && index != 5 && index != 10)
                        {                        
            %>
            <tr>
                <td width="1%" align="center" bgcolor="#EFEFEF">
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="3%" align="center" bgcolor="#EFEFEF" name="num">
                    <%=index%>
                </td>
                <td width="4%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="NO">
                    <%=bill.NO%>
                </td>
                <td width="14%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="pcontent">
                    <%=bill.pcontent%>
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF" name="totalprice">
                    <%=bill.totalprice == 0 ? "" : bill.totalprice.ToString("0")%>
                </td>
                <td width="8%" align="center" bgcolor="#EFEFEF" name="totalcompletepercent">
                    <%=bill.totalcompletepercent == 0 ? "" : bill.totalcompletepercent.ToString("00.00%")%>
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="ctotalcomplete">
                    <%=bill.ctotalcomplete == 0 ? "" : bill.ctotalcomplete.ToString("0")%>
                </td>
                <td width="10%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="stotalcomplete">
                    <%=bill.stotalcomplete == 0 ? "" : bill.stotalcomplete.ToString("0")%>
                </td>
                <%if (index < 3)
                  {                      
                %>
                <td align="center" width="7%" bgcolor="#EFEFEF" edittype="TextBox" name="ccomplete">
                    <%=bill.ccomplete == 0 ? "" : bill.ccomplete.ToString("0")%>
                </td>
                <td align="center" width="7%" bgcolor="#EFEFEF">
                    <%-- Need to decide --%>
                </td>
                <td align="center" width="7%" bgcolor="#EFEFEF">
                    <%-- Need to decide --%>
                </td>
                <td align="center" width="7%" bgcolor="#EFEFEF" edittype="TextBox" name="scomplete">
                    <%=bill.scomplete == 0 ? "" : bill.scomplete.ToString("0")%>
                </td>
                <td align="center" width="7%" bgcolor="#EFEFEF">
                    <%-- Need to decide --%>
                </td>
                <td align="center" width="7%" bgcolor="#EFEFEF" edittype="TextBox">
                    <%=bill.scomplete == 0 ? "" : bill.scomplete.ToString("0")%>
                </td>
                <%
                    } // if (index < 3)
                  else
                  {
                %>
                <td align="center" width="21%" bgcolor="#EFEFEF" edittype="TextBox" colspan="3" name="ccomplete">
                    <%=bill.ccomplete == 0 ? "" : bill.ccomplete.ToString("0")%>
                </td>
                <td align="center" width="21%" bgcolor="#EFEFEF" edittype="TextBox" colspan="3" name="scomplete">
                    <%=bill.scomplete == 0 ? "" : bill.scomplete.ToString("0")%>
                </td>
                <%
} // if (index < 3) else
} //  if (index != 1 && index != 5 && index != 10)
                        else
                        {                                               
                %>
                <tr>
                    <td width="1%" align="center" bgcolor="#EFEFEF">
                        <input type="checkbox" name="checkbox" value="checkbox" />
                    </td>
                    <td width="3%" align="center" bgcolor="#EFEFEF" name="num">
                        <%=index%>
                    </td>
                    <td width="4%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="NO">
                        <%=bill.NO%>
                    </td>
                    <td width="14%" align="center" bgcolor="#EFEFEF" edittype="TextBox" name="pcontent">
                        <%=bill.pcontent%>
                    </td>
                    <td width="8%" align="center" bgcolor="<%=re_totalpriceTemp == bill.totalprice ? nomalColor : errorColor %>"  edittype="TextBox" name="totalprice">
                        <%=re_totalpriceTemp.ToString("0")%>
                    </td>
                    <td width="8%" align="center" bgcolor="#EFEFEF" name="totalcompletepercent">
                        <%=bill.totalcompletepercent == 0 ? "" : bill.totalcompletepercent.ToString("00.00%")%>
                    </td>
                    <td width="10%" align="center" bgcolor="<%=re_ctotalcompleteTemp == bill.ctotalcomplete ? nomalColor : errorColor %>" edittype="TextBox" name="ctotalcomplete">
                        <%=re_ctotalcompleteTemp.ToString("0")%>
                    </td>
                    <td width="10%" align="center" bgcolor="<%=re_stotalcompleteTemp == bill.stotalcomplete ? nomalColor : errorColor %>" edittype="TextBox" name="stotalcomplete">
                        <%=re_stotalcompleteTemp.ToString("0")%>
                    </td>
                    <%if (index < 3)
                      {                      
                    %>
                    <td align="center" width="7%" bgcolor="<%=re_ccompleteTemp == bill.ccomplete ? nomalColor : errorColor %>" edittype="TextBox" name="ccomplete">
                        <%=re_ccompleteTemp.ToString("0")%>
                    </td>
                    <td align="center" width="7%" bgcolor="#EFEFEF">
                        <%-- Need to decide --%>
                    </td>
                    <td align="center" width="7%" bgcolor="#EFEFEF" expression="ccomplete">
                        <%-- Need to decide --%>
                    </td>
                    <%--<td align="center" width="7%" bgcolor="<%=test111 ? "#EFEFEF" : "#FFFFE0"%>" edittype="TextBox">--%>
                    <td align="center" width="7%" bgcolor="<%=re_scompleteTemp == bill.scomplete ? nomalColor : errorColor %>" edittype="TextBox" name="scomplete">
                        <%=re_scompleteTemp.ToString("0")%>
                    </td>
                    <td align="center" width="7%" bgcolor="#EFEFEF">
                        <%-- Need to decide --%>
                    </td>
                    <td align="center" width="7%" bgcolor="#EFEFEF" edittype="TextBox" expression="scomplete">
                        <%=bill.scomplete == 0 ? "" : bill.scomplete.ToString("0")%>
                    </td>
                    <%
                        } // if (index < 3)
                      else
                      {
                    %>
                    <td align="center" width="21%" bgcolor="<%=re_ccompleteTemp == bill.ccomplete ? nomalColor : errorColor %>" edittype="TextBox" colspan="3" name="ccomplete">
                        <%=re_ccompleteTemp.ToString("0")%>
                    </td>
                    <td align="center" width="21%" bgcolor="<%=re_scompleteTemp == bill.scomplete ? nomalColor : errorColor %>" edittype="TextBox" colspan="3" name="scomplete">
                        <%=re_scompleteTemp.ToString("0")%>
                    </td>
                    <%
} // if (index < 3) else                    
} //  if (index != 1 && index != 5 && index != 10) else
                        index++;
                    %>
                </tr>
                <%
                    } //foreach
                } //if (dataList.Count == 11)
                %>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" frame="void">
            <tr>
                <td align="center" width="22%" bgcolor="#EFEFEF">
                    总报价（大写）：
                </td>
                <td align="center" width="57%" bgcolor="#EFEFEF">
                    <%=dataList.Count > 0 ? ConvertToChinese(dataList[dataList.Count - 1].ccomplete) : ""%>
                    <%--<%=dataList.Count>0 ? ConvertToChinese(dataList[dataList.Count - 1].totalprice) : ""%>--%>
                </td>
                <td align="center" width="21%" bgcolor="#EFEFEF">
                    元整
                </td>
            </tr>
        </table>
        <br />
        <br />
        <input type="button" name="Submit" value="新增" onclick="AddRow(document.getElementById('tabProduct'),1)" />
        <input type="button" name="Submit2" value="删除" onclick="DeleteRow(document.getElementById('tabProduct'),1)" />
    </div>
    </form>
</body>
<script type="text/javascript" src="GridEdit.js"></script>
<script type="text/javascript">
    var tabProduct = document.getElementById("tabProduct");
    EditTables(tabProduct);
</script>
</html>
