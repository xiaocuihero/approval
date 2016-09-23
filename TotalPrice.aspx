<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TotalPrice.aspx.cs" Inherits="TotalPrice" %>

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
            <input type="submit" name="Submit3" value="提交" onclick="GetTableTotalPriceBillData(document.getElementById('tabProduct'));return false;"
                style="height: 26px; width: 90px; position: relative; left: -100px; top: 20px" />
            <input type="button" name="Submit3" value="打印预览" onclick="preview();" style="height: 26px;
                width: 90px; position: relative; left: 100px; top: 20px" />
            <br />
            <br />
            <br />
        </center>
    </div>
    <div>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProducthead">
            <tr>
                <td width="3%" align="center" bgcolor="#EFEFEF">
                </td>
                <td width="6%" align="center" bgcolor="#EFEFEF">
                    序号
                </td>
                <td width="19%" align="center" bgcolor="#EFEFEF">
                    内容
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    报价（元）
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    至上期累计完成工程量（元）
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    至本期累计完成百分比
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    本期完成百分比
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    本期完成（元）
                </td>
                <td width="12%" align="center" bgcolor="#EFEFEF">
                    监理审核（元）
                </td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="0" cellspacing="0" id="tabProduct">
            <%
                
                if (dataList.Count == 25)
                {
                    string normalColor = "#FFFFFF";
                    string errorColor = "#FFFFE0";
                    string CanEdit = "TextBox";
                    string CanNotEdit = "null";
                    int[] indexsCanEdit = new int[] { 15, 16, 17, 19, 20 };
                    int[] indexsNeedCheck = new int[] { 0, 13, 14, 18, 23 };

                    Double ccomplete1 = 0;
                    Double scomplete1 = 0;

                    Double ccomplete01 = dataList[15].ccomplete + dataList[16].ccomplete; //14
                    Double scomplete01 = dataList[15].scomplete + dataList[16].scomplete;

                    Double ccomplete03 = dataList[19].ccomplete + dataList[20].ccomplete + dataList[21].ccomplete; //18
                    Double scomplete03 = dataList[19].scomplete + dataList[20].scomplete + dataList[21].scomplete;

                    Double ccomplete2 = ccomplete01 + dataList[17].ccomplete + ccomplete03 + dataList[22].ccomplete; //13
                    Double scomplete2 = scomplete01 + dataList[17].scomplete + scomplete03 + dataList[22].ccomplete;

                    // 一
                    for (int i = 1; i < 13; i++)
                    {
                        ImportDemo.TotalPriceBill tbill = dataList[i];
                        ImportDemo.UnitProjectBill ubill = CheckComplete(tbill);
                        Double ccompleteTmp = ubill == null ? 0 : ubill.ccomplete;
                        Double scompleteTmp = ubill == null ? 0 : ubill.scomplete;
                        ccomplete1 += ccompleteTmp;
                        scomplete1 += scompleteTmp;
                    }

                    Double ccompleteAll = ccomplete1 + ccomplete2; //23
                    Double scompleteAll = scomplete1 + scomplete2;

                    for (int i = 0; i < dataList.Count - 1; i++)
                    {
                        ImportDemo.TotalPriceBill bill = dataList[i];
                        //表格可编辑check
                        string editable = indexsCanEdit.Contains(i) ? CanEdit : CanNotEdit;
                        Double ccomplete = bill.ccomplete;
                        Double scomplete = bill.scomplete;

                        //数据库中单位工程check
                        if (i > 0 && i < 13)
                        {
                            ImportDemo.UnitProjectBill ubill = CheckComplete(bill);
                            if (ubill != null)
                            {
                                ccomplete = ubill.ccomplete;
                                scomplete = ubill.scomplete;
                            }
                            else
                            {
                                ccomplete = 0;
                                scomplete = 0;
                            }
                        }

                        if (indexsNeedCheck.Contains(i))
                        {

                            //需要进行求和check
                            switch (i)
                            {
                                case 0:
                                    {
                                        ccomplete = ccomplete1;
                                        scomplete = scomplete1;
                                        break;
                                    }
                                case 13:
                                    {
                                        ccomplete = ccomplete2;
                                        scomplete = scomplete2;
                                        break;
                                    }
                                case 14:
                                    {
                                        ccomplete = ccomplete01;
                                        scomplete = scomplete01;
                                        break;
                                    }
                                case 18:
                                    {
                                        ccomplete = ccomplete03;
                                        scomplete = scomplete03;
                                        break;
                                    }
                                case 23:
                                    {
                                        ccomplete = ccompleteAll;
                                        scomplete = scompleteAll;
                                        break;
                                    }
                                default: { break; }
                            }
                        }
                        string percentComplete = bill.price == 0 ? "0.00%" : (scomplete / bill.price).ToString("0.00%");
                        //值对应check，影响颜色
                        string pBgColor = percentComplete == bill.tpercent.ToString("0.00%").Trim() ? normalColor : errorColor;
                        string ccBgColor = ccomplete == bill.ccomplete ? normalColor : errorColor;
                        string scBgColor = scomplete == bill.scomplete ? normalColor : errorColor;
            %>
            <tr>
                <td width="3%" align="center" bgcolor="#FFFFFF">
                    <%=(i+1).ToString()%>
                </td>
                <td width="6%" align="center" name="NO" bgcolor="#FFFFFF">
                    <%=bill.NO %>
                </td>
                <td width="19%" align="center" name="tcontent" bgcolor="#FFFFFF">
                    <%=bill.tcontent %>
                </td>
                <td width="12%" align="center" name="price" bgcolor="#FFFFFF">
                    <%=bill.price %>
                </td>
                <td width="12%" align="center" name="totalcompletedquantity" bgcolor="#FFFFFF">
                    <%=bill.totalcompletedquantity %>
                </td>
                <td width="12%" align="center" name="totalcompletepercent" bgcolor="#FFFFFF">
                    <%=bill.totalcompletepercent.ToString("0.00%") %>
                </td>
                <td width="12%" align="center" name="tpercent" bgcolor="<%=pBgColor %>">
                    <%=percentComplete %>
                </td>
                <td width="12%" align="center" name="ccomplete" bgcolor="<%=ccBgColor %>" edittype="<%=editable %>"><%=ccomplete %></td>
                <td width="12%" align="center" name="scomplete" bgcolor="<%=scBgColor %>" edittype="<%=editable %>"><%=scomplete %></td>
            </tr>
            <%} // for
                    ImportDemo.TotalPriceBill billAll = dataList[dataList.Count - 2];
                
            %>
            <tr>
                <td colspan="2" width="9%" align="right">
                    总报价（大写）：
                </td>
                <td colspan="5" align="center" width="67%" id="ChineseNumber">
                </td>
                <td colspan="2" align="center" width="24%">
                    元整
                </td>
            </tr>
            <%} // if %>
        </table>
        <p id="CCTax5" style="display: none;"><%=dataList.Count == 25 ? dataList[21].ccomplete / (dataList[15].ccomplete + dataList[16].ccomplete + dataList[17].ccomplete + dataList[19].ccomplete + dataList[20].ccomplete) : 1%></p>
        <p id="SCTax5" style="display: none;"><%=dataList.Count == 25 ? dataList[21].scomplete / (dataList[15].scomplete + dataList[16].scomplete + dataList[17].scomplete + dataList[19].scomplete + dataList[20].scomplete) : 1 %></p>
        <p id="CCTaxSI" style="display: none;"><%=dataList.Count == 25 ? dataList[22].ccomplete / (dataList[15].ccomplete + dataList[16].ccomplete + dataList[17].ccomplete + dataList[19].ccomplete + dataList[20].ccomplete + dataList[21].ccomplete) : 1%></p>
        <p id="SCTaxSI" style="display: none;"><%=dataList.Count == 25 ? dataList[22].scomplete / (dataList[15].scomplete + dataList[16].scomplete + dataList[17].scomplete + dataList[19].scomplete + dataList[20].scomplete + dataList[21].scomplete) : 1%></p>
    </div>
    </form>
</body>
<script type="text/javascript" src="GridEditTotalPrice.js"></script>
<script type="text/javascript">
    var tabProduct = document.getElementById("tabProduct");
    EditTables(tabProduct);
</script>
</html>
