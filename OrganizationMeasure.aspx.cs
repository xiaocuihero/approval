using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ImportDemo;
using System.Data.OleDb;
using System.Data;

public partial class OrganizationMeasure : System.Web.UI.Page
{
    private string excelConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ExcelConnectionString"].ConnectionString;
    public List<OrganizationMeasureBill> dataList = new List<OrganizationMeasureBill>();
    public string organizationName = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnImpot_Click(object sender, EventArgs e)
    {
        if (!this.FileUpload1.HasFile)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>alert('请选择导入的Excel表！');</script>");
            return;
        }
        //判断导入文件是否正确
        string Extension = System.IO.Path.GetExtension(this.FileUpload1.FileName).ToString().ToLower();
        if (Extension != ".xls" && Extension != ".xlsx")
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>alert('您导入的Excel文件不正确，请确认后重试！');</script>");
            return;
        }

        string fileName = DateTime.Now.ToString("yyyyMMddhhmmssmmmm") + this.FileUpload1.FileName;
        Session["filename"] = fileName;
        //保存路径
        string filePath = Server.MapPath("Excel/") + fileName;
        Session["filepath"] = filePath;
        //将文件保存到服务器上
        FileUpload1.SaveAs(filePath);
        setdropdownlist(filePath);
        this.DropDownList1.SelectedIndex = 0;
        GetExcelSheet(filePath, fileName);
    }

    private void GetExcelSheet(string filePath, string fileName)
    {
        OleDbConnection conn = new OleDbConnection(string.Format(excelConnectionString, filePath));
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }

            System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            //获取Excel的第一个Sheet名称
            string sheetName = this.DropDownList1.SelectedItem.Text;

            //查询sheet中的数据
            string strSql = "select * from [" + sheetName + "]";
            OleDbDataAdapter da = new OleDbDataAdapter(strSql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, filePath);
            System.Data.DataTable dt = ds.Tables[0];
            //Fixed it
            organizationName = dt.Rows[1][0].ToString();
            dataList = OrganizationMeasureBill.GetList(dt);
        }
        catch (Exception exc)
        {
            throw exc;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }

    private void setdropdownlist(string filePath)
    {
        this.DropDownList1.Items.Clear();

        OleDbConnection conn = new OleDbConnection(string.Format(excelConnectionString, filePath));
        try
        {
            //打开连接
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            //获取Excel的第一个Sheet名称
            string sheetName = schemaTable.Rows[0]["TABLE_NAME"].ToString().Trim();
            for (int i = 0; i < schemaTable.Rows.Count - 1; i++)
            {
                this.DropDownList1.Items.Add(new ListItem(schemaTable.Rows[i]["TABLE_NAME"].ToString().Trim(), i.ToString()));
            }

        }
        catch (Exception exc)
        {
            throw exc;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetExcelSheet(Session["filepath"].ToString(), Session["filename"].ToString());
    }
}