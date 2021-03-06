﻿<%@ Page Language="C#" MasterPageFile="~/Student/Scm.master" AutoEventWireup="true" CodeFile="showactive.aspx.cs"  StylesheetTheme="Student"  Inherits="Student_showactive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Cpcm" Runat="Server">
    <div  id="showcontent">
<div class="left" style="width: 800px">
<br />
    <div   class="missiontitle">
    <asp:Label ID="LabelMtitle"  runat="server" ></asp:Label><br />
   </div>
   <div class="courseother">
    <asp:Label ID="LabelSnum"  runat="server" Visible="False"></asp:Label>
			<asp:CheckBox ID="CkMupload" runat="server" Enabled="false" Visible="False" />
            <asp:CheckBox ID="CkMgroup" runat="server" Enabled="false"  Visible="False" />
            <asp:Label ID="LabelMid" runat="server" Visible="False"></asp:Label>            
            <asp:Label ID="LabelUploadType" runat="server" Visible="False"></asp:Label>
			<asp:Label ID="LabelMcid" runat="server" Visible="False"></asp:Label>
       <asp:Label ID="LabelMsort"  runat="server" Visible="False" ></asp:Label>
       <asp:Label ID="Labelinfo"  runat="server" Visible="False" ></asp:Label>
   </div>   
    <link href="../kindeditor/plugins/syntaxhighlighter/styles/shCore.css" rel="stylesheet" type="text/css" />
    <link href="../kindeditor/plugins/syntaxhighlighter/styles/shThemeRDark.css" rel="stylesheet"   type="text/css" />
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shCore.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushCss.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushJScript.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushVb.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushCSharp.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushCpp.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushPython.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushPhp.js" type="text/javascript"></script>
    <script src="../kindeditor/plugins/syntaxhighlighter/scripts/shBrushXml.js" type="text/javascript"></script>
    <script  type="text/javascript">        SyntaxHighlighter.all();  </script>
<div   id="Mcontent"  class="coursecontent" runat="server">	
		</div>
		<br />
		<br />
</div>
<div class="right"><br />
<center>
        <script src="../Swfupload/swfupload.js" type="text/javascript"></script>
        <script src="../Swfupload/swfuploaduser.js" type="text/javascript"></script>
        <script type="text/javascript">
            window.onload = function () {
                var ftype = "<%=LabelUploadType.Text %>";
                var fpamm = "mid=<%=LabelMid.Text%>&num=<%=LabelSnum.Text%>&info=<%=Labelinfo.Text %>";
                var furl = "uploadwork.aspx?" + fpamm;
                var gurl = "uploadgroup.aspx?" + fpamm;
                uploadfun(furl, ftype, gurl);
            }
		</script>
       <div ><br /><br /></div><br />
        <input type="button" class="sharedisk" id="share" value="我的网盘" onclick="showShare()" />
        <br />
        <br />
            <asp:HyperLink  ID ="VoteLink" runat="server" Target="_blank" 
                CssClass="txtszcenter" SkinID="HyperLinkPink" BackColor="#66A7FF" BorderStyle="None" 
                ToolTip="可以查看别人的作品!">作品互评</asp:HyperLink>        
        <br />
     <asp:Panel ID="Panelworks" runat="server" >
        <div>
        <br />
            <asp:Image runat="server" ID="upFileType" Visible="False" />
            <asp:HyperLink ID="upFileUrl" runat="server" Height="16px" Visible="False" 
                Target="_blank">[upFileUrl]</asp:HyperLink>
        <br /> 
        <br />                
               <br />
            <asp:Panel ID="Panelswfupload" runat="server">
            
            <div id="swfu_container" style="margin: 0px 10px;">
		    <div style="text-align: center; margin: auto">
				<span id="spanButtonPlaceholder"></span>
		    </div>
		    <div id="divFileProgressContainer" ></div>
		    <div id="divSingleFileProgress"></div>
	    </div>
            </asp:Panel>
            <br />
            <asp:Image ID="ImageType" runat="server" />
            <asp:Label ID="LabelMfiletype" runat="server"></asp:Label>
            格式<br />
    <asp:Label ID="Labelmsg" runat="server"  SkinID="LabelMsgRed"></asp:Label>
            <br />
    <br />
    </div>       
    </asp:Panel>
    <br />
    <br />
    <asp:Panel ID="Panelgroup" runat="server">
        <br />         
        <br />
        <asp:GridView ID="GVgwork" runat="server" 
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="Wid" 
            EnableModelValidation="True" 
            OnRowCommand="GVgwork_RowCommand" 
            onrowdatabound="GVgwork_RowDataBound" PageSize="15" SkinID="GridViewInfo" 
            Width="98%" Caption="小组合作面板">
            <Columns>
                <asp:TemplateField HeaderText="作品">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLinkWurl" runat="server" Target="_blank" Text='<%# Eval("Sname") %>' 
                            ToolTip='<%# Eval("Wurl") %>'></asp:HyperLink>
                    </ItemTemplate>
                    <ControlStyle Width="50px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Wlscore") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField ShowHeader="False">
                    <ControlStyle Width="16px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonA" runat="server" CausesValidation="false" 
                            CommandArgument='<%# Bind("Wid") %>' CommandName="A" Text="A"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField  HeaderText="评价" ShowHeader="False">
                    <ControlStyle Width="16px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonP" runat="server" CausesValidation="false" 
                            CommandArgument='<%# Bind("Wid") %>' CommandName="P" Text="P"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ControlStyle Width="16px" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonE" runat="server" CausesValidation="false" 
                            CommandArgument='<%# Bind("Wid") %>' CommandName="E" Text="E"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                
            </Columns>
            
        </asp:GridView>
        <br />
        <asp:Image ID="upFileTypeGroup" runat="server" Visible="False" />
        <asp:HyperLink ID="upFileUrlGroup" runat="server" Height="16px" Target="_blank" 
            Visible="False">[upFileUrlGroup]</asp:HyperLink>
        <br /><br />
         <asp:Panel ID="PanelGroupUp" runat="server">
        <div id="swfu_containerTwo" style="margin: 0px 10px;">
		    <div style="text-align: center; margin: auto">
				<span id="spanButtonPlaceholderTwo"></span>
		    </div>
		    <div id="divFileProgressContainerTwo" ></div>
		    <div id="divSingleFileProgressTwo"></div>
	    </div>
        </asp:Panel>
        <br />
       <asp:Label ID="Labelgroupmsg" runat="server"  SkinID="LabelMsgRed"></asp:Label>
    <br /> 
    </asp:Panel>
    <br />
    <br />  
    </center>
</div>   
    <br />
        <link href="../Js/tinybox.css" rel="stylesheet" type="text/css" />
        <script src="../Js/tinybox.js" type="text/javascript"></script>
    <script type="text/javascript">
        function jsCopy(contentid) {
            var e = document.getElementById(contentid); //对象是content 
            e.select(); //选择对象 
            document.execCommand("Copy"); //执行浏览器复制命令 
        }
        function showShare() {
            var urlat = "../Student/groupshare.aspx";
            TINY.box.show({ iframe: urlat, boxid: 'frameless', width: 600, height: 400, fixed: false, maskopacity: 60, close:true })
        }   
    </script>    
</div>
</asp:Content>