using System;
using System.Data;
using System.Web.UI.WebControls;
using Police.Objects;
using System.Collections.Generic;
using Microsoft.Security.Application;
using System.Web.UI;

public partial class DistrictAdminPortal_AllLeaveList : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateCSRFToken();
        }
    }

    protected void upnlLeave_Load(object sender, EventArgs e)
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
                    Response.Redirect("AddLeave.aspx?Id=" + Encoder.UrlEncode(Id), false);
                }
                else if (txtMode.Text == "DELETE")
                {
                    int documentTypId = Convert.ToInt32(txtSelectedRecordId.Text);
                    string result = Leave.DeleteLeave(documentTypId);
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

    protected void gvLeave_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Style.Add("display", "none");
        }
    }

    protected void gvLeave_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLeave.PageIndex = e.NewPageIndex;
        BindGrid();
    }


    private void BindGrid()
    {
        try
        {
            DataSet dsLeave = Leave.GetAllLeave("PENDING");
            gvLeave.DataSource = dsLeave;
            gvLeave.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("../Error.htm", false);
        }
    }
}