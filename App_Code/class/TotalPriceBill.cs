using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Collections.Specialized;

/// <summary>
/// Summary description for TotalPriceBill
/// </summary>
namespace ImportDemo
{
    public class TotalPriceBill
    {

        #region 私有变量
        /// <summary>
        /// 序号
        /// </summary>
        private string _NO;
        /// <summary>
        /// 内容
        /// </summary>
        private string _tcontent;
        /// <summary>
        /// 报价（元）
        /// </summary>
        private Double _price;
        /// <summary>
        /// 至上期累计完成工程量（元）
        /// </summary>
        private Double _totalcompletedquantity;
        /// <summary>
        /// 至本期累计完成百分比
        /// </summary>
        private Double _totalcompletepercent;
        /// <summary>
        /// 本期完成百分比
        /// </summary>
        private Double _tpercent;
        /// <summary>
        /// 本期完成（元）
        /// </summary>
        private Double _ccomplete;
        /// <summary>
        /// 监理审核（元）
        /// </summary>
        private Double _scomplete;
        /// <summary>
        /// 工期
        /// </summary>
        private int _period;


        #endregion

        #region 构造函数
        public TotalPriceBill()
        {

        }

        public TotalPriceBill(DataRow dr)
        {
            NO = dr[0].C_String();
            tcontent = dr[1].C_String();
            price = dr[2].C_Double();
            totalcompletedquantity = dr[3].C_Double();
            totalcompletepercent = dr[4].C_DoubleByPercent();
            tpercent = dr[5].C_DoubleByPercent();
            ccomplete = dr[6].C_Double();
            scomplete = dr[7].C_Double();
        }

        public TotalPriceBill(NameValueCollection row)
        {
            NO = row["NO"].C_StringTrim();
            tcontent = row["tcontent"].C_StringTrim();
            price = row["price"].C_Double();
            totalcompletedquantity = row["totalcompletedquantity"].C_Double();
            totalcompletepercent = row["totalcompletepercent"].C_DoubleByPercent();
            tpercent = row["tpercent"].C_DoubleByPercent();
            ccomplete = row["ccomplete"].C_Double();
            scomplete = row["scomplete"].C_Double();
            period = 17;
        }
        #endregion

        #region 公共方法
        public static List<TotalPriceBill> GetList(DataTable dt) 
        {
            List<TotalPriceBill> dataList = new List<TotalPriceBill>();
            int rowCount = dt.Rows.Count;
            const int rowBeginIndex = 2;
            int rowEndIndex = int.MaxValue;
            for (int i = rowBeginIndex; i < rowCount - rowBeginIndex; i++) 
            {
                if (i > rowEndIndex) break;
                TotalPriceBill bill = new TotalPriceBill(dt.Rows[i]);
                string total = "大写";
                if (System.Text.RegularExpressions.Regex.IsMatch(bill.NO, total) || bill.tcontent == "") 
                {
                    rowEndIndex = i;
                }
                dataList.Add(bill);
            }
            return dataList;
        }
        #endregion

        #region 公共变量
        /// <summary>
        /// 序号
        /// </summary>
        public string NO
        {
            get { return _NO; }
            set { _NO = value; }
        }
        /// <summary>
        /// 内容
        /// </summary>
        public string tcontent
        {
            get { return _tcontent; }
            set { _tcontent = value; }
        }
        /// <summary>
        /// 报价（元）
        /// </summary>
        public Double price 
        {
            get { return _price; }
            set { _price = value; }
        }
        /// <summary>
        /// 至上期累计完成工程量（元）
        /// </summary>
        public Double totalcompletedquantity
        {
            get { return _totalcompletedquantity; }
            set { _totalcompletedquantity = value; }
        }
        /// <summary>
        /// 至本期累计完成百分比
        /// </summary>
        public Double totalcompletepercent
        {
            get { return _totalcompletepercent; }
            set { _totalcompletepercent = value; }
        }
        /// <summary>
        /// 本期完成百分比
        /// </summary>
        public Double tpercent
        {
            get { return _tpercent; }
            set { _tpercent = value; }
        }
        /// <summary>
        /// 本期完成（元）
        /// </summary>
        public Double ccomplete
        {
            get { return _ccomplete; }
            set { _ccomplete = value; }
        }
        /// <summary>
        /// 监理审核（元）
        /// </summary>
        public Double scomplete
        {
            get { return _scomplete; }
            set { _scomplete = value; }
        }
        /// <summary>
        /// 工期
        /// </summary>
        public int period
        {
            get { return _period; }
            set { _period = value; }
        }
        #endregion
    }
}