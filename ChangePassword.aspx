<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.master"
    AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="DistrictAdminPortal_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" runat="Server">
    <script type="text/javascript" src="../Scripts/SHA256.js"></script>
    <script type="text/javascript">
        function CancelChangePassword() {
            var currentPage = window.location.href;

            if (currentPage.indexOf("ChangePassword") >= 0) {
                <%--document.getElementById('<%=ddlSecurityQuestion.ClientID %>').value = '0';
                document.getElementById('<%=txtSecurityAnswer.ClientID %>').value = '';--%>
                document.getElementById('<%=txtOldPassword.ClientID %>').value = '';
                document.getElementById('<%=txtNewPassword.ClientID %>').value = '';
                document.getElementById('<%=txtConfirmNewPassword.ClientID %>').value = '';
                //window.location.href = 'Home.aspx';
            }
        }
    </script>

    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Change Password</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">Change Password
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-6">
                    <div class="row" style="height:50px;">
                        <div class="col-lg-6">
                            <label>Old Password</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtOldPassword" TextMode="Password" runat="server" class="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row" style="height:50px;">
                        <div class="col-lg-6">
                            <label>New Password</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" class="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row" style="height:50px;">
                        <div class="col-lg-6">
                            <label>Confirm New Password</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtConfirmNewPassword" runat="server" TextMode="Password" class="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <ul class="list-group">
                        <li class="list-group-item">Password length must be minimum <strong>Eight</strong> characters long.</li>
                        <li class="list-group-item">Password length must be maximum <strong>Fifteen</strong> characters long.</li>
                        <li class="list-group-item">Password must contain at least one upper case letter i.e. (A – Z).</li>
                        <li class="list-group-item">Password must contain at least one lower case letter i.e. (a - z).</li>
                        <li class="list-group-item">Password must contain at least one number i.e. (0 - 9).</li>
                        <li class="list-group-item">Password must contain at least one Special Characters i.e. ( @ ! # $ % - + & *.)</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <div class="row">
                <div class="col-lg-6">
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger btn-block" data-toggle="tooltip"
                        title="Cancel" OnClientClick="CancelChangePassword();" PostBackUrl="~/DistrictAdminPortal/Home.aspx">
                                            <span aria-hidden="true" class="glyphicon glyphicon-remove"></span> Cancel
                    </asp:LinkButton>
                </div>
                <div class="col-lg-6">
                    <asp:LinkButton ID="btnSubmit" runat="server" CssClass="btn btn-success btn-block" data-toggle="tooltip"
                        title="Submit" OnClientClick="return ValidateChangePasswordAdmin();" OnClick="btnSubmit_Click">
                                            <span aria-hidden="true" class="glyphicon glyphicon-ok"></span> Submit
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- This Button is created to prevent Form Submission on Enter Key Press -->
    <asp:Button ID="btnDefaultEnter" runat="server" Text="" OnClientClick="return false;" CssClass="off" />
</asp:Content>
