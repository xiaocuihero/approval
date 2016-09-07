using System;
using System.Collections.Generic;


/// <summary>
/// Summary description for UnitProjectBill
/// </summary>
namespace ImportDemo {
    [Serializable]
    public class UnitProjectBill
    {
        #region 变量定义
        ///<summary>
        ///项目编号
        ///</summary>
        private string _NO;
        ///<summary>
        ///项目名称
        ///</summary>        
        private string _project;
        /// <summary>
        /// 项目内容
        /// </summary>
        private string _pcontent;
        /// <summary>
        /// 累计完成百分比
        /// </summary>
        private float _totalcompletepercent;
        /// <summary>
        /// 至上期末累计完成
        /// </summary>
        private float _ctotacomplete;
        /// <summary>
        /// 至上期末监理审核完成
        /// </summary>
        private float _stotalcomplete;
        /// <summary>
        /// 本期完成
        /// </summary>
        private float _ccomplete;
        /// <summary>
        /// 本期监理审核
        /// </summary>
        private float _scomplete;
        /// <summary>
        /// 建筑工程/安装工程
        /// </summary>
        private float _completeclass;
        /// <summary>
        /// 工程施工期
        /// </summary>
        private float _period;       
        #endregion

        #region 构造函数
        public UnitProjectBill()
        {

        }

        public UnitProjectBill(string NO, string project, string pcontent, 
            float totalcompletepercent, 
            float ctotacomplete, float stotalcomplete, 
            float ccomplete, float scomplete, 
            float completeclass, 
            float period) 
        {
            _NO = NO;
            _project = project;
            _pcontent = pcontent;
            _totalcompletepercent = totalcompletepercent;
            _ctotacomplete = ctotacomplete;
            _stotalcomplete = stotalcomplete;
            _ccomplete = ccomplete;
            _scomplete = scomplete;
            _completeclass = completeclass;
            _period = period;
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
        public string project
        {
            get { return _project; }
            set { _project = value; }
        }
        /// <summary>
        /// 项目内容
        /// </summary>
        public string pcontent
        {
            get { return _pcontent; }
            set { _pcontent = value; }
        }
        /// <summary>
        /// 累计完成百分比
        /// </summary>
        public float totalcompletepercent
        {
            get { return _totalcompletepercent; }
            set { _totalcompletepercent = value; }
        }
        /// <summary>
        /// 至上期末累计完成
        /// </summary>
        public float ctotacomplete
        {
            get { return _ctotacomplete; }
            set { _ctotacomplete = value; }
        }
        /// <summary>
        /// 至上期末监理审核完成
        /// </summary>
        public float stotalcomplete
        {
            get { return _stotalcomplete; }
            set { _stotalcomplete = value; }
        }
        /// <summary>
        /// 本期完成
        /// </summary>
        public float ccomplete
        {
            get { return _ccomplete; }
            set { _ccomplete = value; }
        }
        /// <summary>
        /// 本期监理审核
        /// </summary>
        public float scomplete
        {
            get { return _scomplete; }
            set { _scomplete = value; }
        }
        /// <summary>
        /// 建筑工程/安装工程
        /// </summary>
        public float completeclass
        {
            get { return _completeclass; }
            set { _completeclass = value; }
        }
        /// <summary>
        /// 工程施工期
        /// </summary>
        public float period
        {
            get { return _period; }
            set { _period = value; }
        }
        #endregion
    }
}
