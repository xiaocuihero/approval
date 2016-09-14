using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
///Class1 的摘要说明
/// </summary>
namespace ImportDemo
{
    public class SqlConn
    {
        /// <summary>
        /// 获得连接字符串
        /// </summary>
        public static string ConnText
        {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["DbLink"].ConnectionString; ; }
        }
    }
    public class DBHelper
    {
        public DBHelper()
        { }
        /// <summary>
        /// 增加
        /// </summary>
        /// <param name="per">人员类</param>
        /// <returns>成功返回1，否则返回0</returns>
        public static int Add(string dname,Detailbill per)
        {
            int count = 0;
            string cmdText = "INSERT INTO uintprice(project,unitNO,unitname,unitcontent,unite,billquantity,ccompletequantity,totalcompletequantity,scompletequantity,price,ctotalprice,stotalprice,category,period) values ('"+dname+"','"+per.NO+"','"+per.pname+"','"+per.pdescription+"','"+per.punite+"'," + per.pquantity + ","+per.completequantity+","+per.ccompletedquantity+","+per.scompletequantity+","+per.price+","+per.ctotalprice+","+per.stotalprice+",1,17)";
            SqlConnection conn = new SqlConnection(SqlConn.ConnText);
            try
            {
                //打开连接
                if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                SqlCommand cmd = new SqlCommand(cmdText, conn);
                //SqlParameter[] sqlparas = { new SqlParameter("@project",dname),
                //                        new  SqlParameter("@unitNO",per.NO),
                //                        new SqlParameter("@unitname",per.pname),
                //                        new SqlParameter("@unitcontent",per.pdescription),
                //                        new SqlParameter("@unite",per.punite),
                //                        //new SqlParameter("@billquantity",per.pquantity),
                //                        new SqlParameter("@ccompletequantity",per.completequantity),
                //                        new SqlParameter("@totalcompletequantity",per.ccompletedquantity),
                //                        new SqlParameter("@scompletequantity",per.scompletequantity),
                //                        new SqlParameter("@price",per.price),
                //                        new SqlParameter("@ctotalprice",per.ctotalprice),
                //                        new SqlParameter("@stotalprice",per.stotalprice),
                //                        new SqlParameter("@category",1),
                //                        new SqlParameter("@period",17)
                //                        };
                //cmd.Parameters.AddRange(sqlparas);
                string t=cmd.CommandText;
                count = cmd.ExecuteNonQuery();

            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                conn.Close();
            }
            return count;
        }



    }
}