using System;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Police.Objects;
public partial class DistrictAdminPortal_ChangePassword : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // This Button is created to prevent Form Submission on Enter Key Press.
        this.Form.DefaultButton = this.btnDefaultEnter.UniqueID;

        //txtSecurityAnswer.Attributes.Add("autocomplete", "off");
        txtOldPassword.Attributes.Add("autocomplete", "off");
        txtNewPassword.Attributes.Add("autocomplete", "off");
        txtConfirmNewPassword.Attributes.Add("autocomplete", "off");
        
        if (IsPostBack == false)
        {
            //DataSet ds = Collectorate.Objects.User.GetAllSecurityQuestion();
            //ddlSecurityQuestion.DataSource = ds.Tables[0];
            //ddlSecurityQuestion.DataTextField = "SecurityQuestion";
            //ddlSecurityQuestion.DataValueField = "SecurityQuestionId";
            //ddlSecurityQuestion.DataBind();
            //ddlSecurityQuestion.Items.Insert(0, new ListItem("Please Select", "0"));
            //txtSaltValue.Text = Guid.NewGuid().ToString("N").ToUpper();
            //Session["CHANGE_PASSWORD_SALT"] = txtSaltValue.Text;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ValidateInput() == true)
            {
                Police.Objects.User oUser = new Police.Objects.User();
                FormsIdentity formIdentity = (FormsIdentity)HttpContext.Current.User.Identity;
                oUser.UserId = Convert.ToInt32(formIdentity.Name);
                oUser = oUser.GetUserByUserId();
                string message = "<ul>";
                bool result = true;

                #region Checking Security Question , Security Answer and Old Password Here
                //if (Convert.ToInt32(ddlSecurityQuestion.SelectedValue) != oUser.SecurityQuestionId)
                //{
                //    message = message + "<li>Please select correct Security Question.</li>";
                //    result = false;
                //}
                //if (txtSecurityAnswer.Text.ToUpper() != oUser.SecurityAnswer.ToUpper())
                //{
                //    message = message + "<li>Please enter correct Security Answer.</li>";
                //    result = false;
                //}
                if (txtOldPassword.Text != oUser.Password)
                {
                    message = message + "<li>Please enter correct old password.</li>";
                    result = false;
                }
                if (txtOldPassword.Text == txtNewPassword.Text)
                {
                    message = message + "<li>New Password can not be same as old password.</li>";
                    result = false;
                }
                if (result == false)
                {
                    message = message + "</ul>";
                    ShowMessageInNextPage(message);
                }
                #endregion
                else
                {
                    DataSet ds = oUser.GetLastThreePassword();
                    string encNewPassword = txtNewPassword.Text;
                    bool repeatedPassword = false;
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (encNewPassword == dr["LastPassword"].ToString())
                        {
                            repeatedPassword = true;
                            break;
                        }
                    }
                    if (repeatedPassword == true)
                    {
                        ShowMessageInNextPage("Current Password should not match with last three password");
                    }
                    else
                    {
                        oUser.Password = txtNewPassword.Text;
                        oUser.ChangePassword();
                        oUser.Password = txtOldPassword.Text;
                        oUser.CreatePasswordHistory();
                        ShowMessageInNextPage("Password has been updated successfully");
                    }
                }
            }
            else
            {
                return;
            }
        }
        catch
        {
            Response.Redirect("../Error.htm", false);
        }
    }

    private bool ValidateInput()
    {
        bool result = true;
        string message = "<ul>";
        //if (ddlSecurityQuestion.SelectedValue == "0")
        //{
        //    message = message + "<li>Please Select Your Security Question.</li>";
        //    result = false;
        //}
        //if (!UtilityHelper.ValidateSecurityAnswer(txtSecurityAnswer.Text))
        //{
        //    message = message + "<li>Security Answer can be alpha-numeric, dot(.) and underscore only.</li>";
        //    result = false;
        //}
        if (txtOldPassword.Text == txtNewPassword.Text)
        {
            message = message + "<li>Old Password and new Password must not be same.</li>";
            result = false;
        }
        if (!UtilityHelper.ValidateEncryptedLoginPassword(txtNewPassword.Text))
        {
            message = message + "<li>Password must contain at least one upper case letter(A-Z).</li>";
            message = message + "<li>Password must contain at least one lower case letter(a-z).</li>";
            message = message + "<li>Password must contain at least one digit(0-9).</li>" ;
            message = message + "<li>Password must contain at least one  special character out of @!#$%-+&*.</li>" ;
            result = false;
        }
        if (result == false)
        {
            message = message + "</ul>";
            string script = "ShowMessageFromServerSide('Error', '" + message + "' ,'');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Success", script, true);
        }
        return result;
    }

    private void ShowMessageInNextPage(string message)
    {
        string randomNumber = Convert.ToString(Guid.NewGuid());
        Session["ChangePasswordMessage"] = message;
        Session["ChangePasswordRandomNo"] = randomNumber;
        string url = "ChangePassword302Redirect.aspx?RandomNo=" + randomNumber;
        Response.Redirect(url, false);
    }
}