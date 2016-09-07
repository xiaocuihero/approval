using System;
using System.Collections.Generic;
namespace ImportDemo
{
    /// <summary>
    ///
    /// </summary>
    [Serializable]
    public class Detailbill
    {
        #region 变量定义
        ///<summary>
        ///项目编号
        ///</summary>
        private string _NO;
        ///<summary>
        ///项目名称
        ///</summary>
        private string _pname = String.Empty;
        ///<summary>
        ///项目特征描述
        ///</summary>
        private string _pdescription = String.Empty;
        ///<summary>
        ///计量单位
        ///</summary>
        private string _punite = String.Empty;
        ///<summary>
        ///清单工程量
        ///</summary>
        private float _pquantity;
        ///<summary>
        ///上报完成工程量
        ///</summary>
        private float _completequantity;
        ///<summary>
        ///直上月审核工程量
        ///</summary>
        private float _ccompletedquantity;
        ///<summary>
        ///监理审核工程量
        ///</summary>
        private float _scompletequantity;
        ///<summary>
        ///综合单价（元）
        ///</summary>
        private float _price;
        ///<summary>
        ///申报合价
        ///</summary>
        private float _ctotalprice;
        ///<summary>
        ///监理合价
        ///</summary>
        private float _stotalprice;
        
        #endregion

        #region 构造函数
        ///<summary>
        ///
        ///</summary>
        public Detailbill()
        {
        }
        ///<summary>
        ///
        ///</summary>
        public Detailbill
        (
            string NO,
            string pname,
            string pdescription,
            string punite,
            float pquantity,
            float completequantity,
            float ccompletedquantity,
            float scompletequantity,
            float price,
            float ctotalprice,
            float stotalprice
        )
        {
            _NO = NO;
            _pname = pname;
            _pdescription = pdescription;
            _punite = punite;
            _pquantity = pquantity;
            _completequantity = completequantity;
            _ccompletedquantity = ccompletedquantity;
            _scompletequantity = scompletequantity;
            _price = price;
            _ctotalprice = ctotalprice;
            _stotalprice = stotalprice;
            

        }
        #endregion

        #region 公共属性

        ///<summary>
        ///项目编号
        ///</summary>
        public string NO
        {
            get { return _NO; }
            set { _NO = value; }
        }

        ///<summary>
        ///项目名称
        ///</summary>
        public string pname
        {
            get { return _pname; }
            set { _pname = value; }
        }

        ///<summary>
        ///项目特征描述
        ///</summary>
        public string pdescription
        {
            get { return _pdescription; }
            set { _pdescription = value; }
        }

        ///<summary>
        ///计量单位
        ///</summary>
        public string punite
        {
            get { return _punite; }
            set { _punite = value; }
        }

        ///<summary>
        ///清单工程量
        ///</summary>
        public float pquantity
        {
            get { return _pquantity; }
            set { _pquantity = value; }
        }

        ///<summary>
        ///上报完成工程量
        ///</summary>
        public float completequantity
        {
            get { return _completequantity; }
            set { _completequantity = value; }
        }

        ///<summary>
        ///直上月审核工程量
        ///</summary>
        public float ccompletedquantity
        {
            get { return _ccompletedquantity; }
            set { _ccompletedquantity = value; }
        }

        ///<summary>
        ///监理审核工程量
        ///</summary>
        public float scompletequantity
        {
            get { return _scompletequantity; }
            set { _scompletequantity = value; }
        }

        ///<summary>
        ///综合单价（元）
        ///</summary>
        public float price
        {
            get { return _price; }
            set { _price = value; }
        }

        ///<summary>
        ///申报合价
        ///</summary>
        public float ctotalprice
        {
            get { return _ctotalprice; }
            set { _ctotalprice = value; }
        }

        ///<summary>
        ///监理合价
        ///</summary>
        public float stotalprice
        {
            get { return _stotalprice; }
            set { _stotalprice = value; }
        }
        #endregion
    }
}
