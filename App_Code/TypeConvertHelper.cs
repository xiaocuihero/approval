using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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

        public static Single C_Single(this object ob)
        {
            Single rs = 0;
            if (ob == DBNull.Value || ob == null || !Single.TryParse(ob.ToString(), out rs))
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

        public static Single C_SingleByPercent(this object ob)
        {
            Single rs = 0;
            string strNoP = ob.ToString().Replace("%", "");
            if (strNoP == "" || ob == null || !Single.TryParse(strNoP, out rs))
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
    }  
} 

