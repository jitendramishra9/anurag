<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.Master" AutoEventWireup="true" CodeFile="AllEmployeeList.aspx.cs" Inherits="DistrictAdminPortal_AllEmployeeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" runat="Server">
    <script type="text/javascript">
        function EditEmployee(e) {
            var currentId = GetPrimaryKeyID(e);
            if (ValidateId(currentId)) {
                document.getElementById('<%=txtSelectedRecordId.ClientID%>').value = currentId;
                document.getElementById('<%=txtMode.ClientID%>').value = 'EDIT';
                __doPostBack('<%=upnlEmployee.ClientID %>', '');
            }
        }
        function DeleteEmployee(e) {
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
            <%--__doPostBack('<%=upnlEmployee.ClientID %>', '');--%>
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
            <h3 class="page-header">All Employee List</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">All Employee List <span aria-hidden="true" class="glyphicon glyphicon-user"></span>
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <asp:UpdatePanel ID="upnlEmployee" runat="server" OnLoad="upnlEmployee_Load" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="gvEmployee" runat="server" SkinID="gvGreen10" Width="100%"
                                OnPageIndexChanging="gvEmployee_PageIndexChanging"
                                OnRowCreated="gvEmployee_RowCreated">
                                <Columns>
                                    <asp:BoundField HeaderText="Id" DataField="EmployeeId" />
                                    <asp:TemplateField HeaderText="Sl No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Name" DataField="Name" />
                                    <asp:BoundField HeaderText="FatherName" DataField="FatherName" />
                                    <asp:BoundField HeaderText="MotherName" DataField="MotherName" />
                                    <asp:BoundField HeaderText="Designation" DataField="DesignationName" />
                                    <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />
                                    <asp:TemplateField HeaderText="Photo">
                                        <ItemTemplate>
                                            <asp:Image ID="imgPerson" runat="server" ImageUrl='<%# "../WebHandler/EmployeePic.ashx?EmployeeId="+ Eval("EmployeeId") %>'
                                                Width="75" Height="75" class="img-circle" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <span class="glyphicon glyphicon-edit" data-toggle="tooltip" title="Edit This Record"
                                                style="cursor: pointer;" onclick="EditEmployee(event);"></span>&nbsp; <span class="glyphicon glyphicon-remove"
                                                    data-toggle="tooltip" title="Delete This Record" style="cursor: pointer;" onclick="DeleteEmployee(event);"></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-xs-12">
                        <asp:LinkButton ID="btnRandom" runat="server" CssClass="btn btn-outline btn-primary btn-sm pull-right" data-toggle="tooltip"
                            title="Add Employee" OnClick="btnAdd_Click">
                            <span aria-hidden="true" class="glyphicon glyphicon-plus"></span> Add Employee
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:TextBox ID="txtSelectedRecordId" runat="server" CssClass="hidden"></asp:TextBox>
    <asp:TextBox ID="txtMode" runat="server" CssClass="hidden"></asp:TextBox>

</asp:Content>
