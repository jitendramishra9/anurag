<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.Master" AutoEventWireup="true" CodeFile="AllLeaveList.aspx.cs" Inherits="DistrictAdminPortal_AllLeaveList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" Runat="Server">
    <script type="text/javascript">
        function EditLeave(e) {
            var currentId = GetPrimaryKeyID(e);
            if (ValidateId(currentId)) {
                document.getElementById('<%=txtSelectedRecordId.ClientID%>').value = currentId;
                document.getElementById('<%=txtMode.ClientID%>').value = 'EDIT';
                __doPostBack('<%=upnlLeave.ClientID %>', '');
            }
        }
        function DeleteLeave(e) {
            var currentRecordId = GetPrimaryKeyID(e);
            document.getElementById('<%=txtSelectedRecordId.ClientID %>').value = currentRecordId;
            document.getElementById('<%=txtMode.ClientID%>').value = 'DELETE';
            $('#confirmModal').modal('show');
        }
        // This function name should not be changed in any case.
        function CancelDelete() {
            document.getElementById('<%=txtSelectedRecordId.ClientID %>').value = "";
            document.getElementById('<%=txtMode.ClientID%>').value = "";
        }
        function ConfirmDelete() {
            $('#confirmModal').modal('hide');
            <%--__doPostBack('<%=upnlLeave.ClientID %>', '');--%>
            __doPostBack('', '');
        }
        function ShowDeleteResult(title, msg) {
            document.getElementById('<%=txtSelectedRecordId.ClientID %>').value = '';
            document.getElementById('<%=txtMode.ClientID%>').value = '';
            $('#confirmModal').modal('hide');
            document.getElementById("title").innerHTML = title;
            document.getElementById("message").innerHTML = msg;
            $('#messageModal').modal('show');
        }
    </script>
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">All Leave List</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">All Leave List <span aria-hidden="true" class="glyphicon glyphicon-user"></span>
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <asp:UpdatePanel ID="upnlLeave" runat="server" OnLoad="upnlLeave_Load" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvLeave" runat="server" SkinID="gvGreen10" Width="100%"
                                OnPageIndexChanging="gvLeave_PageIndexChanging"
                                OnRowCreated="gvLeave_RowCreated">
                                <Columns>
                                    <asp:BoundField HeaderText="Id" DataField="LeaveId" />
                                    <asp:TemplateField HeaderText="Sl No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Name" DataField="Name" />
                                    <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />
                                    <asp:BoundField HeaderText="Designation" DataField="DesignationName" />
                                    <asp:BoundField HeaderText="Posting Thana" DataField="ThanaName" />
                                    <asp:BoundField HeaderText="Posting Address" DataField="PostingAddress" />
                                    <asp:BoundField HeaderText="Leave Type" DataField="LeaveTypeName" />
                                    <asp:BoundField HeaderText="Station Leave" DataField="StationLeave" />
                                    <asp:BoundField HeaderText="Address During Leave" DataField="AddressDuringLeave" />
                                    
                                    <asp:BoundField HeaderText="From Date" DataField="FromDate"  DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField HeaderText="To Date" DataField="ToDate"  DataFormatString="{0:dd/MM/yyyy}"/>
                                    <asp:BoundField HeaderText="Leave Status" DataField="LeaveStatus" />


                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <span class="glyphicon glyphicon-edit" data-toggle="tooltip" title="Edit This Record"
                                                style="cursor: pointer;" onclick="EditLeave(event);"></span>&nbsp; <span class="glyphicon glyphicon-remove"
                                                    data-toggle="tooltip" title="Delete This Record" style="cursor: pointer;" onclick="DeleteLeave(event);"></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <asp:TextBox ID="txtSelectedRecordId" runat="server" CssClass="hidden"></asp:TextBox>
    <asp:TextBox ID="txtMode" runat="server" CssClass="hidden"></asp:TextBox>

</asp:Content>

