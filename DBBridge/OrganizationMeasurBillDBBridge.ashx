<%@ WebHandler Language="C#" Class="OrganizationMeasurBillDBBridge" %>

using System;
using System.Web;
using ImportDemo;

public class OrganizationMeasurBillDBBridge : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.Write(DBHelperOrganizationMeasureBill.Insert(new OrganizationMeasureBill(context.Request.Params)));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}