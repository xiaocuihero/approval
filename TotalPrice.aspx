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
            <input type="submit" name="Submit3" value="提交" onclick="GetTableOrganizationBillData(document.getElementById('tabProduct'));return false;"
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
                <td width="4%" align="center" bgcolor="#EFEFEF">
                    序号
                </td>
                <td width="21%" align="center" bgcolor="#EFEFEF">
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
                string normalColor = "#FFFFFF";
                string errorColor = "#FFFFE0";
                string CanEdit = "TextBox";
                string CanNotEdit = "null";
                int[] indexsCanEdit = new int[] { 12, 13, 14, 15, 17, 18 };
                int[] indexsNeedCheck = new int[] { 0, 11, 12, 16, 19, 20, 21 };
                for (int i = 0; i < dataList.Count; i++) 
                {
                    ImportDemo.TotalPriceBill bill = dataList[i];
                    string canEdit = indexsCanEdit.Contains(i) ? CanEdit : CanNotEdit;
                    string bgColor = normalColor;
                    string a = bill.tpercent.ToString();
                    if (indexsNeedCheck.Contains(i)) 
                    {
                        
                    }
                }
            %>
        </table>
    </div>
    </form>
</body>
</html>
