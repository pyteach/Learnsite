﻿using System;
using System.Web;
namespace LearnSite.Model
{
    /// <summary>
    /// 实体类Courses 
    /// </summary>
    [Serializable]
    /// <summary>
    ///Cook 的摘要说明
    /// </summary>
    public class TeaCook
    {
        public TeaCook()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
            if (HttpContext.Current.Request.Cookies[LearnSite.Common.CookieHelp.teaCookieNname] != null)
            {
                string tcook = HttpContext.Current.Request.Cookies[LearnSite.Common.CookieHelp.teaCookieNname].Value;
                this.ToModel(tcook);
            }
        }

        #region Model
        private int _hid;
        private string _hname;
        private string _hnick;
        private string _hroom;
        private bool _hpermiss;
        private string _ss;//cookies名称
        private string _sessionid;
        /// <summary>
        /// cookie是否存在
        /// </summary>
        /// <returns></returns>
        public bool IsExist()
        {
            if (string.IsNullOrEmpty(_ss))
                return false;
            else
                return true;
        }
        /// <summary>
        ///模型转字符串
        /// </summary>
        /// <returns></returns>
        public string ToStr()
        {
            string value = _hid.ToString() + "|" + _hname 
                + "|" + _hpermiss + "|" + _hnick + "|" + _hroom + "|" + _ss + "|" + _sessionid;

            string result = Common.DesCode.StringEncoder(value);//Base64加密
            return result;
        }
        /// <summary>
        /// 字符串转模型
        /// </summary>
        /// <param name="ciphervalue"></param>
        private void ToModel(string ciphervalue)
        {
            try
            {
                string value = Common.DesCode.StringDecder(ciphervalue);
                string[] result = value.Split('|');
                if (result.Length == 7)
                {
                    _hid = Int32.Parse(result[0]); ;
                    _hname = result[1];
                    _hpermiss = bool.Parse(result[2]);
                    _hnick = result[3];
                    _hroom = result[4];
                    _ss = result[5];
                    _sessionid = result[6];
                }
                else
                    LearnSite.Common.CookieHelp.ClearTeacherCookies();
            }
            catch
            {
                LearnSite.Common.CookieHelp.ClearTeacherCookies();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public int Hid
        {
            set { _hid = value; }
            get { return _hid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Hname
        {
            set { _hname = value; }
            get { return _hname; }
        }

        /// <summary>
        /// 
        /// </summary>
        public bool Hpermiss
        {
            set { _hpermiss = value; }
            get { return _hpermiss; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string Hnick
        {
            set { _hnick = value; }
            get { return _hnick; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Hroom
        {
            set { _hroom = value; }
            get { return _hroom; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Ss
        {
            set { _ss = value; }
            get { return _ss; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string SessionId
        {
            set { _sessionid = value; }
            get { return _sessionid; }
        }
        #endregion Model
    }
}