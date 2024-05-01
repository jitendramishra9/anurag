<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword302Redirect.aspx.cs"
    Inherits="DistrictAdminPortal_ChangePassword302Redirect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <!-- BOX css : box , box-primary -->
    <link href="../dist/css/box.css" rel="stylesheet" />
    <!-- jQuery JS -->
    <script type="text/javascript" src="../vendor/jquery/jquery.js"></script>

    <!-- Bootstrap JS -->
    <script type="text/javascript" src="../vendor/bootstrap/js/bootstrap.js"></script>
</head>
<body>
     <form id="form1" runat="server">
        <center>
            <div class="content">
                <div class="container cont">
                    <div class="row">
                        <div style="padding-top: 15%; width: 70%;">
                            <div class="panel panel-primary">
                                <div class="panel-heading" style="text-align: left;">
                                    <h3 class="panel-title tab_heading_in ">Result :
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="well" style="text-align: left;">
                                        <asp:Label ID="lblMessage" runat="server" Style="font-family: Calibri; font-size: 15px;"></asp:Label>
                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: center;">
                                    <button type="button" class="btn btn-primary" onclick="window.location.href='Home.aspx'">
                                        <span class="glyphicon glyphicon-arrow-left"></span>Return
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </center>
    </form>
</body>
</html>
