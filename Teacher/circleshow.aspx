<%@ Page Language="C#" AutoEventWireup="true" StylesheetTheme="Teacher" CodeFile="circleshow.aspx.cs" Inherits="Teacher_circleshow" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>学生文档作品自动展示</title>
    <script src="../Js/jquery-1.8.2.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div  style="top: 2px">
    <center>
    <div style="font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 9pt">
    <asp:Label  ID="LabeMtitle" runat="server" Font-Bold="True"></asp:Label>&nbsp;
        <asp:Button ID="Btnflash" runat="server" Text="刷新" onclick="Btnflash_Click" 
            SkinID="BtnSmall" Width="40px" />
        &nbsp;
        <asp:Button ID="Btnrestart" runat="server" Text="重新" onclick="Btnrestart_Click" 
            SkinID="BtnSmall" Width="40px" />
        &nbsp;
        <asp:Button ID="Btnstop" runat="server" Text="继续" onclick="Btnstop_Click" 
            SkinID="BtnSmall" Width="40px" />
        &nbsp;<asp:ImageButton ID="ImgBtnLeft" runat="server" ImageUrl="~/Images/left.png" 
            onclick="ImgBtnLeft_Click" Width="16px" />
    <asp:DropDownList ID="DDLstore" runat="server" 
            Font-Bold="True" Width="100px" AutoPostBack="True" Font-Size="12pt" 
            onselectedindexchanged="DDLstore_SelectedIndexChanged">
        <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <asp:ImageButton ID="ImgBtnright" runat="server" 
            ImageUrl="~/Images/right.png" onclick="ImgBtnright_Click" />
            <asp:Label ID="Labelnum" runat="server" Font-Names="Arial" Font-Size="9pt"></asp:Label>
         <br />
         <asp:Label ID="lbcurindex" runat="server" Text="0" Visible="False"></asp:Label>
         <br />
         <div style="width: 920px; ">
         <div >        
             <asp:ImageButton ID="ImgBtnTextbox" runat="server" CommandName="v" 
                 ImageUrl="~/Images/peer_review.png" onclick="ImgBtnTextbox_Click" />
             教师评语：&nbsp;&nbsp; <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/token.png" />
             加分：<asp:TextBox ID="TextBoxWdsocre" runat="server" MaxLength="2" Width="40px" 
                 BackColor="#FDF5E3" SkinID="TextBoxNum">0</asp:TextBox>
             &nbsp;<asp:RadioButtonList 
                 ID="RBLselect" runat="server"   RepeatDirection="Horizontal" Visible="True" 
            Font-Size="16pt" AutoPostBack="True" 
                 onselectedindexchanged="RBLselect_SelectedIndexChanged" RepeatLayout="Flow" 
              CellPadding="0" CellSpacing="18" Width="360px" >
                                    <Items>
                                    <asp:ListItem>G</asp:ListItem>
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                    <asp:ListItem>E</asp:ListItem>
                                    <asp:ListItem>O</asp:ListItem>
                                    </Items>
                                </asp:RadioButtonList>
             <asp:CheckBox ID="CkselectG" runat="server" Text="筛选Ｇ" 
                 ToolTip="推荐作品筛选" AutoPostBack="True" 
                 oncheckedchanged="CkselectG_CheckedChanged" />
            <asp:CheckBox ID="CheckselectA" runat="server" Text="筛选A" 
                 ToolTip="优秀作品筛选" AutoPostBack="True" 
                 oncheckedchanged="CheckselectA_CheckedChanged"  />          　　
             &nbsp;
             &nbsp;
             <asp:ImageButton ID="ImageBtnDel" runat="server" ImageUrl="~/Images/delete.gif" 
                 onclick="ImageBtnDel_Click" ToolTip="删除作品" />
&nbsp;<div style="text-align: left">
             <asp:TextBox ID="TextBoxWself" 
                 runat="server" Width="100%" 
                BorderColor="Silver" BorderStyle="Dashed" BorderWidth="1px" 
                 BackColor="#FDF5E3" Height="60px" MaxLength="180" TextMode="MultiLine"></asp:TextBox> 
             </div>
             </div>
         </div> 
         &nbsp;
         <br />
        </div>        
        <div style=" font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 9pt; margin: 2px; " >
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </div>
        <asp:HyperLink ID="Hlcode" runat="server" Font-Size="9pt" Target="_blank" 
            Visible="False">查看脚本</asp:HyperLink>            
         &nbsp;&nbsp;
        <asp:HyperLink ID="Hlshare" runat="server" Font-Size="9pt" Target="_blank" 
            Visible="False">一键分享</asp:HyperLink>
        <asp:Panel ID="PanelPython" runat="server"  Width="800px" HorizontalAlign="Right">
        <img id="Pyrun" src="../Images/run.gif" alt="Run" style="cursor: hand" />
        <div id="Result" style=" background-color:#333; color:#fff; padding:10px; min-height:120px; text-align:left;"></div>
        </asp:Panel>
        <br />
        <asp:ImageButton ID="ImgBtn" runat="server" ImageUrl="~/Images/refresh.gif" 
            onclick="ImgBtn_Click" ToolTip="循环展播专用刷新" />
        </center>
        <script type ="text/javascript" >
            function myrefresh() {
                var stxt = document.getElementById("<%= Btnstop.ClientID %>").value;
                if (stxt == "暂停") {
                    document.getElementById("<%= ImgBtn.ClientID %>").click();
                }
            }
            setTimeout("myrefresh()", 8000); //指定8秒刷新一次作品

            $('#Pyrun').click(function () {
                var docurl = document.URL;
                var ipurl = docurl.substring(0, docurl.lastIndexOf("/"));
                var geturl = ipurl + "/Runpy.ashx?file=<%= url %>";
                $.ajax({
                    type: "Get",
                    url: geturl,
                    dataType: "html",
                    success: function (data) {
                        if (data != "") {
                            var msg = data.toString();
                            $('#Result').html(msg);
                        }
                    }
                })
            });
        </script>

    </div>
    </form>
</body>
</html>
