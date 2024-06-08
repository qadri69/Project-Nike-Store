using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Project
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;
                string email = txtEmail.Text.Trim();

                // Assuming PBKDF2Hash is a custom class for hashing passwords
                PBKDF2Hash hash = new PBKDF2Hash(password);
                string passwordHash = hash.HashedPassword;
                bool enabled = true;

                string connectionString = ConfigurationManager.ConnectionStrings["connNike"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string sql = @"INSERT INTO UserAccounts (Username, PasswordHash, Role, Enabled, Email) 
                                   VALUES (@username, @passwordhash, @role, @enabled, @Email)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@passwordhash", passwordHash);
                        cmd.Parameters.AddWithValue("@role", "user");
                        cmd.Parameters.AddWithValue("@enabled", enabled);
                        cmd.Parameters.AddWithValue("@Email", email);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            lblStatus.Text = "Status: Data successfully saved.";
                            Response.Redirect("Login.aspx"); // Redirect to login page after successful registration
                        }
                        catch (SqlException ex)
                        {
                            lblStatus.Text = "An error occurred while saving the data. Please try again.";
                            // Log the exception message for debugging purposes (not shown to the user)
                            // Consider using a logging framework here
                        }
                    }
                }
            }
        }
    }
}
}