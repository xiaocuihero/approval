<%@ WebHandler Language="C#" Class="UnitProjectBillDBBridge" %>

using System;
using System.Web;
using ImportDemo;

public class UnitProjectBillDBBridge : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.Write(DBHelperUnitProjectBill.Insert(new UnitProjectBill(context.Request.Params)));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}