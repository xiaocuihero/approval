using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

namespace ImportDemo {
    public static class ObjectTypeConvertExtension
    {
        public static int C_int(this object ob)
        {
            int rs = 0;
            if (ob == DBNull.Value || ob == null || !int.TryParse(ob.ToString(), out rs))
            {
                return 0;
            }
            return rs;
        }

        //public static Single C_Single(this object ob)
        //{
        //    Single rs = 0;
        //    if (ob == DBNull.Value || ob == null || !Single.TryParse(ob.ToString(), out rs))
        //    {
        //        return 0;
        //    }
        //    return rs;
        //}

        public static Double C_Double(this object ob)
        {
            Double rs = 0;
            if (ob == DBNull.Value || ob == null || !Double.TryParse(ob.ToString(), out rs))
            {
                return 0;
            }
            return rs;
        }

        public static string C_String(this object ob)
        {
            if (ob == DBNull.Value || ob == null)
            {
                return "";
            }
            return ob.ToString();
        }

        //public static Single C_SingleByPercent(this object ob)
        //{
        //    Single rs = 0;
        //    string strNoP = ob.ToString().Replace("%", "");
        //    if (strNoP == "" || ob == null || !Single.TryParse(strNoP, out rs))
        //    {
        //        return 0;
        //    }
        //    return rs / 100;
        //}

        public static Double C_DoubleByPercent(this object ob)
        {
            Double rs = 0;
            if (ob == null) { return 0; }
            string strNoP = ob.ToString().Replace("%", "");
            if (strNoP == "" || !Double.TryParse(strNoP, out rs))
            {
                return 0;
            }
            return rs / 100;
        }

        public static string C_SingleToPercent(this float si)
        {
            return si.ToString("00%");
        }

        public static string C_StringTrim(this object ob) 
        {
            return ob.C_String().Replace("\n", "").Replace(" ", "");
        }

        public static string ConvertToChinese(double x)
        {
            string s = x.ToString("#L#E#D#C#K#E#D#C#J#E#D#C#I#E#D#C#H#E#D#C#G#E#D#C#F#E#D#C#.0B0A");
            string d = Regex.Replace(s, @"((?<=-|^)[^1-9]*)|((?'z'0)[0A-E]*((?=[1-9])|(?'-z'(?=[F-L\.]|$))))|((?'b'[F-L])(?'z'0)[0A-L]*((?=[1-9])|(?'-z'(?=[\.]|$))))", "${b}${z}");
            string rs = Regex.Replace(d, ".", m => "负元空零壹贰叁肆伍陆柒捌玖空空空空空空空分角拾佰仟萬億兆京垓秭穰"[m.Value[0] - '-'].ToString());
            return rs.Replace("元", "");
        }
    }  
} 

