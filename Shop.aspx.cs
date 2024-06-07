using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Project
{
    public partial class Shop : System.Web.UI.Page
    {
        static double totalAmount;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                GenerateSalesId();
            }
            
        }

        void GenerateSalesId()
        {
            string heckTicks = DateTime.Now.Ticks.ToString("X");
            lblOrderId.Text = heckTicks.Substring(heckTicks.Length -15, 9);
            lblDateTime.Text = DateTime.Now.ToString();
            
        }

        protected void GridViewProducts_SelectedIndexChanged1(object sender, EventArgs e)
        {
            lblProductsId.Text = GridViewProducts.SelectedRow.Cells[1].Text;
            lblProductsName.Text = GridViewProducts.SelectedRow.Cells[2].Text;
            lblProductsPrice.Text = GridViewProducts.SelectedRow.Cells[4].Text;
        }

        void OrderAddItem()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connNike"].ConnectionString);
            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spOrderAddItem", conn);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@orderid", lblOrderId.Text);
            cmd.Parameters.AddWithValue("@productid", lblProductsId.Text);
            cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text);
            cmd.Parameters.AddWithValue("@size", ddlSize.SelectedValue);
            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                lblMessage1.Text = ex.Message;
            }

            finally
            {
                conn.Close();
            }
            txtQuantity.Text = "1";
        }

        void OrderGetTotalAmount()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
            ConnectionStrings["connNike"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spOrderGetTotalAmount", conn);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@orderid", lblOrderId.Text);

            try
            {
                // Open connection
                conn.Open();
                totalAmount = (double)cmd.ExecuteScalar();
                lblTotalAmountCart.Text = totalAmount.ToString("RM 0.00");
            }


            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }


        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            OrderAddItem();
            GridViewCart.DataBind();
            OrderGetTotalAmount();
        }

        void OrderConfirm()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
            ConnectionStrings["connNike"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spOrderConfirm", conn);
            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@orderid", lblOrderId.Text);
            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();
                lblMessage2.Text = "Order confirmed!";
            }
            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
            txtQuantity.Text = "1";
        }

        void DisplayInvoice()
        {

            double serviceTax, amountAfterTax, amountRounded, rounding;
            serviceTax = totalAmount * 0.06;
            amountAfterTax = totalAmount + serviceTax;
            amountRounded = Math.Round((amountAfterTax) / 0.05) * 0.05;
            rounding = amountRounded - amountAfterTax;

            lblTotalAmount.Text = "Total amount: " + totalAmount.ToString("RM 0.00");
            lblServiceTax.Text = "Service tax (6%): " + serviceTax.ToString("RM 0.00");
            lblAmountAfterTax.Text = "Amount after tax: " + amountAfterTax.ToString("RM 0.00");
            lblRounding.Text = "Rounding: " + rounding.ToString("RM 0.00");
            lblAmountRounded.Text = "Amount to pay:" + amountRounded.ToString("RM 0.00");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            OrderConfirm();
            DisplayInvoice();
        }

        void ClearAll()
        {
            lblProductsId.Text = "";
            lblProductsName.Text =
            lblProductsPrice.Text = "";
            lblTotalAmountCart.Text = "RM0.00";
            lblTotalAmount.Text = "";
            lblServiceTax.Text = "";
            lblAmountAfterTax.Text =
            lblRounding.Text = "";
            lblAmountRounded.Text = "";
            lblMessage1.Text = "";
            lblMessage2.Text = "";
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ClearAll();
            GenerateSalesId();
            ddlCategory.DataBind();
            ddlSize.DataBind();
            GridViewProducts.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            OrderRemoveNotConfirmed();
            ClearAll();
            GenerateSalesId();
            ddlCategory.DataBind();
            ddlSize.DataBind();
            GridViewProducts.DataBind();
        }

        void OrderRemoveNotConfirmed()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connNike"].ConnectionString);
            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spOrderRemoveNotConfirmed", conn);
            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@orderid", lblOrderId.Text);
            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();
            }


            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}