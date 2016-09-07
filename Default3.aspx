<html>
<head>
<title> ASP.NET 打印 - 所见即所得 </title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
    function preview() {
        bdhtml = window.document.body.innerHTML;
        sprnstr = "<!--startprint-->";
        eprnstr = "<!--endprint-->";
        prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
        //prnform.htext.value=prnhtml;
        //prnform.submit();
        //alert(prnhtml);
    }
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣
<center>本部分以上不被打印</center>
<!--startprint-->
<table width="84%" align="center" bgcolor="#0000FF" cellpadding="2" cellspacing="1">
  <tr bgcolor="#6699FF">
    <td>
      <div align="center">标题一</div>
    </td>
    <td>
      <div align="center">标题二</div>
    </td>
    <td>
      <div align="center">标题三</div>
    </td>
    <td>
      <div align="center">标题四</div>
    </td>
    <td>
      <div align="center">标题五</div>
    </td>
  </tr>
  <tr bgcolor="#6699FF">
    <td> </td>
    <td> </td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</table>
<!--endprint-->
<center>本部分以下不被打印</center>
辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣辣
<div align="center">
  <input type="button" name="print" value="预览并打印" onclick="preview()">
</div>
<style>
@media print {
   .Noprn {display:none;}
}
</style>
<p class="Noprn">不打印</p>
<table id=datagrid><tr><td>打印</td></tr></table>
<input class=Noprn type=button onclick="window.print()" value="print">
</body>
</html>