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
        #region ��������
        ///<summary>
        ///��Ŀ���
        ///</summary>
        private string _NO;
        ///<summary>
        ///��Ŀ����
        ///</summary>
        private string _pname = String.Empty;
        ///<summary>
        ///��Ŀ��������
        ///</summary>
        private string _pdescription = String.Empty;
        ///<summary>
        ///������λ
        ///</summary>
        private string _punite = String.Empty;
        ///<summary>
        ///�嵥������
        ///</summary>
        private float _pquantity;
        ///<summary>
        ///�ϱ���ɹ�����
        ///</summary>
        private float _completequantity;
        ///<summary>
        ///ֱ������˹�����
        ///</summary>
        private float _ccompletedquantity;
        ///<summary>
        ///������˹�����
        ///</summary>
        private float _scompletequantity;
        ///<summary>
        ///�ۺϵ��ۣ�Ԫ��
        ///</summary>
        private float _price;
        ///<summary>
        ///�걨�ϼ�
        ///</summary>
        private float _ctotalprice;
        ///<summary>
        ///����ϼ�
        ///</summary>
        private float _stotalprice;
        
        #endregion

        #region ���캯��
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

        #region ��������

        ///<summary>
        ///��Ŀ���
        ///</summary>
        public string NO
        {
            get { return _NO; }
            set { _NO = value; }
        }

        ///<summary>
        ///��Ŀ����
        ///</summary>
        public string pname
        {
            get { return _pname; }
            set { _pname = value; }
        }

        ///<summary>
        ///��Ŀ��������
        ///</summary>
        public string pdescription
        {
            get { return _pdescription; }
            set { _pdescription = value; }
        }

        ///<summary>
        ///������λ
        ///</summary>
        public string punite
        {
            get { return _punite; }
            set { _punite = value; }
        }

        ///<summary>
        ///�嵥������
        ///</summary>
        public float pquantity
        {
            get { return _pquantity; }
            set { _pquantity = value; }
        }

        ///<summary>
        ///�ϱ���ɹ�����
        ///</summary>
        public float completequantity
        {
            get { return _completequantity; }
            set { _completequantity = value; }
        }

        ///<summary>
        ///ֱ������˹�����
        ///</summary>
        public float ccompletedquantity
        {
            get { return _ccompletedquantity; }
            set { _ccompletedquantity = value; }
        }

        ///<summary>
        ///������˹�����
        ///</summary>
        public float scompletequantity
        {
            get { return _scompletequantity; }
            set { _scompletequantity = value; }
        }

        ///<summary>
        ///�ۺϵ��ۣ�Ԫ��
        ///</summary>
        public float price
        {
            get { return _price; }
            set { _price = value; }
        }

        ///<summary>
        ///�걨�ϼ�
        ///</summary>
        public float ctotalprice
        {
            get { return _ctotalprice; }
            set { _ctotalprice = value; }
        }

        ///<summary>
        ///����ϼ�
        ///</summary>
        public float stotalprice
        {
            get { return _stotalprice; }
            set { _stotalprice = value; }
        }
        #endregion
    }
}
