using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DistrictAdminPortal_ChangePassword302Redirect : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request.QueryString["RandomNo"]) == false || Session["ChangePasswordRandomNo"] == null || Session["ChangePasswordMessage"] == null)
        {
            try
            {
                string randomNoQueryString = Convert.ToString(Request.QueryString["RandomNo"]);
                string randomNoSession = Convert.ToString(Session["ChangePasswordRandomNo"]);
                string message = Convert.ToString(Session["ChangePasswordMessage"]);

                Session.Remove("ChangePasswordRandomNo");
                Session.Remove("ChangePasswordMessage");

                if (randomNoQueryString == randomNoSession)
                {
                    lblMessage.Text = message;
                }
                else
                {
                    ShowErrorMessageAndLogout();
                }
            }
            catch
            {
                ShowErrorMessageAndLogout();
            }
        }
        else
        {
            ShowErrorMessageAndLogout();
        }
    }

    private void ShowErrorMessageAndLogout()
    {
        string csrfToken = Convert.ToString(Guid.NewGuid());
        SessionManager.CsrfToken = csrfToken;
        string url = "../Logout.aspx?CSRFToken=" + csrfToken;
        string script = "ShowMessageFromServerSide('Warning' , 'URL has been modified. Please open this page again.' , '" + url + "');";
        ScriptManager.RegisterStartupScript(this, typeof(Page), "Warning", script, true);
    }
}