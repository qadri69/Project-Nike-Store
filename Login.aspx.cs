using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Project
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string sql = @"SELECT * FROM UserAccounts WHERE UserName = @username";
            string connectionString = ConfigurationManager.ConnectionStrings["connNike"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@username", txtUserName.Text);

                    try
                    {
                        conn.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            // Username found
                            string storedPasswordHash = dt.Rows[0]["PasswordHash"].ToString();
                            string role = dt.Rows[0]["Role"].ToString();
                            bool enabled = Convert.ToBoolean(dt.Rows[0]["Enabled"]);
                            string password = txtPassword.Text;

                            // Assuming PBKDF2Hash is a custom class for hashing passwords
                            PBKDF2Hash hash = new PBKDF2Hash(password, storedPasswordHash);
                            bool check = hash.PasswordCheck;

                            if (check && enabled)
                            {
                                // Password correct and account enabled
                                Session["UserName"] = txtUserName.Text;
                                Session["Role"] = role;

                                if (role == "user")
                                {
                                    Response.Redirect("WebFormShop.aspx");
                                }
                                else if (role == "admin")
                                {
                                    Response.Redirect("Admin.aspx");
                                }
                            }
                            else
                            {
                                // Password incorrect or account disabled
                                lblStatus.Text = "Incorrect password or account disabled.";
                            }
                        }
                        else
                        {
                            // Username not found
                            lblStatus.Text = "Incorrect username.";
                        }
                    }
                    catch (SqlException ex)
                    {
                        lblStatus.Text = "An error occurred while logging in. Please try again.";
                        // Log the exception message for debugging purposes (not shown to the user)
                        // Consider using a logging framework here
                    }
                }
            }
        }
    }
}