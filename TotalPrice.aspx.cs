using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ImportDemo;
using System.Data.OleDb;
using System.Data;
using ImportDemo;

public partial class TotalPrice : System.Web.UI.Page
{
    private string excelConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ExcelConnectionString"].ConnectionString;
    public List<TotalPriceBill> dataList = new List<TotalPriceBill>();
    public List<UnitProjectBill> unitDataList = new List<UnitProjectBill>();

    protected void Page_Load(object sender, EventArgs e)
    {
        unitDataList = DBHelperUnitProjectBill.SeletSumDatas();
    }

    protected void btnImpot_Click(object sender, EventArgs e)
    {
        
    }


    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private UnitProjectBill CheckCComplete(ImportDemo.TotalPriceBill tbill) 
    {
        string project = tbill.tcontent;
        foreach (UnitProjectBill ubill in unitDataList) 
        {
            if (ubill.project.Contains(project)) 
            {
                return ubill;
            }
        }
        return null;
    }


}