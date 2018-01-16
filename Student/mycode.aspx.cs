using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_mycode : System.Web.UI.Page
{
    protected int sbcount = 0;
    protected int cid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //GetCid();//获取当前上课的ID，编程乐园排除本课的作品显示，防止作弊
            showCount();
            showProject();
        }
    }
    protected string FixUrl(string imgurl)
    {
        return  imgurl.Replace("~", "..");
    }

    private int GetCid()
    {
        if (Request.Cookies[LearnSite.Common.CookieHelp.stuCookieNname] != null)
        {
            LearnSite.Model.Cook cook = new LearnSite.Model.Cook();

            LearnSite.BLL.Room rbll = new LearnSite.BLL.Room();
            string result = rbll.GetRcid(cook.Sgrade, cook.Sclass);
            if (!string.IsNullOrEmpty(result))
                cid = Int32.Parse(result);
        }
        return cid;
    }

    protected void showCount()
    {
        LearnSite.BLL.Works bll = new LearnSite.BLL.Works();
        sbcount = bll.GetSbCount(cid);
        AspNetPagerPic.RecordCount = sbcount;
    }
    protected void showProject()
    {
        LearnSite.BLL.Works bll = new LearnSite.BLL.Works();
        Repeater1.DataSource = bll.GetSbPage(AspNetPagerPic.StartRecordIndex, AspNetPagerPic.EndRecordIndex,cid);
        Repeater1.DataBind();
    }

    protected void AspNetPagerPic_PageChanged(object sender, EventArgs e)
    {
        showProject();
    }
}