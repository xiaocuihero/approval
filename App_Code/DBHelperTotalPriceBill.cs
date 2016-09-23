using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ImportDemo;

/// <summary>
/// Summary description for DBHelperTotalPriceBill
/// </summary>
public class DBHelperTotalPriceBill
{
    public DBHelperTotalPriceBill()
    {

    }

    public static int Insert(TotalPriceBill bill)
    {
        int runLines = 0;
        string sqlStr = string.Format("INSERT INTO totalprice(NO, tcontent, price, totalcompletedquantity, totalcompletepercent, tpercent, ccomplete, scomplete, period) VALUES ('{0}', '{1}', {2}, {3}, {4}, {5}, {6}, {7}, {8})"
            , bill.NO
            , bill.tcontent
            , bill.price
            , bill.totalcompletedquantity
            , bill.totalcompletepercent
            , bill.tpercent
            , bill.ccomplete
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