<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Project.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h1>Admin Page</h1>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connNike %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO [Users] ([Username], [PasswordHash], [Email], [Role], [Enable]) VALUES (@Username, @PasswordHash, @Email, @Role, @Enable)" SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [Username] = @Username, [PasswordHash] = @PasswordHash, [Email] = @Email, [Role] = @Role, [Enable] = @Enable WHERE [UserID] = @UserID">
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Username" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enable" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Username" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enable" Type="Boolean" />
            <asp:Parameter Name="UserID" Type="Int32" />
        </UpdateParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SqlDataSource1">
    <Columns>
        <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
        <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
        <asp:BoundField DataField="PasswordHash" HeaderText="PasswordHash" SortExpression="PasswordHash" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
        <asp:CheckBoxField DataField="Enable" HeaderText="Enable" SortExpression="Enable" />
    </Columns>
</asp:GridView>
</asp:Content>
