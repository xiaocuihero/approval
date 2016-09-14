using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ImportDemo;
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
}