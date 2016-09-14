using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class test : System.Web.UI.Page
{
    string conStr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["mySqlConnectStrings"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void TestClick(object sender, EventArgs e)
    {

    }

    private void Test1() 
    {
        SqlConnection conn = new SqlConnection(conStr);
        conn.Open();
        SqlCommand comm = conn.CreateCommand();
        comm.CommandText = "select * from table_test";
        SqlDataAdapter adapter = new SqlDataAdapter(comm);
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        //string str = dt.Rows[0][0];
    }
}