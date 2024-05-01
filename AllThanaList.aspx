<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.Master" AutoEventWireup="true" CodeFile="AllThanaList.aspx.cs" Inherits="DistrictAdminPortal_AllThana" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">All Thana List</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">All Thana List <span aria-hidden="true" class="glyphicon glyphicon-user"></span>
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <asp:UpdatePanel ID="upnlAllThana" runat="server" OnLoad="upnlAllThana_Load" UpdateMode="Conditional" 
                        class="table-responsive table-bordered table-hover">
                        <ContentTemplate>
                            <asp:GridView ID="gvAllThana" runat="server" SkinID="gvGreen10" Width="100%" OnPageIndexChanging="gvAllThana_PageIndexChanging"
                                OnRowCreated="gvAllThana_RowCreated">
                                <Columns>
                                    <asp:BoundField HeaderText="ThanaId" DataField="ThanaId" />
                                    <asp:TemplateField HeaderText="Sl No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="ThanaName" DataField="ThanaName" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
   
    <%-- <asp:TextBox ID="txtSelectedRecordId" runat="server" CssClass="hidden"></asp:TextBox>
    <asp:TextBox ID="txtMode" runat="server" CssClass="hidden"></asp:TextBox>--%>

</asp:Content>

