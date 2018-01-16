using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Stud : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string stuName = "";
            if (Request.Cookies[LearnSite.Common.CookieHelp.stuCookieNname] != null)
            {
                LearnSite.Model.Cook cook = new LearnSite.Model.Cook();

                stuName = cook.Sname;
            }
            this.Page.Title = LearnSite.Common.XmlHelp.SiteTitle() +"—"+ HttpUtility.UrlDecode(stuName);
        }
    }


}
