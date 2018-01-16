<%@ Page Title="" Language="C#" MasterPageFile="~/Student/Stud.master" AutoEventWireup="true" CodeFile="mycode.aspx.cs" Inherits="Student_mycode" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Cphs" Runat="Server">
    <div class="divindex">
    <asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
  <div class="thumbbox">    
   <a href="codeproject.aspx?id=<%#Eval("Wid")%>"  target="_blank">
      <img class="timg"  src="<%#FixUrl(Eval("Wthumbnail").ToString())%>"   alt="..." />
    </a>
      <div class="text-center">
      <p><%#Eval("Wyear")%>级<%#Eval("Wgrade")%>(<%#Eval("Wclass")%>)班
		<%#Eval("Wname")%>	  
        <i class="fa fa-eye"></i><%#Eval("Whit")%>	  
        <i class="fa fa-btc"></i><%#Eval("Wscore")%>
      </p>
      </div>
  </div>

    </ItemTemplate>
    </asp:Repeater>    
</div>
<div class="divindex">
    <webdiyer:aspnetpager id="AspNetPagerPic" runat="server" CurrentPageButtonPosition="Center"
    Width="100%" HorizontalAlign="center" AlwaysShowFirstLastPageNumber="true" 
        PagingButtonSpacing="10" FirstPageText="首页" 
        LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" 
        onpagechanged="AspNetPagerPic_PageChanged"  
        PageSize="8" SubmitButtonText="跳转"></webdiyer:aspnetpager>
</div>
</asp:Content>

