using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ImportDemo;
/// <summary>
/// Summary description for DBHelperOrganizationMeasureBill
/// </summary>
public class DBHelperOrganizationMeasureBill
{
	public DBHelperOrganizationMeasureBill()
	{
		
	}

    public static int Insert(OrganizationMeasureBill bill) 
    {
        int runLines = 0;
        string sqlStr = string.Format("INSERT INTO organizationalmeasure(NO, contentname, unite, quantity, price, totalcompleteprice, ccompleteprice, scompleteprice, bak, period) VALUES('{0}','{1}','{2}',{3},{4},{5},{6},{7},'{8}',{9})"
            ,bill.NO
            ,bill.contentname
            ,bill.unite
            ,bill.quantity
            ,bill.price
            ,bill.totalcompleteprice
            ,bill.ccompleteprice
            ,bill.scompleteprice
            ,bill.bak
            ,bill.period);
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