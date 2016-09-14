using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OrganizationMeasureBill
/// </summary>
namespace ImportDemo
{

    public class OrganizationMeasureBill
    {
        #region 私有变量
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
        private Single _quantity;
        /// <summary>
        /// 金额
        /// </summary>
        private Single _price;
        /// <summary>
        /// 至上期累计支付（元）
        /// </summary>
        private Single _totalcompleteprice;
        /// <summary>
        /// 本期上报金额
        /// </summary>
        private Single _ccompleteprice;
        /// <summary>
        /// 监理审核
        /// </summary>
        private Single _scompleteprice;
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
        public Single quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }
        /// <summary>
        /// 金额
        /// </summary>
        public Single price
        {
            get { return _price; }
            set { _price = value; }
        }
        /// <summary>
        /// 至上期累计支付（元）
        /// </summary>
        public Single totalcompleteprice
        {
            get { return _totalcompleteprice; }
            set { _totalcompleteprice = value; }
        }
        /// <summary>
        /// 本期上报金额
        /// </summary>
        public Single ccompleteprice
        {
            get { return _ccompleteprice; }
            set { _ccompleteprice = value; }
        }
        /// <summary>
        /// 监理审核
        /// </summary>
        public Single scompleteprice
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