<%@ Page Title="User Registration" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="Project.registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/registration.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="registration-form">

        <h2>Register</h2>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-message" HeaderText="Please correct the following errors:" />
        <div class="form-group">
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" />
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="validation-message" Display="Dynamic" />
        </div>


        <div class="form-group">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" />
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="validation-message" Display="Dynamic" />
        </div>


        <div class="form-group">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="validation-message" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format." CssClass="validation-message" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="submit-button" OnClick="btnRegister_Click" />
        </div>
    </div>
</asp:Content>
