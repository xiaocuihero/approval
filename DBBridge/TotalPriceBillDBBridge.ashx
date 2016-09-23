<%@ WebHandler Language="C#" Class="TotalPriceBillDBBridge" %>

using System;
using System.Web;

public class TotalPriceBillDBBridge : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.Write(DBHelperTotalPriceBill.Insert(new ImportDemo.TotalPriceBill(context.Request.Params)));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}