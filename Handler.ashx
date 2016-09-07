<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       
        ImportDemo.Detailbill dbill = new ImportDemo.Detailbill();
        dbill.NO = context.Request.Params["No"].ToString();
        dbill.pname = context.Request.Params["pname"].ToString();
        dbill.pdescription = context.Request.Params["pdescription"].ToString();
        dbill.punite = context.Request.Params["punite"].ToString();
        dbill.pquantity = Convert.ToSingle(context.Request.Params["pquantity"].ToString());
        dbill.completequantity = Convert.ToSingle(context.Request.Params["cAmount"]);
        dbill.ccompletedquantity = Convert.ToSingle(context.Request.Params["ccompletedquantity"]);
        dbill.scompletequantity = Convert.ToSingle(context.Request.Params["sAmount"]);
        dbill.price = Convert.ToSingle(context.Request.Params["price"]);
        dbill.ctotalprice = Convert.ToSingle(context.Request.Params["ctotalprice"]);
        dbill.stotalprice = Convert.ToSingle(context.Request.Params["stotalprice"]);
        string dname = context.Request.Params["dname"];
        ImportDemo.DBHelper.Add(dname, dbill);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}