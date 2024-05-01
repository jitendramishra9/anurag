using System;
using System.Data;
using System.Web.UI.WebControls;
using Police.Objects;
using System.Collections.Generic;
using Microsoft.Security.Application;
using System.Web.UI;

public partial class DistrictAdminPortal_AllEmployeeList : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateCSRFToken();
        }
    }

    protected void upnlEmployee_Load(object sender, EventArgs e)
    {
        try
        {
            if (UtilityHelper.ValidateTableId(txtSelectedRecordId.Text))
            {
                if (ValidateCSRFToken() == false)
                {
                    Response.Redirect("../Unauthorised.htm", false);
                }
                else if (txtMode.Text == "EDIT")
                {
                    string Id = EncryptionHelper.EncryptQueryString(txtSelectedRecordId.Text);
                    Response.Redirect("AddEmployee.aspx?Id=" + Encoder.UrlEncode(Id), false);
                }
                else if (txtMode.Text == "DELETE")
                {
                    int documentTypId = Convert.ToInt32(txtSelectedRecordId.Text);
                    string result = Employee.DeleteEmployee(documentTypId);
                    string script = "ShowDeleteResult('Success' , '" + result + "');";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Error", script, true);
                }
            }
            BindGrid();
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }

    protected void gvEmployee_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Style.Add("display", "none");
        }
    }

    protected void gvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEmployee.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string Id = EncryptionHelper.EncryptQueryString("AddEmployee");
        Response.Redirect("AddEmployee.aspx?Id=" + Encoder.UrlEncode(Id), false);
    }

    private void BindGrid()
    {
        try
        {
            List<Employee> EmployeeCollection = Employee.GetAllEmployee();
            gvEmployee.DataSource = EmployeeCollection;
            gvEmployee.DataBind();
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }
}