using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_groupshare : System.Web.UI.Page
{
    LearnSite.Model.Cook cook = new LearnSite.Model.Cook();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (LearnSite.Common.CookieHelp.IsStudentLogin())
        {
            if (!IsPostBack)
            {

                ListSelectShare();
            }
        }
        else
        {
            Response.Write("请重新登录……！");
        }
    }  
    protected void Btnupload_Click(object sender, EventArgs e)
    {
        if (Request.Cookies[LearnSite.Common.CookieHelp.stuCookieNname] != null)
        {
            if (isShareEnable(cook.Sgrade, cook.Sclass))
            {
                string Sname = Server.UrlDecode(cook.Sname).Trim();
                int sgroup = GetmySgroup();
                if (Fupload.HasFile)
                {
                    bool isgroup = CkIsGroup.Checked;
                    string msg = LearnSite.Common.ShareDisk.SaveFile(Fupload, cook.Syear.ToString(), cook.Sgrade.ToString(), cook.Sclass.ToString(), Sname, cook.Snum, sgroup.ToString(), isgroup);//保存上传文件到组网盘
                    System.Threading.Thread.Sleep(200);
                    ListSelectShare();

                    LearnSite.Common.WordProcess.Alert(msg, this.Page);
                }
            }
            else
            {
                Labeltitle.Text = "小组网盘未启用……？";
            }
        }
    }
    protected void Dlfilelist_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "D")
        {
            LearnSite.BLL.Students sbll = new LearnSite.BLL.Students();
            string furl = e.CommandArgument.ToString();
            LearnSite.Common.ShareDisk.DelFile(furl);//删除
            LearnSite.BLL.ShareDisk kbll = new LearnSite.BLL.ShareDisk();
            kbll.Deletefile(cook.Snum, furl);//删除数据库记录
            System.Threading.Thread.Sleep(300);
            ListSelectShare();
        }
    }
    protected void Dlfilelist_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string fname = ((HyperLink)e.Item.FindControl("HLfname")).Text;
        string Sname = Server.UrlDecode(cook.Sname);
        ImageButton imgbtn = (ImageButton)e.Item.FindControl("ImgBtnDelete");
        Sname = LearnSite.Common.WordProcess.FilterSpecial(Sname).Trim();
        if (fname.Contains(Sname))
        {
            string strjs = "if(confirm('确定删除" + fname + "文件吗？'))return true;else return false; ";
            imgbtn.OnClientClick = strjs;
        }
        else
        {
            imgbtn.Visible = false;
        }
    }

    protected void BtnStu_Click(object sender, EventArgs e)
    {
        BtnGroup.BackColor = System.Drawing.Color.FromArgb(207, 228, 208);
        BtnStu.BackColor = System.Drawing.Color.FromArgb(230, 240, 231);//自己变背景色
        CkIsGroup.Checked = false;
        ListSelectShare();
    }
    protected void BtnGroup_Click(object sender, EventArgs e)
    {
        BtnGroup.BackColor = System.Drawing.Color.FromArgb(230, 240, 231);//自己变背景色
        BtnStu.BackColor = System.Drawing.Color.FromArgb(207, 228, 208);
        CkIsGroup.Checked = true;
        ListSelectShare();
    }
    private int GetmySgroup()
    {
        LearnSite.BLL.Students sbll = new LearnSite.BLL.Students();
        return sbll.GetSgroup(cook.Sid);//获取自己的组号
    }
    private void ListSelectShare()
    {
        bool isgp = CkIsGroup.Checked;//是否小组或个人
        bool isenable = isShareEnable(cook.Sgrade, cook.Sclass);
        if (isenable)
        {
            if (isgp)
            {
                int Sgroup = GetmySgroup();//获取自己的组号
                if (Sgroup > 0)
                {
                    if (isGroupShareEnable(cook.Sgrade, cook.Sclass))
                    {
                        LearnSite.BLL.Students sbll = new LearnSite.BLL.Students();
                        Labeltitle.Text = "《" + sbll.GetSgtitle(Sgroup) + "》小组网盘";
                        ListShareFiles(cook.Syear.ToString(), cook.Sclass.ToString(), Sgroup.ToString(), isgp);//列出网盘文件
                        Fupload.Visible = true;
                        Btnupload.Visible = true;
                    }
                    else
                    {
                        Labeltitle.Text = "小组网盘未启用……";
                        Dlfilelist.Visible = false;
                        Fupload.Visible = false;
                        Btnupload.Visible = false;
                        Labeldisk.Text = "";
                    }
                }
                else
                {
                    Labeltitle.Text = "您未参加小组……";
                    Dlfilelist.Visible = false;
                    Fupload.Visible = false;
                    Btnupload.Visible = false;
                    Labeldisk.Text = "";
                }
            }
            else
            {
                ListShareFiles(cook.Syear.ToString(), cook.Sclass.ToString(), cook.Snum, isgp);//列出网盘文件
                Labeltitle.Text = Server.UrlDecode(cook.Sname) + "个人网盘";
                Fupload.Visible = true;
                Btnupload.Visible = true;
            }
        }
        else
        {
            Labeltitle.Text = "个人网盘未启用……";
            Dlfilelist.Visible = false;
            Fupload.Visible = false;
            Btnupload.Visible = false;
        }
        showDiskgif(isenable, isgp);
    }
    /// <summary>
    /// 返回网盘是否启用
    /// </summary>
    /// <returns></returns>
    private bool isShareEnable(int Sgrade, int Sclass)
    {
        LearnSite.BLL.Room rbll = new LearnSite.BLL.Room();
        return rbll.IsRshare(Sgrade, Sclass);
    }
    /// <summary>
    /// 返回小组网盘是否启用
    /// </summary>
    /// <returns></returns>
    private bool isGroupShareEnable(int Sgrade, int Sclass)
    {
        LearnSite.BLL.Room rbll = new LearnSite.BLL.Room();
        return rbll.IsRgroupshare(Sgrade, Sclass);
    }
    /// <summary>
    /// 列表网盘文件
    /// </summary>
    /// <param name="Syear">入学年份</param>
    /// <param name="Sclass">班级</param>
    /// <param name="sharedir">学号或组号</param>
    private void ListShareFiles(string Syear, string Sclass, string Dir,bool IsGroup)
    {
        Dlfilelist.Visible = true;
        DateTime dt1 = DateTime.Now;
        LearnSite.Common.ShareDisk.DiskInfo dk = new LearnSite.Common.ShareDisk.DiskInfo(Syear, Sclass, Dir,IsGroup);
        Dlfilelist.DataSource = dk.Dw;
        Dlfilelist.DataBind();
        DateTime dt2 = DateTime.Now;
        string timepass = LearnSite.Common.Computer.DatagoneMilliseconds(dt1, dt2) + "ms";
        string msgtitle = "我的";
        if (IsGroup)
            msgtitle = "小组";
        Labeldisk.Text = msgtitle + "网盘" + dk.Dsize.ToString("F1") + "/" + dk.Dlimit.ToString("0") + "MB  " + dk.Dcount.ToString() + "个文件 " + timepass;
        if (dk.Dupload)
        {
            Fupload.Enabled = true;
            Btnupload.Enabled = true;
        }
        else
        {
            Fupload.Enabled = false;
            Btnupload.Enabled = false;
        }
    }
    private void showDiskgif(bool isEnable,bool isGroup)
    {
        string imgurl = "~/Images/diskclose.gif";
        if (isEnable)
        {
            if (isGroup)
                imgurl = "~/Images/diskblue.gif";
            else
                imgurl = "~/Images/diskgreen.gif";        
        }
        Imagedisk.ImageUrl = imgurl + "?mm=" + DateTime.Now.Millisecond;    
    }

}