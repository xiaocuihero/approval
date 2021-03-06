﻿/** 
* JS实现可编辑的表格   
* 用法:EditTables(tb1,tb2,tb2,......); 
* Create by Senty at 2008-04-12 
**/



function GetTableUnitProjectBillData(unitpName, table) {
    var tableData = new Array();
    for (var i = 0; i < table.rows.length; i++) {
        var row = table.rows[i];
        var rowData = {};
        for (var j = 0; j < row.cells.length; j++) {
            var key = row.cells[j].getAttribute("Name");
            if (key) {
                var value = row.cells[j].getAttribute("Value");
                if (!value) {
                    value = row.cells[j].innerHTML;
                }
                rowData[key.toString()] = value.toString();
            }
        }
        rowData["unitName"] = unitpName;
        console.log(rowData);
        $.ajax({
            async: false,
            type: "POST",
            url: 'DBBridge/UnitProjectBillDBBridge.ashx',
            data: rowData,
            success: function (msg) {

            }
        });
    }
}

//设置多个表格可编辑  
function EditTables() {
    for (var i = 0; i < arguments.length; i++) {
        SetTableCanEdit(arguments[i]);
    }
    CheckDataRelation();
}

//设置表格是可编辑的  
function SetTableCanEdit(table) {
    for (var i = 1; i < table.rows.length; i++) {
        SetRowCanEdit(table.rows[i]);
    }
}

function SetRowCanEdit(row) {
    for (var j = 0; j < row.cells.length; j++) {

        //如果当前单元格指定了编辑类型，则表示允许编辑  
        var editType = row.cells[j].getAttribute("EditType");
        if (!editType) {
            //如果当前单元格没有指定，则查看当前列是否指定  
            editType = row.parentNode.rows[0].cells[j].getAttribute("EditType");
        }
        if (editType) {
            row.cells[j].onclick = function () {
                EditCell(this);
            }
        }
    }

}

//设置指定单元格可编辑  
function EditCell(element, editType) {

    var editType = element.getAttribute("EditType");
    if (!editType) {
        //如果当前单元格没有指定，则查看当前列是否指定  
        editType = element.parentNode.parentNode.rows[0].cells[element.cellIndex].getAttribute("EditType");
    }

    switch (editType) {
        case "TextBox":
            CreateTextBox(element, element.innerHTML);
            break;
        case "DropDownList":
            CreateDropDownList(element);
            break;
        default:
            break;
    }
}

//为单元格创建可编辑输入框  
function CreateTextBox(element, value) {
    //检查编辑状态，如果已经是编辑状态，跳过  
    var editState = element.getAttribute("EditState");
    if (editState != "true") {
        //创建文本框  
        var textBox = document.createElement("INPUT");
        textBox.type = "text";
        textBox.className = "EditCell_TextBox";


        //设置文本框当前值  
        if (!value) {
            value = element.getAttribute("Value");
        }
        textBox.value = value;

        //        console.log(value);


        //设置文本框的失去焦点事件
        textBox.onblur = function () {
            CancelEditCell(this.parentNode, this.value);
        }
        //向当前单元格添加文本框  
        ClearChild(element);
        element.appendChild(textBox);
        textBox.focus();
        textBox.select();

        //改变状态变量  
        element.setAttribute("EditState", "true");
        element.parentNode.parentNode.setAttribute("CurrentRow", element.parentNode.rowIndex);
    }

}


//为单元格创建选择框  
function CreateDropDownList(element, value) {
    //检查编辑状态，如果已经是编辑状态，跳过  
    var editState = element.getAttribute("EditState");
    if (editState != "true") {
        //创建下接框  
        var downList = document.createElement("Select");
        downList.className = "EditCell_DropDownList";

        //添加列表项  
        var items = element.getAttribute("DataItems");
        if (!items) {
            items = element.parentNode.parentNode.rows[0].cells[element.cellIndex].getAttribute("DataItems");
        }

        if (items) {
            items = eval("[" + items + "]");
            for (var i = 0; i < items.length; i++) {
                var oOption = document.createElement("OPTION");
                oOption.text = items[i].text;
                oOption.value = items[i].value;
                downList.options.add(oOption);
            }
        }

        //设置列表当前值  
        if (!value) {
            value = element.getAttribute("Value");
        }
        downList.value = value;

        //设置创建下接框的失去焦点事件  
        downList.onblur = function () {
            CancelEditCell(this.parentNode, this.value, this.options[this.selectedIndex].text);
        }

        //向当前单元格添加创建下接框  
        ClearChild(element);
        element.appendChild(downList);
        downList.focus();

        //记录状态的改变  
        element.setAttribute("EditState", "true");
        element.parentNode.parentNode.setAttribute("LastEditRow", element.parentNode.rowIndex);
    }

}


//取消单元格编辑状态  
function CancelEditCell(element, value, text) {
    var valueTmp = value;
    var isAlert = false;
    if (text) {
        element.innerHTML = text;
    } else {
        if (isNaN(parseFloat(value))) {
            if (!valueTmp == "") {
                isAlert = true;
                valueTmp = "";
            }
            element.innerHTML = "";
        } else {
            element.innerHTML = parseFloat(valueTmp);
        }
    }
    element.setAttribute("Value", valueTmp);
    element.setAttribute("EditState", "false");
    //检查是否有公式计算  
    CheckExpression(element.parentNode);
    CheckDataRelation();
    if (isAlert) {
        alert("输入值不是数字!!!");
        ClearChild(element);
    }
}

//清空指定对象的所有字节点  
function ClearChild(element) {
    element.innerHTML = "";
}

//添加行  
function AddRow(table, index) {
    var lastRow = table.rows[table.rows.length - 1];
    var newRow = lastRow.cloneNode(true);
    table.tBodies[0].appendChild(newRow);
    SetRowCanEdit(newRow);
    return newRow;
}


//删除行  
function DeleteRow(table, index) {
    for (var i = table.rows.length - 1; i > 0; i--) {
        var chkOrder = table.rows[i].cells[0].firstChild;
        if (chkOrder) {
            if (chkOrder.type = "CHECKBOX") {
                if (chkOrder.checked) {
                    //执行删除  
                    table.deleteRow(i);
                }
            }
        }
    }
}

//提取表格的值,JSON格式  
function GetTableData(table) {
    var tableData = new Array();
    alert("行数：" + table.rows.length);
    for (var i = 1; i < table.rows.length; i++) {
        tableData.push(GetRowData(tabProduct.rows[i]));
    }

    return tableData;

}
//提取指定行的数据，JSON格式  
function GetRowData(row) {
    var rowData = {};
    for (var j = 0; j < row.cells.length; j++) {
        name = row.parentNode.rows[0].cells[j].getAttribute("Name");
        if (name) {
            var value = row.cells[j].getAttribute("Value");
            if (!value) {
                value = row.cells[j].innerHTML;
            }

            rowData[name] = value;
        }
    }
    //alert("ProductName:" + rowData.ProductName);  
    //或者这样：alert("ProductName:" + rowData["ProductName"]);  
    return rowData;

}

//检查当前数据行中需要运行的字段  
function CheckExpression(row) {
    for (var j = 0; j < row.cells.length; j++) {
        expn = row.parentNode.rows[0].cells[j].getAttribute("Expression");
        //如指定了公式则要求计算  
        if (expn) {
            var result = Expression(row, expn);
            var format = row.parentNode.rows[0].cells[j].getAttribute("Format");
            if (format) {
                //如指定了格式，进行字值格式化  
                row.cells[j].innerHTML = formatNumber(Expression(row, expn), format);
            } else {
                row.cells[j].innerHTML = Expression(row, expn);
            }
        }
    }
}

//计算需要运算的字段  
function Expression(row, expn) {
    var rowData = GetRowData(row);
    //循环代值计算  
    for (var j = 0; j < row.cells.length; j++) {
        name = row.parentNode.rows[0].cells[j].getAttribute("Name");
        if (name) {
            var reg = new RegExp(name, "i");
            expn = expn.replace(reg, rowData[name].replace(/\,/g, ""));
        }
    }
    return eval(expn);
}

function CheckDataRelation() {
    var tableRows = document.getElementById("tabProduct").rows;
    if (tableRows.length == 0) {
        return;
    }
    var unitProjectBillCCTax5 = parseFloat(document.getElementById("unitProjectBillCCTax5").innerHTML);
    var unitProjectBillCCTaxWU = parseFloat(document.getElementById("unitProjectBillCCTaxWU").innerHTML);
    var unitProjectBillSCTax5 = parseFloat(document.getElementById("unitProjectBillSCTax5").innerHTML);
    var unitProjectBillSCTaxWU = parseFloat(document.getElementById("unitProjectBillSCTaxWU").innerHTML);
    //    //二
    //    var c_build1 = isNaN(parseFloat(tableRows[2].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[2].cells[8].innerHTML);
    //    var c_build2 = isNaN(parseFloat(tableRows[3].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[3].cells[8].innerHTML);
    //    var s_build1 = isNaN(parseFloat(tableRows[2].cells[11].innerHTML)) ? 0 : parseFloat(tableRows[2].cells[11].innerHTML);
    //    var s_build2 = isNaN(parseFloat(tableRows[3].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[3].cells[9].innerHTML);

    //    tableRows[1].cells[8].innerHTML = c_build1 + c_build2;
    //    tableRows[1].cells[11].innerHTML = s_build1 + s_build2;
    //    tableRows[1].cells[9].innerHTML = isNaN(parseFloat(tableRows[2].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[2].cells[9].innerHTML);
    //    tableRows[1].cells[12].innerHTML = isNaN(parseFloat(tableRows[2].cells[12].innerHTML)) ? 0 : parseFloat(tableRows[2].cells[12].innerHTML)



    //本期完成、本期监理完成_合计 = 建筑工程 + 安装工程
    for (var i = 0; i < 3; i++) {
        var c_build = isNaN(parseFloat(tableRows[i].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[i].cells[8].innerHTML);
        var c_setup = isNaN(parseFloat(tableRows[i].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[i].cells[9].innerHTML);
        var s_build = isNaN(parseFloat(tableRows[i].cells[11].innerHTML)) ? 0 : parseFloat(tableRows[i].cells[11].innerHTML);
        var s_setup = isNaN(parseFloat(tableRows[i].cells[12].innerHTML)) ? 0 : parseFloat(tableRows[i].cells[12].innerHTML);
        tableRows[i].cells[10].innerHTML = c_build + c_setup;
        tableRows[i].cells[13].innerHTML = s_build + s_setup;
    }

    //税率5
    var _ccomplete01 = isNaN(parseFloat(tableRows[0].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[10].innerHTML);
    var _ccomplete02 = isNaN(parseFloat(tableRows[1].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[10].innerHTML);
    var _ccomplete03 = isNaN(parseFloat(tableRows[4].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[8].innerHTML);
    var _ccomplete3 = isNaN(parseFloat(tableRows[6].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[8].innerHTML);
    var _ccomplete4 = isNaN(parseFloat(tableRows[7].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[8].innerHTML);
    var _cresult5 = ((_ccomplete01 + _ccomplete02 + _ccomplete03 + _ccomplete3 + _ccomplete4) * unitProjectBillCCTax5);
    tableRows[8].cells[8].innerHTML = _cresult5.toFixed(2);
    var _scomplete01 = isNaN(parseFloat(tableRows[0].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[13].innerHTML);
    var _scomplete02 = isNaN(parseFloat(tableRows[1].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[13].innerHTML);
    var _scomplete03 = isNaN(parseFloat(tableRows[4].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[9].innerHTML);
    var _scomplete3 = isNaN(parseFloat(tableRows[6].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[9].innerHTML);
    var _scomplete4 = isNaN(parseFloat(tableRows[7].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[9].innerHTML);
    var _sresult5 = ((_scomplete01 + _scomplete02 + _scomplete03 + _scomplete3 + _scomplete4) * unitProjectBillSCTax5);
    tableRows[8].cells[9].innerHTML = _sresult5.toFixed(2);


    //四
    var ccomplete3 = isNaN(parseFloat(tableRows[6].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[8].innerHTML);
    var ccomplete4 = isNaN(parseFloat(tableRows[7].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[8].innerHTML);
    var ccomplete5 = isNaN(parseFloat(tableRows[8].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[8].cells[8].innerHTML);
    var ccomplete345 = (ccomplete3 + ccomplete4 + ccomplete5).toFixed(2);
    tableRows[5].cells[8].innerHTML = ccomplete345;
    var scomplete3 = isNaN(parseFloat(tableRows[6].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[9].innerHTML);
    var scomplete4 = isNaN(parseFloat(tableRows[7].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[9].innerHTML);
    var scomplete5 = isNaN(parseFloat(tableRows[8].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[8].cells[9].innerHTML);
    var scomplete345 = (scomplete3 + scomplete4 + scomplete5).toFixed(2);
    tableRows[5].cells[9].innerHTML = scomplete345;

    //五
    var __ccomplete01 = isNaN(parseFloat(tableRows[0].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[10].innerHTML);
    var __ccomplete02 = isNaN(parseFloat(tableRows[1].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[10].innerHTML);
    var __ccomplete03 = isNaN(parseFloat(tableRows[4].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[8].innerHTML);
    var __ccomplete04 = isNaN(parseFloat(tableRows[5].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[8].innerHTML);
    var __cresult5 = ((__ccomplete01 + __ccomplete02 + __ccomplete03 + __ccomplete04) * unitProjectBillCCTaxWU);
    tableRows[9].cells[8].innerHTML = __cresult5.toFixed(2);
    var __scomplete01 = isNaN(parseFloat(tableRows[0].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[13].innerHTML);
    var __scomplete02 = isNaN(parseFloat(tableRows[1].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[13].innerHTML);
    var __scomplete03 = isNaN(parseFloat(tableRows[4].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[9].innerHTML);
    var __scomplete04 = isNaN(parseFloat(tableRows[5].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[9].innerHTML);
    var __sresult5 = ((__scomplete01 + __scomplete02 + __scomplete03 + __scomplete04) * unitProjectBillSCTaxWU);
    tableRows[9].cells[9].innerHTML = __sresult5.toFixed(2);

    //六
    var ccomplete01 = isNaN(parseFloat(tableRows[0].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[10].innerHTML);
    var ccomplete02 = isNaN(parseFloat(tableRows[1].cells[10].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[10].innerHTML);
    var ccomplete03 = isNaN(parseFloat(tableRows[4].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[8].innerHTML);
    var ccomplete04 = isNaN(parseFloat(tableRows[5].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[8].innerHTML);
    var ccomplete05 = isNaN(parseFloat(tableRows[9].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[9].cells[8].innerHTML);
    var ccomplete12345 = (ccomplete01 + ccomplete02 + ccomplete03 + ccomplete04 + ccomplete05).toFixed(2);
    var scomplete01 = isNaN(parseFloat(tableRows[0].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[13].innerHTML);
    var scomplete02 = isNaN(parseFloat(tableRows[1].cells[13].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[13].innerHTML);
    var scomplete03 = isNaN(parseFloat(tableRows[4].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[9].innerHTML);
    var scomplete04 = isNaN(parseFloat(tableRows[5].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[9].innerHTML);
    var scomplete05 = isNaN(parseFloat(tableRows[9].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[9].cells[9].innerHTML);
    var scomplete12345 = (scomplete01 + scomplete02 + scomplete03 + scomplete04 + scomplete05).toFixed(2);
    tableRows[10].cells[8].innerHTML = ccomplete12345;
    tableRows[10].cells[9].innerHTML = scomplete12345;

    //大写合计

    //    document.getElementById("ConverToChineseParam").setAttribute("value", ccomplete12345);
    //    document.getElementById("ConverToChineseBtn").click();
    //    var result = document.getElementById("ConverToChineseReturn").getAttribute("value");
    //    document.getElementById("ChineseNumber").innerHTML = result;

    document.getElementById("ChineseNumber").innerHTML = numtochinese(ccomplete12345);


}

///////////////////////////////////////////////////////////////////////////////////  
/** 
* 格式化数字显示方式   
* 用法 
* formatNumber(12345.999,'#,##0.00'); 
* formatNumber(12345.999,'#,##0.##'); 
* formatNumber(123,'000000'); 
* @param num 
* @param pattern 
*/
/* 以下是范例 
formatNumber('','')=0 
formatNumber(123456789012.129,null)=123456789012 
formatNumber(null,null)=0 
formatNumber(123456789012.129,'#,##0.00')=123,456,789,012.12 
formatNumber(123456789012.129,'#,##0.##')=123,456,789,012.12 
formatNumber(123456789012.129,'#0.00')=123,456,789,012.12 
formatNumber(123456789012.129,'#0.##')=123,456,789,012.12 
formatNumber(12.129,'0.00')=12.12 
formatNumber(12.129,'0.##')=12.12 
formatNumber(12,'00000')=00012 
formatNumber(12,'#.##')=12 
formatNumber(12,'#.00')=12.00 
formatNumber(0,'#.##')=0 
*/
function formatNumber(num, pattern) {
    var strarr = num ? num.toString().split('.') : ['0'];
    var fmtarr = pattern ? pattern.split('.') : [''];
    var retstr = '';

    // 整数部分    
    var str = strarr[0];
    var fmt = fmtarr[0];
    var i = str.length - 1;
    var comma = false;
    for (var f = fmt.length - 1; f >= 0; f--) {
        switch (fmt.substr(f, 1)) {
            case '#':
                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
                break;
            case '0':
                if (i >= 0) retstr = str.substr(i--, 1) + retstr;
                else retstr = '0' + retstr;
                break;
            case ',':
                comma = true;
                retstr = ',' + retstr;
                break;
        }
    }
    if (i >= 0) {
        if (comma) {
            var l = str.length;
            for (; i >= 0; i--) {
                retstr = str.substr(i, 1) + retstr;
                if (i > 0 && ((l - i) % 3) == 0) retstr = ',' + retstr;
            }
        }
        else retstr = str.substr(0, i + 1) + retstr;
    }

    retstr = retstr + '.';
    // 处理小数部分    
    str = strarr.length > 1 ? strarr[1] : '';
    fmt = fmtarr.length > 1 ? fmtarr[1] : '';
    i = 0;
    for (var f = 0; f < fmt.length; f++) {
        switch (fmt.substr(f, 1)) {
            case '#':
                if (i < str.length) retstr += str.substr(i++, 1);
                break;
            case '0':
                if (i < str.length) retstr += str.substr(i++, 1);
                else retstr += '0';
                break;
        }
    }
    return retstr.replace(/^,+/, '').replace(/\.$/, '');
}






/* 
功能：将货币数字（阿拉伯数字）(小写)转化成中文(大写） 
    
参数：Num为字符型,小数点之后保留两位,例：Arabia_to_Chinese("1234.06") 
说明：1.目前本转换仅支持到 拾亿（元） 位，金额单位为元，不能为万元，最小单位为分 
2.不支持负数 
*/
function numtochinese(Num) {
    for (i = Num.length - 1; i >= 0; i--) {
        Num = Num.replace(",", "")//替换tomoney()中的“,” 
        Num = Num.replace(" ", "")//替换tomoney()中的空格 
    }

    Num = Num.replace("￥", "")//替换掉可能出现的￥字符 
    if (isNaN(Num)) {
        //验证输入的字符是否为数字 
        alert("请检查小写金额是否正确");
        return;
    }
    //---字符处理完毕，开始转换，转换采用前后两部分分别转换---// 
    part = String(Num).split(".");
    newchar = "";
    //小数点前进行转化 
    for (i = part[0].length - 1; i >= 0; i--) {
        if (part[0].length > 10) { alert("位数过大，无法计算"); return ""; } //若数量超过拾亿单位，提示 
        tmpnewchar = ""
        perchar = part[0].charAt(i);
        switch (perchar) {
            case "0": tmpnewchar = "零" + tmpnewchar; break;
            case "1": tmpnewchar = "壹" + tmpnewchar; break;
            case "2": tmpnewchar = "贰" + tmpnewchar; break;
            case "3": tmpnewchar = "叁" + tmpnewchar; break;
            case "4": tmpnewchar = "肆" + tmpnewchar; break;
            case "5": tmpnewchar = "伍" + tmpnewchar; break;
            case "6": tmpnewchar = "陆" + tmpnewchar; break;
            case "7": tmpnewchar = "柒" + tmpnewchar; break;
            case "8": tmpnewchar = "捌" + tmpnewchar; break;
            case "9": tmpnewchar = "玖" + tmpnewchar; break;
        }
        switch (part[0].length - i - 1) {
            case 0: tmpnewchar = tmpnewchar + "元"; break;
            case 1: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
            case 2: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
            case 3: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
            case 4: tmpnewchar = tmpnewchar + "万"; break;
            case 5: if (perchar != 0) tmpnewchar = tmpnewchar + "拾"; break;
            case 6: if (perchar != 0) tmpnewchar = tmpnewchar + "佰"; break;
            case 7: if (perchar != 0) tmpnewchar = tmpnewchar + "仟"; break;
            case 8: tmpnewchar = tmpnewchar + "亿"; break;
            case 9: tmpnewchar = tmpnewchar + "拾"; break;
        }
        newchar = tmpnewchar + newchar;
    }
    //小数点之后进行转化 
    if (Num.indexOf(".") != -1) {
        if (part[1].length > 2) {
            alert("小数点之后只能保留两位,系统将自动截段");
            part[1] = part[1].substr(0, 2)
        }
        for (i = 0; i < part[1].length; i++) {
            tmpnewchar = ""
            perchar = part[1].charAt(i)
            switch (perchar) {
                case "0": tmpnewchar = "零" + tmpnewchar; break;
                case "1": tmpnewchar = "壹" + tmpnewchar; break;
                case "2": tmpnewchar = "贰" + tmpnewchar; break;
                case "3": tmpnewchar = "叁" + tmpnewchar; break;
                case "4": tmpnewchar = "肆" + tmpnewchar; break;
                case "5": tmpnewchar = "伍" + tmpnewchar; break;
                case "6": tmpnewchar = "陆" + tmpnewchar; break;
                case "7": tmpnewchar = "柒" + tmpnewchar; break;
                case "8": tmpnewchar = "捌" + tmpnewchar; break;
                case "9": tmpnewchar = "玖" + tmpnewchar; break;
            }
            if (i == 0) tmpnewchar = tmpnewchar + "角";
            if (i == 1) tmpnewchar = tmpnewchar + "分";
            newchar = newchar + tmpnewchar;
        }
    }
    //替换所有无用汉字 
    while (newchar.search("零零") != -1)
        newchar = newchar.replace("零零", "零");
    newchar = newchar.replace("零亿", "亿");
    newchar = newchar.replace("亿万", "亿");
    newchar = newchar.replace("零万", "万");
    newchar = newchar.replace("零元", "元");
    newchar = newchar.replace("零角", "");
    newchar = newchar.replace("零分", "");

    if (newchar.charAt(newchar.length - 1) == "元" || newchar.charAt(newchar.length - 1) == "角")
        newchar = newchar + "整"
    return newchar;
}