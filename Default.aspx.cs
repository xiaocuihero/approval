using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using ImportDemo;
using Microsoft.Office.Interop.Excel;
using System.Reflection;

    public partial class _Default : System.Web.UI.Page
    {
        public List<Detailbill> listdetailbill = new List<Detailbill>();
        public string unitpname = "";
        public float cctotal = 0;
        public float sstotal = 0;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// 导入
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnImpot_Click(object sender, EventArgs e)
        {
            //是否含有文件
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
            //拼接服务器文件名
            string FileName = DateTime.Now.ToString("yyyyMMddhhmmssmmmm") + this.FileUpload1.FileName;
            Session["filename"]= FileName;
            //保存路径
            string savePath = Server.MapPath("Excel/") + FileName;
            Session["filepath"] = savePath;
            //将文件保存到服务器上
            FileUpload1.SaveAs(savePath);
            setdropdownlist(savePath, FileName);
            this.DropDownList1.SelectedIndex = 0;
            GetExcelSheet(savePath, FileName);
            //将Excel中的数据放到DataTable中
            
            //向数据库中插入数据
            //int i = InsetData(dt);

            //提示导入成功数据
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "<script>alert('成功导入" + i + "条数据！');</script>");
        }
        /// <summary>
        /// 将Excel中的数据放到DataTable中
        /// </summary>
        /// <param name="strFileName">路径</param>
        /// <param name="strFileName">表名</param>
        /// <returns>DataTable数据</returns>
        public void GetExcelSheet(string fileUrl, string table)
        {
            //office2007之前 仅支持.xls
            //const string cmdText = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;IMEX=1';";
            //支持.xls和.xlsx，即包括office2010等版本的   HDR=Yes代表第一行是标题，不是数据；
            //string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + fileUrl + ";Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
            const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
            //建立连接
            OleDbConnection conn = new OleDbConnection(string.Format(cmdText, fileUrl));
            try
            {
                //打开连接
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
                da.Fill(ds, table);
                int n = ds.Tables[0].Rows.Count;
                int nc = 0;
                unitpname = ds.Tables[0].Rows[0][0].ToString();
                
                for (int i = 3; i < n-3; i++)
                {
                    if (ds.Tables[0].Rows[i][0].ToString().Equals("合   计"))
                    {
                        nc = i;
                        break;
                        
                    }
                    DataRow dr = ds.Tables[0].Rows[i];
                    listdetailbill.Add(Selectdetail(dr));
                    //InsetData(unitpname,dr);
                }
                if (nc == 0)
                {
                    cctotal = Convert.ToSingle(ds.Tables[0].Rows[n - 3][10].ToString());
                    sstotal = Convert.ToSingle(ds.Tables[0].Rows[n - 3][11].ToString());
                }
                else
                {
                    cctotal = Convert.ToSingle(ds.Tables[0].Rows[nc][10].ToString());
                    sstotal = Convert.ToSingle(ds.Tables[0].Rows[nc][11].ToString());
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
        /// <summary>
        /// 设置下拉框的值
        /// </summary>
        /// <param name="dt">Excel中的DataTable数据</param>
        public void setdropdownlist(string fileUrl, string table)
        {
            this.DropDownList1.Items.Clear();
            const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
            //建立连接
            OleDbConnection conn = new OleDbConnection(string.Format(cmdText, fileUrl));
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
        /// <summary>
        /// 向数据库插入数据
        /// </summary>
        /// <param name="dt">Excel中的DataTable数据</param>
        public void InsetData(string dname,DataRow dr)
        {
           

                Detailbill dbill = new Detailbill();
                dbill.NO = dr[1].ToString();
                dbill.pname = dr[2].ToString();
                dbill.pdescription = dr[3].ToString();
                dbill.punite = dr[4].ToString();
                dbill.pquantity = ((dr[5]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[5].ToString());
                dbill.completequantity = ((dr[6]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[6]);
                dbill.ccompletedquantity = ((dr[7]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[7]);
                dbill.scompletequantity = ((dr[8]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[8]);
                dbill.price = ((dr[9]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[9]);
                dbill.ctotalprice = ((dr[10]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[10]);
                dbill.stotalprice = ((dr[11]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[11]);

                DBHelper.Add(dname, dbill);
          
            
        }
        public Detailbill Selectdetail(DataRow dr)
        {
            Detailbill obj = new Detailbill();
            obj.NO = dr[1].ToString();
            obj.pname = dr[2].ToString();
            obj.pdescription = dr[3].ToString();
            obj.punite = dr[4].ToString();
            obj.pquantity = ((dr[5]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[5]);
            obj.completequantity = ((dr[6]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[6]);
            obj.ccompletedquantity = ((dr[7]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[7]);
            obj.scompletequantity = ((dr[8]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[8]);
            obj.price = ((dr[9]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[9]);
            obj.ctotalprice = ((dr[10]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[10]);
            obj.stotalprice = ((dr[11]) == DBNull.Value) ? 0 : Convert.ToSingle(dr[11]);            
            return obj;
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

        }
        public double ColumnSum(System.Data.DataTable dt, string ColumnName)
        {
            double d = 0;
            foreach (DataRow row in dt.Rows)
            {
                d += double.Parse(row[ColumnName].ToString());
            }            
            return d;
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetExcelSheet(Session["filepath"].ToString(), Session["filename"].ToString());
        }
       
}

