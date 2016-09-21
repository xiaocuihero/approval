/** 
* JS实现可编辑的表格   
* 用法:EditTables(tb1,tb2,tb2,......); 
* Create by Senty at 2008-04-12 
**/



function GetTableOrganizationBillData(table) {
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
        $.ajax({
            async: false,
            type: "POST",
            url: 'DBBridge/OrganizationMeasurBillDBBridge.ashx',
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
}

//设置表格是可编辑的  
function SetTableCanEdit(table) {
    //源代码默认设置第一行为表头，不可编辑
    //    for (var i = 1; i < table.rows.length; i++) {
    //        SetRowCanEdit(table.rows[i]);
    //    }
    for (var i = 0; i < table.rows.length; i++) {
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
    var checkNum = element.getAttribute("checkNum");
    if (text) {
        element.innerHTML = text;
    } else {
        if (checkNum == "false") {
            element.innerHTML = value;
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

function CheckDataRelation() {
    var tableRows = document.getElementById("tabProduct").rows;
    //三、合计
    var ccurent1 = isNaN(parseFloat(tableRows[3].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[3].cells[8].innerHTML);
    var ccurent2 = isNaN(parseFloat(tableRows[4].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[8].innerHTML);
    var ccurent3 = isNaN(parseFloat(tableRows[5].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[8].innerHTML);
    var ccurent4 = isNaN(parseFloat(tableRows[6].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[8].innerHTML);
    var ccurent5 = isNaN(parseFloat(tableRows[7].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[8].innerHTML);
    var ccurent6 = isNaN(parseFloat(tableRows[8].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[8].cells[8].innerHTML);
    var ccurentSum = ccurent1 + ccurent2 + ccurent3 + ccurent4 + ccurent5 + ccurent6;
    var scurent1 = isNaN(parseFloat(tableRows[3].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[3].cells[9].innerHTML);
    var scurent2 = isNaN(parseFloat(tableRows[4].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[4].cells[9].innerHTML);
    var scurent3 = isNaN(parseFloat(tableRows[5].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[5].cells[9].innerHTML);
    var scurent4 = isNaN(parseFloat(tableRows[6].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[6].cells[9].innerHTML);
    var scurent5 = isNaN(parseFloat(tableRows[7].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[7].cells[9].innerHTML);
    var scurent6 = isNaN(parseFloat(tableRows[8].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[8].cells[9].innerHTML);
    var scurentSum = scurent1 + scurent2 + scurent3 + scurent4 + scurent5 + scurent6;
    tableRows[2].cells[8].innerHTML = ccurentSum;
    tableRows[2].cells[9].innerHTML = scurentSum;

    //合计
    var ccurent01 = isNaN(parseFloat(tableRows[0].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[8].innerHTML);
    var ccurent02 = isNaN(parseFloat(tableRows[1].cells[8].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[8].innerHTML);
    var ccurent03 = ccurentSum;
    var ccurentSumAll = ccurent01 + ccurent02 + ccurent03;
    var scurent01 = isNaN(parseFloat(tableRows[0].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[0].cells[9].innerHTML);
    var scurent02 = isNaN(parseFloat(tableRows[1].cells[9].innerHTML)) ? 0 : parseFloat(tableRows[1].cells[9].innerHTML);
    var scurent03 = scurentSum;
    var scurentSumAll = scurent01 + scurent02 + scurent03;
    tableRows[9].cells[4].innerHTML = ccurentSumAll;
    tableRows[9].cells[5].innerHTML = scurentSumAll;
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