using System;
using System.Data;
using System.Web.UI.WebControls;
using Police.Objects;


public partial class DistrictAdminPortal_AllThana : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //GenerateCSRFToken();
        }
    }

    protected void upnlAllThana_Load(object sender, EventArgs e)
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

    protected void gvAllThana_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Style.Add("display", "none");
        }
    }

    protected void gvAllThana_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllThana.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    
    private void BindGrid()
    {
        try
        {
            DataSet dsThana = Thana.GetAllThana();
            gvAllThana.DataSource = dsThana;
            gvAllThana.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("../Error.htm", false);
        }
    }
}

