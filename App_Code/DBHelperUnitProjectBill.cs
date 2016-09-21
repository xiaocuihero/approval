using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ImportDemo;
using System.Text.RegularExpressions;
using System.Text;
/// <summary>
/// Summary description for DBHelperUnitProjectBill
/// </summary>

public class DBHelperUnitProjectBill
{
    public DBHelperUnitProjectBill()
    {

    }

    public static int Insert(UnitProjectBill bill)
    {
        int runLines = 0;
        string sqlStr = string.Format("INSERT INTO projectprice(NO, project, pcontent, totalprice, totalcompletepercent, ctotalcomplete, stotalcomplete, c_build_complete, c_setup_complete, ccomplete,s_build_complete,s_setup_complete, scomplete, period) VALUES('{0}','{1}','{2}',{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13})"
            , bill.NO
            , bill.project
            , bill.pcontent
            , bill.totalprice
            , bill.totalcompletepercent
            , bill.ctotalcomplete
            , bill.stotalcomplete
            , bill.c_build_complete
            , bill.c_setup_complete
            , bill.ccomplete
            , bill.s_build_complete
            , bill.s_setup_complete
            , bill.scomplete
            , bill.period);
        SqlConnection conn = new SqlConnection(SqlConn.ConnText);
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            SqlCommand cmd = new SqlCommand(sqlStr, conn);
            runLines = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return runLines;
    }

    public static UnitProjectBill SeletSumData(string projectName) 
    {
        string sumNo = "六";
        string sqlStr = string.Format("SELECT * FROM projectprice p WHERE p.No='{0}' AND p.project like '%{1}%'", sumNo, projectName);
        SqlConnection conn = new SqlConnection(SqlConn.ConnText);
        UnitProjectBill bill = new UnitProjectBill();
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            SqlCommand cmd = new SqlCommand(sqlStr, conn);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            bill = new UnitProjectBill(dt.Rows[0], false);
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();            
        }
        return bill;
    }

    public static List<UnitProjectBill> SeletSumDatas()
    {
        string sumNo = "六";
        string sqlStr = string.Format("SELECT * FROM projectprice p WHERE p.No='{0}'", sumNo);
        SqlConnection conn = new SqlConnection(SqlConn.ConnText);
        List<UnitProjectBill> bills = new List<UnitProjectBill>();
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            SqlCommand cmd = new SqlCommand(sqlStr, conn);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            bills = UnitProjectBill.GetList(dt, false);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return bills;
    }

    //public static string GetChineseWord(string oriText)
    //{
    //    string x = @"[\u4E00-\u9FFF]+";
    //    MatchCollection Matches = Regex.Matches
    //    (oriText, x, RegexOptions.IgnoreCase);
    //    StringBuilder sb = new StringBuilder();
    //    foreach (Match NextMatch in Matches)
    //    {
    //        sb.Append(NextMatch.Value);
    //    }
    //    return sb.ToString();
    //}
}