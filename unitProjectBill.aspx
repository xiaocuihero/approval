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
                    string nomalColor = "#FFFFFF";
                    string errorColor = "#FFFFE0";
                    //Double re_totalprice2 = dataList[2].totalprice + dataList[3].totalprice;
                    //Double re_totalprice4 = dataList[6].totalprice + dataList[7].totalprice + dataList[8].totalprice;
                    //Double re_totalprice6 = dataList[0].totalprice + dataList[1].totalprice + dataList[4].totalprice + dataList[5].totalprice + dataList[9].totalprice;
                    //Double re_ctotalcomplete2 = dataList[2].ctotalcomplete + dataList[3].ctotalcomplete;
                    //Double re_ctotalcomplete4 = dataList[6].ctotalcomplete + dataList[7].ctotalcomplete + dataList[8].ctotalcomplete;
                    //Double re_ctotalcomplete6 = dataList[0].ctotalcomplete + dataList[1].ctotalcomplete + dataList[4].ctotalcomplete + dataList[5].ctotalcomplete + dataList[9].ctotalcomplete;
                    //Double re_stotalcomplete2 = dataList[2].stotalcomplete + dataList[3].stotalcomplete;
                    //Double re_stotalcomplete4 = dataList[6].stotalcomplete + dataList[7].stotalcomplete + dataList[8].stotalcomplete;
                    //Double re_stotalcomplete6 = dataList[0].stotalcomplete + dataList[1].stotalcomplete + dataList[4].stotalcomplete + dataList[5].stotalcomplete + dataList[9].stotalcomplete;
                    
                    Double re_ccomplete2 = dataList[2].ccomplete + dataList[3].ccomplete;
                    Double re_ccomplete4 = dataList[6].ccomplete + dataList[7].ccomplete + dataList[8].ccomplete;
                    Double re_ccomplete6 = dataList[0].ccomplete + dataList[1].ccomplete + dataList[4].ccomplete + re_ccomplete4 + dataList[9].ccomplete;
                    Double re_scomplete2 = dataList[2].scomplete + dataList[3].scomplete;
                    Double re_scomplete4 = dataList[6].scomplete + dataList[7].scomplete + dataList[8].scomplete;
                    Double re_scomplete6 = dataList[0].scomplete + dataList[1].scomplete + dataList[4].scomplete + re_scomplete4 + dataList[9].scomplete;
                    //Double re_ccomplete2 = dataList[2].ccomplete + dataList[3].ccomplete;
                    //Double re_ccomplete4 = dataList[6].ccomplete + dataList[7].ccomplete + dataList[8].ccomplete;
                    //Double re_ccomplete6 = dataList[0].ccomplete + dataList[1].ccomplete + dataList[4].ccomplete + dataList[5].ccomplete + dataList[9].ccomplete;
                    //Double re_scomplete2 = dataList[2].scomplete + dataList[3].scomplete;
                    //Double re_scomplete4 = dataList[6].scomplete + dataList[7].scomplete + dataList[8].scomplete;
                    //Double re_scomplete6 = dataList[0].scomplete + dataList[1].scomplete + dataList[4].scomplete + dataList[5].scomplete + dataList[9].scomplete;
                    foreach (ImportDemo.UnitProjectBill bill in dataList)
                    {
                        //Double re_totalpriceTemp = 0;
                        //Double re_ctotalcompleteTemp = 0;
                        //Double re_stotalcompleteTemp = 0;
                        Double re_ccompleteTemp = 0;
                        Double re_scompleteTemp = 0;
                        //bool cccurect = true;
                        //bool sccurect = true;                     
                        switch (index)
                        {
                            case 1:
                                {
                                    //re_totalpriceTemp = re_totalprice2;
                                    //re_ctotalcompleteTemp = re_ctotalcomplete2;
                                    //re_stotalcompleteTemp = re_stotalcomplete2;
                                    re_ccompleteTemp = re_ccomplete2;
                                    re_scompleteTemp = re_scomplete2;
                                    //cccurect = re_ccomplete2 == bill.ccomplete;
                                    //sccurect = re_scomplete2 == bill.scomplete;
                                    break;
                                }
                            case 5:
                                {
                                    //re_totalpriceTemp = re_totalprice4;
                                    //re_ctotalcompleteTemp = re_ctotalcomplete4;
                                    //re_stotalcompleteTemp = re_stotalcomplete4;
                                    re_ccompleteTemp = re_ccomplete4;
                                    re_scompleteTemp = re_scomplete4;
                                    //cccurect = re_ccomplete4 == bill.ccomplete;
                                    //sccurect = re_scomplete4 == bill.scomplete;
                                    break;
                                }
                            case 10:
                                {
                                    //re_totalpriceTemp = re_totalprice6;
                                    //re_ctotalcompleteTemp = re_ctotalcomplete6;
                                    //re_stotalcompleteTemp = re_stotalcomplete6;
                                    re_ccompleteTemp = re_ccomplete6;
                                    re_scompleteTemp = re_scomplete6;
                                    //cccurect = re_ccomplete6 == bill.ccomplete;
                                    //sccurect = re_scomplete6 == bill.scomplete;
                                    break;
                                }
                            default: { break; }
                        }
                        if (index != 1 && index != 5 && index != 10)
                        {                        
            %>
            <tr>
                <td width="1%" align="center" >
                    <input type="checkbox" name="checkbox" value="checkbox" />
                </td>
                <td width="3%" align="center"  name="num">
                    <%=index%>
                </td>
                <td width="4%" align="center"  name="NO">
                    <%=bill.NO%>
                </td>
                <td width="14%" align="center"  name="pcontent">
                    <%=bill.pcontent%>
                </td>
                <td width="8%" align="center"  name="totalprice">
                    <%=bill.totalprice == 0 ? "" : bill.totalprice.ToString()%>
                </td>
                <td width="8%" align="center"  name="totalcompletepercent">
                    <%=bill.totalcompletepercent == 0 ? "" : bill.totalcompletepercent.ToString("00.00%")%>
                </td>
                <td width="10%" align="center" name="ctotalcomplete">
                    <%=bill.ctotalcomplete == 0 ? "" : bill.ctotalcomplete.ToString("0.00")%>
                </td>
                <td width="10%" align="center" name="stotalcomplete">
                    <%=bill.stotalcomplete == 0 ? "" : bill.stotalcomplete.ToString()%>
                </td>
                <%if (index < 4)
                  {                      
                %>
                <td align="center" width="7%" name="c_build_complete">
                    <%=bill.c_build_complete == 0 ? "" : bill.c_build_complete.ToString()%>
                </td>
                <td align="center" width="7%" name="c_setup_complete">
                    <%=bill.c_setup_complete == 0 ? "" : bill.c_setup_complete.ToString() %>
                </td>
                <td align="center" width="7%" name="ccomplete">
                    <%=(bill.c_build_complete + bill.c_setup_complete).ToString()%>
                </td>
                <td align="center" width="7%" name="s_build_complete">
                    <%=bill.s_build_complete == 0 ? "" : bill.s_build_complete.ToString()%>
                </td>
                <td align="center" width="7%" name="s_setup_complete">
                    <%=bill.c_setup_complete == 0 ? "" : bill.s_setup_complete.ToString()%>
                </td>
                <td align="center" width="7%" name="scomplete">
                    <%=(bill.s_build_complete + bill.s_setup_complete).ToString()%>
                </td>
                <%
                    } // if (index < 4)
                  else
                  {
                %>
                <td align="center" width="21%"  edittype="<%=index==3 || index == 9 || index == 8 ? "null" : "TextBox" %>" colspan="3" name="ccomplete"><%=bill.ccomplete == 0 ? "" : bill.ccomplete.ToString()%></td>
                <td align="center" width="21%"  edittype="<%=index==3 || index == 9 || index == 8 ? "null" : "TextBox" %>" colspan="3" name="scomplete"><%=bill.scomplete == 0 ? "" : bill.scomplete.ToString()%></td>
                <%
} // if (index < 4) else
                        } //  if (index != 1 && index != 5 && index != 10)
                        else
                        {                                               
                %>
                <tr>
                    <td width="1%" align="center" >
                        <input type="checkbox" name="checkbox" value="checkbox" />
                    </td>
                    <td width="3%" align="center" name="num">
                        <%=index%>
                    </td>
                    <td width="4%" align="center" name="NO">
                        <%=bill.NO%>
                    </td>
                    <td width="14%" align="center" name="pcontent">
                        <%=bill.pcontent%>
                    </td>
                    <td width="8%" align="center" bgcolor="<%=nomalColor%>"
                        name="totalprice">
                        <%=bill.totalprice.ToString()%>
                    </td>
                    <td width="8%" align="center" name="totalcompletepercent">
                        <%=bill.totalcompletepercent == 0 ? "" : bill.totalcompletepercent.ToString("00.00%")%>
                    </td>
                    <td width="10%" align="center" bgcolor="<%=nomalColor%>"
                        name="ctotalcomplete">
                        <%=bill.ctotalcomplete.ToString("0.00")%>
                    </td>
                    <td width="10%" align="center" bgcolor="<%=nomalColor%>"
                        name="stotalcomplete"><%=bill.stotalcomplete.ToString()%></td>
                    <%if (index < 4)
                      {                      
                    %>
                    <td align="center" width="7%" bgcolor="<%=re_ccompleteTemp == bill.ccomplete ? nomalColor : errorColor %>"
                        name="ccomplete" editType="null"><%=re_ccompleteTemp.ToString().Trim()%></td>
                    <td align="center" width="7%" editType="null">
                        
                    </td>
                    <td align="center" width="7%" editType="null">
                                          
                    </td>                    
                    <td align="center" width="7%" bgcolor="<%=re_scompleteTemp == bill.scomplete ? nomalColor : errorColor %>"
                        name="scomplete" editType="null"><%=re_scompleteTemp.ToString()%></td>
                    <td align="center" width="7%" editType="null">
                        
                    </td>
                    <td align="center" width="7%" editType="null">
                        <%=bill.scomplete == 0 ? "" : bill.scomplete.ToString()%>
                    </td>
                    <%
                        } // if (index < 4)
                      else
                      {
                    %>
                    <td align="center" width="21%" bgcolor="<%=re_ccompleteTemp == bill.ccomplete ? nomalColor : errorColor %>"
                        colspan="3" name="ccomplete">
                        <%=re_ccompleteTemp.ToString()%>
                    </td>
                    <td align="center" width="21%" bgcolor="<%=re_scompleteTemp == bill.scomplete ? nomalColor : errorColor %>"
                        colspan="3" name="scomplete">
                        <%=re_scompleteTemp.ToString()%>
                    </td>
                    <%
} // if (index < 4) else                    
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
                <td align="center" width="22%" >
                    总报价（大写）：
                </td>
                <td align="center" width="57%" id="ChineseNumber">
                    <%=dataList.Count > 0 ? ConvertToChinese(dataList[dataList.Count - 1].ccomplete) : ""%>                    
                </td>
                <td align="center" width="21%" >
                    元整
                </td>
            </tr>
        </table>
        <br />
        <br />
        <p id="unitProjectBillCCTax5" style="display:none;"><%=dataList.Count == 11 ? dataList[8].ccomplete / (dataList[0].ccomplete + dataList[1].ccomplete + dataList[4].ccomplete + dataList[6].ccomplete + dataList[7].ccomplete): 1%></p>
        <p id="unitProjectBillCCTaxWU" style="display:none;"><%=dataList.Count == 11 ? dataList[9].ccomplete / (dataList[0].ccomplete + dataList[1].ccomplete + dataList[4].ccomplete + dataList[6].ccomplete + dataList[7].ccomplete + dataList[8].ccomplete) : 1%></p>
        <p id="unitProjectBillSCTax5" style="display:none;"><%=dataList.Count == 11 ? dataList[8].scomplete / (dataList[0].scomplete + dataList[1].scomplete + dataList[4].scomplete + dataList[6].scomplete + dataList[7].scomplete) : 1%></p>
        <p id="unitProjectBillSCTaxWU" style="display:none;"><%=dataList.Count == 11 ? dataList[9].scomplete / (dataList[0].scomplete + dataList[1].scomplete + dataList[4].scomplete + dataList[6].scomplete + dataList[7].scomplete + dataList[8].scomplete) : 1%></p>
        <%--<asp:HiddenField ID="ConverToChineseParam" runat="server" Value="1" />
        <asp:HiddenField ID="ConverToChineseReturn" runat="server" Value="1" />
        <div style="display:none;">      
            <asp:Button ID="ConverToChineseBtn" Width="0" usesubmitbehavior="false" runat="server" Text="" OnClick="ConverToChineseFuncBridge" />       
        </div> --%>
    </div>
    </form>
</body>
<script type="text/javascript" src="GridEditUnitProject.js"></script>
<script type="text/javascript">
    var tabProduct = document.getElementById("tabProduct");
    EditTables(tabProduct);
</script>
</html>
