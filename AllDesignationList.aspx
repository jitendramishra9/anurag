<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.Master" AutoEventWireup="true" CodeFile="AllDesignationList.aspx.cs" Inherits="DistrictAdminPortal_AllDesignation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">All Designation List</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">All Designation List <span aria-hidden="true" class="glyphicon glyphicon-user"></span>
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <asp:UpdatePanel ID="upnlAllDesignation" runat="server" OnLoad="upnlAllDesignation_Load" UpdateMode="Conditional" 
                        class="table-responsive table-bordered table-hover">
                        <ContentTemplate>
                            <asp:GridView ID="gvAllDesignation" runat="server" SkinID="gvGreen10" Width="100%" OnPageIndexChanging="gvAllDesignation_PageIndexChanging"
                                OnRowCreated="gvAllDesignation_RowCreated">
                                <Columns>
                                    <asp:BoundField HeaderText="DesignationId" DataField="DesignationId" />
                                    <asp:TemplateField HeaderText="Sl No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Designation Name" DataField="DesignationName" />
                                     <asp:BoundField HeaderText="Class" DataField="Class" />
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

