using System;
using System.Data;
using System.Web.UI.WebControls;
using Police.Objects;


public partial class DistrictAdminPortal_AllDesignation : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //GenerateCSRFToken();
        }
    }

    protected void upnlAllDesignation_Load(object sender, EventArgs e)
    {
        try
        {
            
            BindGrid();
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }

    protected void gvAllDesignation_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Style.Add("display", "none");
        }
    }

    protected void gvAllDesignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllDesignation.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    
    private void BindGrid()
    {
        try
        {
            DataSet dsDesignation = Designation.GetAllDesignation();
            gvAllDesignation.DataSource = dsDesignation;
            gvAllDesignation.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("../Error.htm", false);
        }
    }
}

