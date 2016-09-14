using System;
using System.Data;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Collections.Specialized;

/// <summary>
/// Summary description for UnitProjectBill
/// </summary>
namespace ImportDemo
{
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
        /// 总费用
        /// </summary>
        private Single _totalprice;
        /// <summary>
        /// 累计完成百分比
        /// </summary>
        private Single _totalcompletepercent;
        /// <summary>
        /// 至上期末累计完成
        /// </summary>
        private Single _ctotalcomplete;
        /// <summary>
        /// 至上期末监理审核完成
        /// </summary>
        private Single _stotalcomplete;
        /// <summary>
        /// 本期建筑工程完成
        /// </summary>
        private Single _c_build_complete;
        /// <summary>
        /// 本期安装工程
        /// </summary>
        private Single _c_setup_complete;
        /// <summary>
        /// 本期完成
        /// </summary>
        private Single _ccomplete;
        /// <summary>
        /// 本期监理建筑工程完成
        /// </summary>
        private Single _s_build_complete;
        /// <summary>
        /// 本期监理安装工程
        /// </summary>
        private Single _s_setup_complete;
        /// <summary>
        /// 本期监理审核
        /// </summary>        
        private Single _scomplete;
        /// <summary>
        /// 工程施工期
        /// </summary>
        private Single _period;
        #endregion

        #region 私有变量
        /// <summary>
        /// 读excel时 数据开始的那一行
        /// </summary>
        private const int excelBeginIndex = 4;



        #endregion

        #region 构造函数
        public UnitProjectBill()
        {

        }

        //public UnitProjectBill(string NO, string project, string pcontent,
        //    Single totalprice,
        //    Single totalcompletepercent,
        //    Single ctotalcomplete, Single stotalcomplete,            
        //    Single ccomplete, Single scomplete,
        //    Single period)
        //{
        //    _NO = NO;
        //    _project = project;
        //    _pcontent = pcontent;
        //    _totalprice = totalprice;
        //    _totalcompletepercent = totalcompletepercent;
        //    _ctotalcomplete = ctotalcomplete;
        //    _stotalcomplete = stotalcomplete;
        //    _ccomplete = ccomplete;
        //    _scomplete = scomplete;
        //    _period = period;
        //}

        public UnitProjectBill(DataRow dr, bool isExecl)
        {
            if (isExecl)
            {
                if (dr.ItemArray.Length > 11)
                {
                    NO = dr[0].C_String();
                    pcontent = dr[1].C_String();
                    totalprice = dr[2].C_Single();
                    totalcompletepercent = dr[3].C_SingleByPercent();
                    ctotalcomplete = dr[4].C_Single();
                    stotalcomplete = dr[5].C_Single();
                    c_build_complete = dr[6].C_Single();
                    c_setup_complete = dr[7].C_Single();
                    ccomplete = dr[8].C_Single() == 0 ? c_build_complete : dr[8].C_Single();
                    s_build_complete = dr[9].C_Single();
                    s_setup_complete = dr[10].C_Single();
                    scomplete = dr[11].C_Single() == 0 ? s_build_complete : dr[11].C_Single();
                }
                else {
                    NO = dr[0].C_String();
                    pcontent = dr[1].C_String();
                    totalprice = dr[2].C_Single();
                    totalcompletepercent = dr[3].C_SingleByPercent();
                    ctotalcomplete = dr[4].C_Single();
                    stotalcomplete = dr[5].C_Single();
                    ccomplete = dr[6].C_Single();
                    scomplete = dr[7].C_Single();
                }
            }
            else
            {
                //NO = dr["NO"].C_String();
                //project = dr["project"].C_String();
                //pcontent = dr["pcontent"].C_String();
                //totalprice = dr["totalprice"].C_Single();
                //totalcompletepercent = dr["totalcompletepercent"].C_SingleByPercent();
                //ctotalcomplete = dr["ctotalcomplete"].C_Single();
                //stotalcomplete = dr["stotalcomplete"].C_Single();
                //ccomplete = dr["ccomplete"].C_Single();
                //scomplete = dr["scomplete"].C_Single();
                //period = dr["period"].C_int();
            }
        }

        public UnitProjectBill(NameValueCollection row) 
        {
            project = row["unitName"].C_StringTrim();
            NO = row["NO"].C_StringTrim();
            pcontent = row["pcontent"].C_StringTrim();
            totalprice = row["totalprice"].C_Single();
            totalcompletepercent = row["totalcompletepercent"].C_SingleByPercent();
            ctotalcomplete = row["ctotalcomplete"].C_Single();
            stotalcomplete = row["stotalcomplete"].C_Single();
            c_build_complete = row["c_build_complete"].C_Single();
            c_setup_complete = row["c_setup_complete"].C_Single();
            ccomplete = row["ccomplete"].C_Single();
            s_build_complete = row["s_build_complete"].C_Single();
            s_setup_complete = row["s_setup_complete"].C_Single();
            scomplete = row["scomplete"].C_Single();
            period = 17;
        }

        #endregion

        #region 批量获取

        public static List<UnitProjectBill> GetList(DataTable dt, bool isExcel)
        {
            List<UnitProjectBill> dataList = new List<UnitProjectBill>();
            if (isExcel)
            {
                int rowCount = dt.Rows.Count;
                int rowEndIndex = 0;
                for (int i = excelBeginIndex; i < rowCount - excelBeginIndex + 1; i++)
                {
                    UnitProjectBill upb = new UnitProjectBill(dt.Rows[i], true);
                    string total = "总报价";
                    if (Regex.IsMatch(upb.NO, total)) 
                    {
                        rowEndIndex = i;
                        break;
                    }
                    dataList.Add(upb);
                }
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dataList.Add(new UnitProjectBill(dr, isExcel));
                }
            }
            return dataList;
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
        /// 总费用
        /// </summary>
        public Single totalprice
        {
            get { return _totalprice; }
            set { _totalprice = value; }
        }
        /// <summary>
        /// 累计完成百分比
        /// </summary>
        public Single totalcompletepercent
        {
            get { return _totalcompletepercent; }
            set { _totalcompletepercent = value; }
        }
        /// <summary>
        /// 至上期末累计完成
        /// </summary>
        public Single ctotalcomplete
        {
            get { return _ctotalcomplete; }
            set { _ctotalcomplete = value; }
        }
        /// <summary>
        /// 至上期末监理审核完成
        /// </summary>
        public Single stotalcomplete
        {
            get { return _stotalcomplete; }
            set { _stotalcomplete = value; }
        }
        /// <summary>
        /// 本期建筑工程完成
        /// </summary>
        public Single c_build_complete
        {
            get { return _c_build_complete; }
            set { _c_build_complete = value; }
        }
        /// <summary>
        /// 本期安装工程完成
        /// </summary>
        public Single c_setup_complete
        {
            get { return _c_setup_complete; }
            set { _c_setup_complete = value; }
        }
        /// <summary>
        /// 本期完成
        /// </summary>
        public Single ccomplete
        {
            get { return _ccomplete; }
            set { _ccomplete = value; }
        }
        /// <summary>
        /// 本期建筑工程监理审核
        /// </summary>
        public Single s_build_complete
        {
            get { return _s_build_complete; }
            set { _s_build_complete = value; }
        }
        /// <summary>
        /// 本期安装工程监理审核
        /// </summary>
        public Single s_setup_complete
        {
            get { return _s_setup_complete; }
            set { _s_setup_complete = value; }
        }
        /// <summary>
        /// 本期监理审核
        /// </summary>
        public Single scomplete
        {
            get { return _scomplete; }
            set { _scomplete = value; }
        }

        /// <summary>
        /// 工程施工期
        /// </summary>
        public Single period
        {
            get { return _period; }
            set { _period = value; }
        }
        #endregion

    }
}
