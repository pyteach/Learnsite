﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_alltyper : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (LearnSite.Common.CookieHelp.IsStudentLogin())
        {
            if (!IsPostBack)
            {
                ShowTyper();
            }
        }
        else
        {
            LearnSite.Common.CookieHelp.JudgeStudentCookies();
        }
    }

    private void ShowTyper()
    {
        LearnSite.Model.Cook cook = new LearnSite.Model.Cook(); 
        
        LearnSite.BLL.Ptyper pr = new LearnSite.BLL.Ptyper();
        string sestr = DDLselect.SelectedValue;
        switch (sestr)
        {
            case "1":
                GVTyper.DataSource = pr.ShowSchoolTypeScore();
                break;
            case "2":
                GVTyper.DataSource = pr.ShowAllTypeScore(cook.Sgrade);
                break;
            case "3":
                GVTyper.DataSource = pr.ShowClassTypeScore(cook.Sgrade, cook.Sclass);
                break;
        }        
        GVTyper.DataBind();
    }

    protected void GVTyper_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView theGrid = sender as GridView;  // refer to the GridView
        int newPageIndex = 0;

        if (-2 == e.NewPageIndex)
        { // when click the "GO" Button
            TextBox txtNewPageIndex = null;

            GridViewRow pagerRow = theGrid.BottomPagerRow;

            if (null != pagerRow)
            {
                txtNewPageIndex = pagerRow.FindControl("txtNewPageIndex") as TextBox;   // refer to the TextBox with the NewPageIndex value
            }

            if (null != txtNewPageIndex)
            {

                newPageIndex = int.Parse(txtNewPageIndex.Text) - 1; // get the NewPageIndex
            }
        }
        else
        {  // when click the first, last, previous and next Button
            newPageIndex = e.NewPageIndex;
        }

        // check to prevent form the NewPageIndex out of the range
        newPageIndex = newPageIndex < 0 ? 0 : newPageIndex;
        newPageIndex = newPageIndex >= theGrid.PageCount ? theGrid.PageCount - 1 : newPageIndex;
        theGrid.PageIndex = newPageIndex;
        ShowTyper();
    }
    protected void GVTyper_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1)
        {
            e.Row.Cells[0].Text = Convert.ToString(GVTyper.PageIndex * GVTyper.PageSize + e.Row.RowIndex + 1);
            string typedate = e.Row.Cells[9].Text;
            if (LearnSite.Common.Computer.IsToday(typedate))
                e.Row.Cells[3].ForeColor = System.Drawing.Color.SeaGreen;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //当鼠标放上去的时候 先保存当前行的背景颜色 并给附一颜色 
            e.Row.Attributes.Add("onmouseover", "currentcolor=this.style.backgroundColor;this.style.backgroundColor='#E1E8E1',this.style.fontWeight='';");
            //当鼠标离开的时候 将背景颜色还原的以前的颜色 
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=currentcolor,this.style.fontWeight='';");
            //单击行改变行背景颜色 
            e.Row.Attributes.Add("onclick", "this.style.backgroundColor='#D8E0D8'; this.style.color='buttontext';this.style.cursor='default';");
        }
    }
    protected void DDLselect_SelectedIndexChanged(object sender, EventArgs e)
    {
        GVTyper.PageIndex = 0;
        ShowTyper();
    }
}
