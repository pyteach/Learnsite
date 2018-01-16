<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/Teach.master" StylesheetTheme="Teacher" Validaterequest="false"  AutoEventWireup="true" CodeFile="courseshow.aspx.cs" Inherits="Teacher_courseshow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">
<div  class="courseshow">
    <br />  	
    <asp:Label ID="LabelCtitle" runat="server"  CssClass="coursetitle"></asp:Label><br /><br />
    <div class="courseother">
                 ���ڣ�[<asp:Label ID="LabelCdate"  runat="server" ></asp:Label>]
			     ���ͣ�[<asp:Label ID="LabelCclass"  runat="server" ></asp:Label>]&nbsp;   
                 �꼶��[<asp:Label ID="LabelCobj"  runat="server" ></asp:Label>]&nbsp;
                 ��[<asp:Label ID="LabelCterm"  runat="server" ></asp:Label>]ѧ��&nbsp;
                 [�νڣ�<asp:Label ID="LabelCks"  runat="server" ></asp:Label>]	&nbsp;	
                 <asp:ImageButton ID="BtnEdit" runat="server" ToolTip="����޸�" 
                     ImageUrl="~/Images/edit.gif" onclick="BtnEdit_Click" />
    </div>    
    <br /> 
<div class="courseother" style="width: 700px">
<div style="margin: auto; width: 700px;">
         <asp:LinkButton ID="LinkBtnAdd" runat="server"  
          OnClick="LinkBtnAdd_Click" CssClass="button24" >��ӻ</asp:LinkButton>
             &nbsp;&nbsp;&nbsp; &nbsp;
         <asp:LinkButton ID="LinkBtnAddTopic" runat="server" 
          OnClick="LinkBtnAddTopic_Click" CssClass="button24" >�������</asp:LinkButton>
             &nbsp;&nbsp; &nbsp;&nbsp;
         <asp:LinkButton ID="LinkBtnAddSurvey" runat="server"  
          OnClick="LinkBtnAddSurvey_Click" CssClass="button24" >��ӵ���</asp:LinkButton>
             &nbsp;
             &nbsp; &nbsp;
         <asp:LinkButton ID="LinkBtnAddTxtForm" runat="server"  
          OnClick="LinkBtnAddTxtForm_Click" CssClass="button24" >��ӱ�</asp:LinkButton>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <asp:LinkButton ID="LinkBtnProgram" runat="server"  
          OnClick="LinkBtnProgram_Click" CssClass="button24" >��ӱ��</asp:LinkButton>
             &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <asp:LinkButton ID="LinkBtnReturn" runat="server" 
             OnClick="LinkBtnReturn_Click" CssClass="button24" >����</asp:LinkButton>
         </div>

             <br />

         <asp:GridView ID="GVlistmenu" runat="server"  Width="660px"  SkinID="GVmission" 
             CellPadding="6" AutoGenerateColumns="False" 
             EnableModelValidation="True" HorizontalAlign="Center" 
        onrowcommand="GVlistmenu_RowCommand" 
        onrowdatabound="GVlistmenu_RowDataBound" >
             <Columns>             
                 <asp:TemplateField Visible="False">
                     <ItemTemplate>
                         <asp:Label ID="LabelLid" runat="server" Text='<%# Bind("Lid") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField Visible="False">
                     <ItemTemplate>
                         <asp:Label ID="LabelLxid" runat="server" Text='<%# Bind("Lxid") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField Visible="False">
                     <ItemTemplate>
                         <asp:Label ID="LabelLtype" runat="server" Text='<%# Bind("Ltype") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="���">
                     <ItemTemplate>
                         <asp:Label ID="LabelLsort" runat="server" Text='<%# Bind("Lsort") %>'></asp:Label>
                     </ItemTemplate>
                     <ItemStyle Width="50px" />
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="����">
                     <ItemTemplate>
                         <asp:Label ID="Label4" runat="server"></asp:Label>
                     </ItemTemplate>
                     <ItemStyle Width="50px" />
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="������Ŀ">
                     <ItemTemplate>
                         <asp:HyperLink ID="HlLtitle" runat="server" NavigateUrl="" 
                             Text='<%# Eval("Ltitle") %>'></asp:HyperLink>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="ImageBtnTop" runat="server" CausesValidation="False" 
                            CommandName="Top"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                            Text="��" ToolTip="������" Font-Underline="False"></asp:LinkButton>
                    </ItemTemplate>
                     <ItemStyle Width="16px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="ImageBtnBottom" runat="server" CausesValidation="False" 
                            CommandName="Bottom"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                            Text="��" ToolTip="������" Font-Underline="False"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Width="16px" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="����" ShowHeader="False">
                     <ItemTemplate>
                         <asp:LinkButton ID="LinkBtnShow" runat="server" CausesValidation="false" 
                             CommandName="P" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                             Text='<%# Eval("lshow") %>' ToolTip="True��ʾ��False����"></asp:LinkButton>
                     </ItemTemplate>
                     <ItemStyle Width="50px" />
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="����" ShowHeader="False">
                     <ItemTemplate>
                         <asp:LinkButton ID="LinkBtnDel" runat="server" CausesValidation="false" 
                             CommandName="D"  CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                             Text="ɾ��"  ToolTip="������ȷ���Ƿ�ɾ�������ɻָ���"></asp:LinkButton>
                     </ItemTemplate>
                     <ItemStyle Width="50px" />
                 </asp:TemplateField>
             </Columns>
             <RowStyle Height="32px" />
         </asp:GridView>
         <div>
            <br />
         </div>       
         </div>
         <div  id="Ccontent" class="coursecontent" runat ="server">   
    </div>
         <br />
    </div>
</asp:Content>

