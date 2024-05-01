using System;
using System.Data;

namespace WebApplication1.DistrictAdminPortal
{
    public partial class Home : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(SessionManager.LoginSalt))
            {
                Session.Remove("LOGIN_SALT");
                //int userId = Convert.ToInt32(((FormsIdentity)HttpContext.Current.User.Identity).Ticket.Name);
                //BaseEntity.MaintainHistory("Login", "Success");
            }
            //int currentLawyerId = 0; // 0 because admin will get data of all lawyer
            //DataSet ds = RequestForm.GetRequestCount(currentLawyerId);
            //divOpenRequest.InnerHtml = Convert.ToString(ds.Tables[0].Rows[0]["OpenRequest"]);
            //divDisposedRequest.InnerHtml = Convert.ToString(ds.Tables[1].Rows[0]["DisposedRequest"]);
            //divDefaulterRequest.InnerHtml = Convert.ToString(ds.Tables[2].Rows[0]["DefaultRequest"]);
        }
    }
}