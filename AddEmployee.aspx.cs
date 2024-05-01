using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Police.Objects;
using DatabaseHelper;
using System.Data;

public partial class DistrictAdminPortal_AddEmployee : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateCSRFToken();
            if (string.IsNullOrEmpty(Request.QueryString["Id"]) == false)
            {
                try
                {
                    BindCoontrols();
                    string mode = EncryptionHelper.DecryptQueryString(Request.QueryString["Id"]);
                    if (mode == "AddEmployee")
                    {
                        // do-nothing. Just open Page to Add New Image in any Result
                        // lblPageTitle.Text = "Add Employee";
                        ViewState["Mode"] = "ADD";
                    }
                    else if (UtilityHelper.ValidateTableId(mode))
                    {

                        // lblPageTitle.Text = "Edit Eployee";

                        ViewState["Mode"] = "UPDATE";
                        ViewState["Id"] = mode;
                        int Id = Convert.ToInt32(mode);

                        PopulateResultDetail(Id);
                    }
                    else
                    {
                        string script = "ShowMessageFromServerSide('Warning' , 'URL has been modified. Please open this page again.' , 'AllEmployeeList.aspx');";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "Warning", script, true);
                    }
                }
                catch
                {
                    Response.Redirect("../Error.htm", false);
                }
            }
            else
            {
                string script = "ShowMessageFromServerSide('Warning' , 'URL has been modified. Please open this page again.' , 'AllEmployeeList.aspx');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ValidateCSRFToken() == false)
            {
                Response.Redirect("../Unauthorised.htm", false);
            }
            else if (ValidateInput() == false)
            {
                return;
            }
            else
            {
                string script = string.Empty;
                string result = string.Empty;
                int insertedRecordId = 0;
                Employee oEmployee = new Employee();
                /*--------------------------------------------------------------------------------------*/
                oEmployee.Name = txtName.Text;
                oEmployee.FatherName = txtFatherName.Text;
                oEmployee.MotherName = txtMotherName.Text;
                oEmployee.DOB = UtilityHelper.FormatDate(txtDOB.Text);
                /*--------------------------------------------------------------------------------------*/
                oEmployee.Gender = Convert.ToString(ddlGender.SelectedValue);
                oEmployee.MaritalStatus = Convert.ToString(ddlMaritalStatus.SelectedValue);
                oEmployee.MobileNo = txtMobileNo.Text;
                oEmployee.DesignationId = Convert.ToInt32(ddlDesignation.SelectedValue);
                /*--------------------------------------------------------------------------------------*/
                oEmployee.PermanentThanaId = Convert.ToInt32(ddlPermanentThana.SelectedValue);
                oEmployee.PermanentAddress = txtPermanentAddress.Text;
                /*--------------------------------------------------------------------------------------*/
                oEmployee.PostingThanaId = Convert.ToInt32(ddlCurrentThana.SelectedValue);
                oEmployee.PostingAddress = txtCurrentAddress.Text;
                /*--------------------------------------------------------------------------------------*/
                oEmployee.BatchNo = txtBatchNo.Text;

                int size = uploadEmployeePic.PostedFile.ContentLength;
                byte[] docArr = new byte[size];
                uploadEmployeePic.PostedFile.InputStream.Read(docArr, 0, size);
                oEmployee.Photo = docArr;

                if (ViewState["Mode"] != null)
                {
                    if (Convert.ToString(ViewState["Mode"]) == "ADD")
                    {
                        insertedRecordId = oEmployee.AddEmployee(oEmployee);
                        if (insertedRecordId == 0)
                        {
                            script = "ShowMessageFromServerSide('Warning', 'This Employee already has been registered in the Portal.' ,'Home.aspx');";
                            ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                        }
                        else if (insertedRecordId > 0)
                        {
                            Police.Objects.User oUser = new Police.Objects.User();
                            oUser.UserName = txtBatchNo.Text;
                            oUser.Password = EncryptionHelper.EncryptSHA512("Admin@123");
                            result = oUser.AddUser(oUser);

                            if (result == "SUCCESS")
                            {
                                script = "ShowMessageFromServerSide('Success', 'Employee has been registered successfully. UserName is Batch No and Password is Admin@123.' ,'AllEmployeeList.aspx');";
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                            }
                            else
                            {
                                Employee.DeleteFailedRegistration(insertedRecordId);
                                script = "ShowMessageFromServerSide('Success', 'Your Registration has been Failed. Please contact Site Adim' ,'AllEmployeeList.aspx');";
                                ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                            }
                        }
                    }
                    else if ((Convert.ToString(ViewState["Mode"]) == "UPDATE") && (UtilityHelper.ValidateTableId(Convert.ToString(ViewState["Id"]))))
                    {
                        oEmployee.EmployeeId = Convert.ToInt32(ViewState["Id"]);
                        result = oEmployee.UpdateEmployee(oEmployee);
                        script = "ShowMessageFromServerSide('Success' , '" + result + "' , 'AllEmployeeList.aspx');";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                    }
                    else
                    {
                        script = "ShowMessageFromServerSide('Warning' , 'URLs been modified. Please open this page again.' , 'AllEmployeeList.aspx');";
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                    }
                }
                else
                {
                    script = "ShowMessageFromServerSide('Warning' , 'URL has been modified. Please open this page again.' , 'AllEmployeeList.aspx');";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
                }
            }
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }

    private void BindCoontrols()
    {

        string query = "Select * from t_DesignationM order by DesignationName; Select * from t_DistrictM  order by DistrictId; Select * from t_ThanaM  order by ThanaId;";
        DBHelper dbHelper = new DBHelper();
        DataSet ds = dbHelper.ExecuteDataSet(CommandType.Text, query);

        ViewState["ThanaList"] = ds.Tables[2];

        ddlDesignation.DataSource = ds.Tables[0];
        ddlDesignation.DataValueField = "DesignationId";
        ddlDesignation.DataTextField = "DesignationName";
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, new ListItem("Please Select", "0"));

        ddlPermanentDistrict.DataSource = ds.Tables[1];
        ddlPermanentDistrict.DataValueField = "DistrictId";
        ddlPermanentDistrict.DataTextField = "DistrictName";
        ddlPermanentDistrict.DataBind();
        ddlPermanentDistrict.Items.Insert(0, new ListItem("Please Select", "0"));

        ddlCurrentDistrict.DataSource = ds.Tables[1];
        ddlCurrentDistrict.DataValueField = "DistrictId";
        ddlCurrentDistrict.DataTextField = "DistrictName";
        ddlCurrentDistrict.DataBind();
        ddlCurrentDistrict.Items.Insert(0, new ListItem("Please Select", "0"));



        //ddlCurrentThana.DataSource = ds.Tables[2];
        //ddlCurrentThana.DataValueField = "ThanaId";
        //ddlCurrentThana.DataTextField = "ThanaName";
        //ddlCurrentThana.DataBind();
        //ddlCurrentThana.Items.Insert(0, new ListItem("Please Select", "0"));
    }

    private void PopulateResultDetail(int resultId)
    {
        try
        {
            //ResultStatic objResult = new ResultStatic();
            //objResult.ResultId = resultId;
            //objResult = objResult.GetResultById();

            //if (objResult != null)
            //{
            //    txtDietName.Text = Convert.ToString(objResult.DietName);
            //    txtExamYear.Text = Convert.ToString(objResult.ExamYear);
            //    SetSelectedInList(ddlSemesterNo, objResult.ExamSemesterNo);
            //    SetSelectedInList(ddlResultType, objResult.ResultType);
            //}
            //else
            //{
            //    string script = "ShowMessageFromServerSide('Warning' , '" + "URL has been modified. Please open this page again." + "' , 'Result.aspx');";
            //    ScriptManager.RegisterStartupScript(this, typeof(Page), "Warning", script, true);
            //}
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }

    private bool ValidateInput()
    {
        bool result = true;
        var message = "<h5>Please Provide the Following Information Properly:</h5><ul>";

        //if (UtilityHelper.ValidateDietName(txtDietName.Text) == false)
        //{
        //    message = message + "<li>Please enter valid Diet Name</li>";
        //    result = false;
        //}

        //if (!UtilityHelper.IsValidNumeric(txtExamYear.Text))
        //{
        //    message = message + "<li>Please enter valid Examination Year.</li>";
        //    result = false;
        //}
        //if (ddlSemesterNo.SelectedValue == "0")
        //{
        //    message = message + "<li>Please select Semester No.</li>";
        //    result = false;
        //}
        //if (ddlResultType.SelectedValue == "0")
        //{
        //    message = message + "<li>Please select Result Type.</li>";
        //    result = false;
        //}
        ///****************************************************************************************/
        //if (fileUploadResult.HasFile == false)
        //{
        //    message = message + "<li>Please upload valid PDF Document.</li>";
        //    result = false;
        //}
        //else if (fileUploadResult.HasFile && !UtilityHelper.ValidateFileExtension(Path.GetExtension(fileUploadResult.FileName).ToUpper(), ".pdf"))
        //{
        //    message = message + "<li>Please upload valid PDF Document.</li>";
        //    result = false;
        //}
        //else if ((fileUploadResult.HasFile && fileUploadResult.PostedFile.ContentType != "application/pdf"))
        //{
        //    message = message + "<li>Please upload valid PDF Document.</li>";
        //    result = false;
        //}
        //else if (fileUploadResult.HasFile && UtilityHelper.ValidateNullByte(fileUploadResult) == false)
        //{
        //    message = "<li>Please upload Document in PDF fomat</li>";
        //    result = false;
        //}
        //else if ((fileUploadResult.HasFile == true) && (!UtilityHelper.CheckExtensionPDF(fileUploadResult)))
        //{
        //    message = message + "<li>Please upload valid PDF Document.</li>";
        //    result = false;
        //}
        //if (fileUploadResult.HasFile && fileUploadResult.FileContent.Length > (long)(2 * 1024 * 1024))
        //{
        //    message = message + "<li>Size of uploaded Document should be maximum 2MB.</li>";
        //    result = false;
        //}
        ///****************************************************************************************/

        //if (result == false)
        //{
        //    message = message + "</ul>";
        //    /*  Check Single Quote in this Line */
        //    string script = "ShowMessageFromServerSide('Warning' , '" + message + "' , '');";
        //    ScriptManager.RegisterStartupScript(this, typeof(Page), "Warning", script, true);
        //}
        return result;
    }

    protected void ddlPermanentDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPermanentDistrict.SelectedItem.Text == "ALIGARH" && ddlPermanentDistrict.SelectedItem.Value == "2")
        {
            ddlPermanentThana.DataSource = (DataTable)ViewState["ThanaList"];
            ddlPermanentThana.DataValueField = "ThanaId";
            ddlPermanentThana.DataTextField = "ThanaName";
            ddlPermanentThana.DataBind();
            ddlPermanentThana.Items.Insert(0, new ListItem("Please Select", "0"));
        }
        else
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ThanaId", typeof(int));
            dt.Columns.Add("ThanaName", typeof(string));
            dt.Rows.Add(0, "Please Select");
            dt.Rows.Add(29, "OTHER");

            ddlPermanentThana.DataSource = dt;
            ddlPermanentThana.DataValueField = "ThanaId";
            ddlPermanentThana.DataTextField = "ThanaName";
            ddlPermanentThana.DataBind();
        }
    }

    protected void ddlCurrentDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCurrentDistrict.SelectedItem.Text == "ALIGARH" && ddlCurrentDistrict.SelectedItem.Value == "2")
        {
            ddlCurrentThana.DataSource = (DataTable)ViewState["ThanaList"];
            ddlCurrentThana.DataValueField = "ThanaId";
            ddlCurrentThana.DataTextField = "ThanaName";
            ddlCurrentThana.DataBind();
            ddlCurrentThana.Items.Insert(0, new ListItem("Please Select", "0"));
        }
        else
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ThanaId", typeof(int));
            dt.Columns.Add("ThanaName", typeof(string));
            dt.Rows.Add(0, "Please Select");
            dt.Rows.Add(29, "OTHER");

            ddlCurrentThana.DataSource = dt;
            ddlCurrentThana.DataValueField = "ThanaId";
            ddlCurrentThana.DataTextField = "ThanaName";
            ddlCurrentThana.DataBind();
        }
    }
}
