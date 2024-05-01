<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictAdminPortal.Master" AutoEventWireup="true" CodeFile="AddEmployee.aspx.cs" Inherits="DistrictAdminPortal_AddEmployee" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphDistrictAdminPortal" runat="Server">
    <script>
        $(document).ready(function () { $("#ctl00_cphDistrictAdminPortal_ddlGender").select2(); });
        $(document).ready(function () { $("#ctl00_cphDistrictAdminPortal_ddlMaritalStatus").select2(); });
    </script>
    <script type="text/javascript">
        $(document).on('click', '.browse', function () {
            var file = $(this).parent().parent().parent().find('.file');
            file.trigger('click');
        });
        $(document).on('change', '.file', function () {
            $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        });
    </script>
    <script type="text/javascript">
        function previewImage(event) {
            var input = event.target;
            var image = document.getElementById('preview');
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    image.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Add Employee Detail</h3>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title tab_heading_in">Add Employee Detail <span aria-hidden="true" class="glyphicon glyphicon-user"></span>
            </h3>
        </div>
        <div class="panel-body">
            <div class="row well well-sm">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtName">Name</label>
                        <asp:TextBox ID="txtName" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtFatherName">Father Name</label>
                        <asp:TextBox ID="txtFatherName" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtMotherName">Mother Name</label>
                        <asp:TextBox ID="txtMotherName" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtDOB">Date Of Birth</label>
                        <asp:TextBox ID="txtDOB" runat="server" class="form-control" onkeypress="return false;" onpaste="return false;"></asp:TextBox>
                    </div>
                </div>

            </div>
            <div class="row well well-sm">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlGender">Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" class="form-control">
                            <asp:ListItem Text="0">Please Select</asp:ListItem>
                            <asp:ListItem Text="M">Male</asp:ListItem>
                            <asp:ListItem Text="F">Female</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlMaritalStatus">Marital Status</label>
                        <asp:DropDownList ID="ddlMaritalStatus" runat="server" class="form-control">
                            <asp:ListItem Text="0">Please Select</asp:ListItem>
                            <asp:ListItem Text="M">Married</asp:ListItem>
                            <asp:ListItem Text="U">Unmarried</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtMobileNo">Mobile No</label>
                        <asp:TextBox ID="txtMobileNo" runat="server" class="form-control" onkeypress ="AllowOnlyNumeric();"></asp:TextBox>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlDesignation">Designation</label>
                        <asp:DropDownList ID="ddlDesignation" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row ">
                <div class="col-lg-12 form-group bg-info">
                    <span class="label label-warning" style="padding: 7px; font-size: 13px; font-family: Verdana">Permanent Address </span>
                </div>
            </div>
            <div class="row well well-sm">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlPermanentDistrict">District</label>
                        <asp:DropDownList ID="ddlPermanentDistrict" runat="server" class="form-control" OnSelectedIndexChanged="ddlPermanentDistrict_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlPermanentThana">Thana</label>
                        <asp:DropDownList ID="ddlPermanentThana" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="form-group">
                        <label for="txtPermanentAddress">Permanent Address</label>
                        <asp:TextBox ID="txtPermanentAddress" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row ">
                <div class="col-lg-12 form-group bg-info">
                    <span class="label label-warning" style="padding: 7px; font-size: 13px; font-family: Verdana">Current Address/Posting Place </span>
                </div>
            </div>
            <div class="row well well-sm">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlCurrentDistrict">District</label>
                        <asp:DropDownList ID="ddlCurrentDistrict" runat="server" class="form-control" OnSelectedIndexChanged="ddlCurrentDistrict_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlCurrentThana">Thana</label>
                        <asp:DropDownList ID="ddlCurrentThana" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="form-group">
                        <label for="txtCurrentAddress">Permanent Address</label>
                        <asp:TextBox ID="txtCurrentAddress" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row well well-sm">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="txtBatchNo">Batch No</label>
                        <asp:TextBox ID="txtBatchNo" runat="server" class="form-control" onkeypress="AllowOnlyNumeric();"></asp:TextBox>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="uploadEmployeePic">Upload Photo</label>
                        <input type="file" accept="image/*" onchange="previewImage(event)" id="uploadEmployeePic" runat="server"/>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="form-group">
                        <label for="preview">Preview Photo</label>
                        <br />
                        <img id="preview" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <div class="row">
                <div class="col-lg-6">
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger btn-sm btn-block" data-toggle="tooltip"
                        title="Cancel" PostBackUrl="~/DistrictAdminPortal/AllEmployeeList.aspx">
                                            <span aria-hidden="true" class="glyphicon glyphicon-remove"></span> Cancel
                    </asp:LinkButton>
                </div>
                <div class="col-lg-6">
                    <asp:LinkButton ID="btnSubmit" runat="server" CssClass="btn btn-success btn-sm btn-block" data-toggle="tooltip"
                        title="Submit" OnClientClick="return ValidateAddEmployee();" OnClick="btnSubmit_Click">
                                            <span aria-hidden="true" class="glyphicon glyphicon-ok"></span> Submit
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        // When the document is ready
        $(document).ready(function () {
            $('#ctl00_cphDistrictAdminPortal_txtDOB').datepicker();
        });
    </script>
</asp:Content>

