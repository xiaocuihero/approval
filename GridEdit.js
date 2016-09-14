/** 
* JS实现可编辑的表格   
* 用法:EditTables(tb1,tb2,tb2,......); 
* Create by Senty at 2008-04-12
**/

//设置多个表格可编辑
function EditTables() {
    for (var i = 0; i < arguments.length; i++) {
        SetTableCanEdit(arguments[i]);
    }
}

//设置表格是可编辑的
function SetTableCanEdit(table) {
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

//取消单元格编辑状态
function CancelEditCell(element, value, text) {
    element.setAttribute("Value", value);
    if (text) {
        element.innerHTML = text;
    } else {
        element.innerHTML = value;
    }
    element.setAttribute("EditState", "false");

    //检查是否有公式计算
    CheckExpression(element.parentNode);
}

//清空指定对象的所有字节点
function ClearChild(element) {
    element.innerHTML = "";
}

//添加行
function AddRow(table, index) {
    var lastRow = table.rows[table.rows.length - 2];
    var newRow = lastRow.cloneNode(true);
    table.tBodies[0].insertBefore(newRow, table.tBodies[0].childNodes[table.rows.length - 1]);
    SetRowCanEdit(newRow);
    var tableData = new Array();
    var sum1 = 0;
    var sum2 = 0;
    var n = document.getElementById("tabProduct").rows.length;
    for (var i = 0; i < n - 1; i++) {
        tableData.push(GetRowData(tabProduct.rows[i]));
    }
    for (var i = 0; i < n - 1; i++) {
        sum1 = parseFloat(sum1) + parseFloat(tableData[i]["ctotalprice"]);
        sum2 = parseFloat(sum2) + parseFloat(tableData[i]["stotalprice"]);
    }
    document.getElementById("tabProduct").rows[n - 1].cells[2].innerHTML = sum1.toFixed(2);
    document.getElementById("tabProduct").rows[n - 1].cells[3].innerHTML = sum2.toFixed(2);
    return newRow;

}


//删除行
function DeleteRow(table, index) {
    for (var i = table.rows.length - 1; i >= 0; i--) {
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
    var tableData = new Array();
    var sum1 = 0;
    var sum2 = 0;
    var n = document.getElementById("tabProduct").rows.length;
    for (var i = 0; i < n - 1; i++) {
        tableData.push(GetRowData(tabProduct.rows[i]));
    }
    for (var i = 0; i < n - 1; i++) {
        sum1 = parseFloat(sum1) + parseFloat(tableData[i]["ctotalprice"]);
        sum2 = parseFloat(sum2) + parseFloat(tableData[i]["stotalprice"]);
    }
    document.getElementById("tabProduct").rows[n - 1].cells[2].innerHTML = sum1.toFixed(2);
    document.getElementById("tabProduct").rows[n - 1].cells[3].innerHTML = sum2.toFixed(2);
}

//提取表格的值,JSON格式
function GetTableData(table1, table) {
    var tableData = new Array();
    var dname = table1.rows[1].cells[0].innerHTML;
    for (var i = 0; i < table.rows.length - 1; i++) {
        GetRowData1(tabProduct.rows[i], dname);
    }
}

//unitProjectBill 数据存储

function GetTableUnitProjectBillData(unitpName, table) {
    var tableData = new Array();
    for (var i = 0; i < table.rows.length - 1; i++) {
        var row = table.rows[i];
        var rowData = {};
        for (var j = 0; j < row.cells.length; j++) {
            var key = row.parentNode.rows[0].cells[j].getAttribute("Name");
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

//提取指定行的数据，JSON格式
function GetRowData1(row, dname) {
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
    insertdata(rowData, dname);
}

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
    return rowData;
}


function insertdata(rowData, dname) {
    //省略验证过程
    var rowdataj = {
        dname: dname,
        no: rowData["no"],
        NO: rowData["NO"],
        pname: rowData["pname"],
        pdescription: rowData["pdescription"],
        punite: rowData["punite"],
        pquantity: rowData["pquantity"],
        cAmount: rowData["cAmount"],
        ccompletedquantity: rowData["ccompletedquantity"],
        sAmount: rowData["sAmount"],
        Price: rowData["Price"],
        ctotalprice: rowData["ctotalprice"],
        stotalprice: rowData["stotalprice"]
    };
    console.log(rowdataj);
    $.ajax({
        async: false,
        type: "POST",
        url: 'Handler.ashx',
        data: rowdataj,
        success: function (msg) {
            //对于获取的数据执行相关的操作，如：绑定、显示等
        }
    });
};
//检查当前数据行中需要运行的字段
function CheckExpression(row) {
    for (var j = 0; j < row.cells.length; j++) {
        expn = row.parentNode.rows[0].cells[j].getAttribute("Expression");
        //如指定了公式则要求计算
        if (expn) {
            var result = Expression(row, expn);
            var format = row.parentNode.rows[0].cells[j].getAttribute("Format");
            row.cells[j].innerHTML = Expression(row, expn);
        }

    }
    var tableData = new Array();
    var sum1 = 0;
    var sum2 = 0;
    var n = document.getElementById("tabProduct").rows.length;
    for (var i = 0; i < n - 1; i++) {
        tableData.push(GetRowData(tabProduct.rows[i]));
    }
    for (var i = 0; i < n - 1; i++) {
        sum1 = parseFloat(sum1) + parseFloat(tableData[i]["ctotalprice"]);
        sum2 = parseFloat(sum2) + parseFloat(tableData[i]["stotalprice"]);
    }
    document.getElementById("tabProduct").rows[n - 1].cells[2].innerHTML = sum1.toFixed(2);
    document.getElementById("tabProduct").rows[n - 1].cells[3].innerHTML = sum2.toFixed(2);
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
    var a = expn.split("*");
    var result = parseFloat(a[0]) * 1000 * parseFloat(a[1]) * 1000 / 1000000;
    return result.toFixed(2);

}

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
