<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
.myline { BORDER-RIGHT: #000000 0px solid; BORDER-TOP: #000000 0px solid; BORDER-LEFT: #000000 0px solid; BORDER-BOTTOM: #000000 1px solid; }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:90%; height:80%; margin-left:5%">
    <div style=" border:1px none">
    <p>浙建监B11</p>
    <p style="font-size:x-large;text-align:center">工程支付报审表</p>
    <p>工程名称：杭州市中医院丁桥分院工程</p>
    </div>
    <div style=" border:1px solid">
    <p>致  浙江泛华工程监理有限公司 （项目监理机构）：</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp; 我方已完成<asp:TextBox id="TextBox1" runat="server" 
                CssClass="myline" Width="380px">地下室、病房楼、行政科研楼、门诊医技楼结构及部分二次结构</asp:TextBox>工作，该本月工程量清单计价为：<asp:TextBox 
                id="TextBox2" runat="server" 
                CssClass="myline" Width="55px">1120</asp:TextBox>万元。按施工合同约定，扣除预付款的10%为 
            <asp:TextBox id="TextBox3" runat="server" 
                CssClass="myline" Width="49px">167.4</asp:TextBox>万，建设单位应支付该工程款的75%即 
            <asp:TextBox id="TextBox4" runat="server" 
                CssClass="myline" Width="49px">672</asp:TextBox>万元（大写） 陆佰柒拾贰万元整 ，现将有关资料报上，请予以审核。
</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp; 附件：   
</p>
        <p style="margin-left: 80px">1、工程量清单报审表共<asp:TextBox id="TextBox5" runat="server" 
                CssClass="myline" Width="23px" Height="16px"></asp:TextBox>页    
</p>
        <p style="margin-left: 80px">2、现场工程量计量表共<asp:TextBox id="TextBox6" runat="server" 
                CssClass="myline" Width="23px" ></asp:TextBox>页          
                                               </p>
        <p style="text-align:right;margin-right: 80px">承包单位（盖章）                                      
                                                     
            <asp:TextBox 
                id="TextBox7" runat="server" 
                CssClass="myline" Width="141px"></asp:TextBox>                                      
                                                    </p>
        <p style="text-align:right;margin-right: 80px">项目经理（签字）                                     
                                          
            <asp:TextBox 
                id="TextBox8" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
                                         </p>
        <p style="text-align:right;">2016年9月2日
</p>
    </div>
    <div style=" border:1px solid">
    <p>监理单位审核意见：</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp; 本期同意支付工程款为：（大写）<asp:TextBox id="TextBox9" runat="server" 
                CssClass="myline" Width="160px"></asp:TextBox>，（小写）<asp:TextBox 
                id="TextBox10" runat="server" 
                CssClass="myline" Width="125px"></asp:TextBox>请代建单位审批。</p>
        <p style="text-align:right;margin-right: 80px">监理单位（盖章）                                      
                                                     
            <asp:TextBox 
                id="TextBox15" runat="server" 
                CssClass="myline" Width="141px"></asp:TextBox>                                      
                                                    </p>
        <p style="text-align:right;margin-right: 80px">专业监理工程师（签字）                                     
                                          
            <asp:TextBox 
                id="TextBox16" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
                                         </p>
        <p style="text-align:right;margin-right: 80px">专业监理工程师（签字）                                     
                                          
            <asp:TextBox 
                id="TextBox17" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
                                         </p>

        <p style="text-align:right;">2016年9月2日
</p>
    </div>
        <div style=" border:1px solid">
    <p>代建单位审核意见：</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp; 本期同意支付工程款为：（大写）<asp:TextBox id="TextBox11" runat="server" 
                CssClass="myline" Width="160px"></asp:TextBox>，（小写）<asp:TextBox 
                id="TextBox12" runat="server" 
                CssClass="myline" Width="125px"></asp:TextBox>请建设单位审批。</p>
        <p style="text-align:right;margin-right: 80px">代建单位（盖章）                                      
                                                     
            <asp:TextBox 
                id="TextBox13" runat="server" 
                CssClass="myline" Width="141px"></asp:TextBox>                                      
                                                    </p>
        <p style="text-align:right;margin-right: 80px">代建负责人（签字）                                     
                                          
            <asp:TextBox 
                id="TextBox14" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
                                         </p>

        <p style="text-align:right;">2016年9月2日
</p>
    </div>
    <div style=" border:1px solid">
    <p>审批意见：</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp; 本期同意支付工程款为：（大写）<asp:TextBox id="TextBox18" runat="server" 
                CssClass="myline" Width="160px"></asp:TextBox>，（小写）<asp:TextBox 
                id="TextBox19" runat="server" 
                CssClass="myline" Width="125px"></asp:TextBox>。</p>
        <p style="text-align:right;margin-right: 80px">建设单位（盖章）                                      
                                                     
            <asp:TextBox 
                id="TextBox20" runat="server" 
                CssClass="myline" Width="141px"></asp:TextBox>                                      
                                                    </p>
        <p style="text-align:left;margin-right: 80px">
        经办人：<asp:TextBox 
                id="TextBox22" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                              
        建设单位代表（签字）                                     
                                          
            <asp:TextBox 
                id="TextBox21" runat="server" 
                CssClass="myline" Width="142px"></asp:TextBox>                                     
                                         </p>

        <p style="text-align:right;">2016年9月2日
</p>
    </div>
    </div>
    </form>
</body>
</html>
