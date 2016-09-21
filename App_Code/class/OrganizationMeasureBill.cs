using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Collections.Specialized;

/// <summary>
/// Summary description for OrganizationMeasureBill
/// </summary>
namespace ImportDemo
{

    public class OrganizationMeasureBill
    {
        #region 私有变量
        /// <summary>
        /// 项目名称
        /// </summary>
        private string _organizationName;
        /// <summary>
        /// 序号
        /// </summary>
        private string _NO;
        /// <summary>
        /// 项目名称
        /// </summary>
        private string _contentname;
        /// <summary>
        /// 单位
        /// </summary>
        private string _unite;
        /// <summary>
        /// 数量
        /// </summary>
        private Double _quantity;
        /// <summary>
        /// 金额
        /// </summary>
        private Double _price;
        /// <summary>
        /// 至上期累计支付（元）
        /// </summary>
        private Double _totalcompleteprice;
        /// <summary>
        /// 本期上报金额
        /// </summary>
        private Double _ccompleteprice;
        /// <summary>
        /// 监理审核
        /// </summary>
        private Double _scompleteprice;
        /// <summary>
        /// 备注
        /// </summary>
        private string _bak;
        /// <summary>
        /// 工期序号
        /// </summary>
        private int _period;
        #endregion

        #region 构造函数
        public OrganizationMeasureBill()
        {

        }

        public OrganizationMeasureBill(DataRow dr)
        {
            if (dr.ItemArray.Length > 8)
            {
                NO = dr[0].C_String();
                contentname = dr[1].C_String();
                unite = dr[2].C_String();
                quantity = dr[3].C_Double();
                price = dr[4].C_Double();
                totalcompleteprice = dr[5].C_Double();
                ccompleteprice = dr[6].C_Double();
                scompleteprice = dr[7].C_Double();
                bak = dr[8].C_String();
            }
            else {
                NO = dr[0].C_String();
                price = dr[1].C_Double();
                totalcompleteprice = dr[2].C_Double();
                ccompleteprice = dr[3].C_Double();
                scompleteprice = dr[4].C_Double();
            }
        }

        public OrganizationMeasureBill(NameValueCollection row)
        {
            organizationName = row["organizationName"].C_StringTrim();
            NO = row["NO"].C_StringTrim();
            contentname = row["contentname"].C_StringTrim();
            unite = row["unite"].C_StringTrim();
            quantity = row["quantity"].C_Double();
            price = row["price"].C_Double();
            totalcompleteprice = row["totalcompleteprice"].C_Double();
            ccompleteprice = row["ccompleteprice"].C_Double();
            scompleteprice = row["scompleteprice"].C_Double();
            bak = row["bak"].C_StringTrim();
            period = 17;
        }
        #endregion

        #region 公共方法
        public static List<OrganizationMeasureBill> GetList(DataTable dt) 
        {
            List<OrganizationMeasureBill> dataList = new List<OrganizationMeasureBill>();
            int rowCount = dt.Rows.Count;
            const int rowBeginIndex = 2;
            int rowEndIndex = int.MaxValue;
            for (int i = rowBeginIndex; i < rowCount - rowBeginIndex; i++) 
            {
                if (i > rowEndIndex) break;
                OrganizationMeasureBill bill = new OrganizationMeasureBill(dt.Rows[i]);
                string total = "合计";
                if (System.Text.RegularExpressions.Regex.IsMatch(bill.NO, total))
                {
                    rowEndIndex = i + 1;
                }
                dataList.Add(bill);
            }
            return dataList;
        }
        #endregion

        #region 公共变量
        /// <summary>
        /// 组织名称
        /// </summary>
        public string organizationName
        {
            get { return _organizationName; }
            set { _organizationName = value; }
        }
        /// <summary>
        /// 序号
        /// </summary>
        public string NO
        {
            get { return _NO; }
            set { _NO = value; }
        }
        /// <summary>
        /// 项目名称
        /// </summary>
        public string contentname
        {
            get { return _contentname; }
            set { _contentname = value; }
        }
        /// <summary>
        /// 单位
        /// </summary>
        public string unite
        {
            get { return _unite; }
            set { _unite = value; }
        }
        /// <summary>
        /// 数量
        /// </summary>
        public Double quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }
        /// <summary>
        /// 金额
        /// </summary>
        public Double price
        {
            get { return _price; }
            set { _price = value; }
        }
        /// <summary>
        /// 至上期累计支付（元）
        /// </summary>
        public Double totalcompleteprice
        {
            get { return _totalcompleteprice; }
            set { _totalcompleteprice = value; }
        }
        /// <summary>
        /// 本期上报金额
        /// </summary>
        public Double ccompleteprice
        {
            get { return _ccompleteprice; }
            set { _ccompleteprice = value; }
        }
        /// <summary>
        /// 监理审核
        /// </summary>
        public Double scompleteprice
        {
            get { return _scompleteprice; }
            set { _scompleteprice = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string bak
        {
            get { return _bak; }
            set { _bak = value; }
        }
        /// <summary>
        /// 工期序号
        /// </summary>
        public int period
        {
            get { return _period; }
            set { _period = value; }
        }
        #endregion
    }
}