<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="Project.Shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/StyleSheet1.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="leftColumn">
        <h3>Sales Item</h3>
        <p>
            Select Category:&nbsp;
            <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="SqlDataSourceCategories" DataTextField="CatTitle" DataValueField="CatId" AutoPostBack="True"></asp:DropDownList>
        </p>
        <br />
        <p>

            <asp:GridView ID="GridViewProducts" runat="server" DataSourceID="SqlDataSourceProduct" AutoGenerateColumns="False" DataKeyNames="ProductID" OnSelectedIndexChanged="GridViewProducts_SelectedIndexChanged1">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Price" DataFormatString="{0:n2}" HeaderText="Price" SortExpression="Price" />
                    <asp:ImageField DataImageUrlField="ImageUrl" DataImageUrlFormatString="Images/{0}" HeaderText="Images">
                        <ControlStyle Width="70px" />
                    </asp:ImageField>
                </Columns>
            </asp:GridView>

        </p>
        <p>
            Products ID:
            <asp:Label ID="lblProductsId" runat="server" ></asp:Label>&nbsp; |
            Products Name:
            <asp:Label ID="lblProductsName" runat="server" ></asp:Label>&nbsp; |
            Products Price:
            <asp:Label ID="lblProductsPrice" runat="server" ></asp:Label>&nbsp; |
            Products Size:
            <asp:DropDownList ID="ddlSize" runat="server">
                <asp:ListItem Value="S">S</asp:ListItem>
                <asp:ListItem Value="M">M</asp:ListItem>
                <asp:ListItem Value="L">L</asp:ListItem>
                <asp:ListItem Value="XL">XL</asp:ListItem>
                
            </asp:DropDownList>
        </p>
        <p>
            Quantity:
            <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Width="50px">1</asp:TextBox>
            <asp:Button ID="btnAddProduct" runat="server" Text="Order" OnClick="btnAddProduct_Click" />
        </p>
        <p>
            <asp:Label ID="lblMessage1" runat="server" ></asp:Label>

        </p>
    </div>
    <br />
    <div class="rightColumn">
        <h3>Sales Cart</h3>
        <p>
            Order ID:
            <asp:Label ID="lblOrderId" runat="server" ></asp:Label>&nbsp; |
            Date & Time:
            <asp:Label ID="lblDateTime" runat="server" ></asp:Label>
        </p>
        <p>
            <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCart">
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="ProductId" SortExpression="ProductId" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Price" DataFormatString="{0:n2}" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="Size" HeaderText="Size" SortExpression="Size" />
                    <asp:BoundField DataField="Subtotal" DataFormatString="{0:n2}" HeaderText="Subtotal" ReadOnly="True" SortExpression="Subtotal" />
                </Columns>
            </asp:GridView>
            Total amount:
            <asp:Label ID="lblTotalAmountCart" runat="server" Text="RM0.00"></asp:Label>
        </p>
        <p>
            <asp:Button ID="btnConfirm" runat="server" Text="Confirm Order" OnClick="btnConfirm_Click" />&nbsp;
            <asp:Button ID="btnCancel" runat="server" Text="Cancel Order" OnClick="btnCancel_Click" />&nbsp;
            <asp:Button ID="btnNew" runat="server" Text="New Order" OnClick="btnNew_Click" />
        </p>
        <p>
            <asp:Label ID="lblMessage2" runat="server"></asp:Label>
        </p>
        <p>
            <asp:Label ID="lblTotalAmount" runat="server"></asp:Label><br />
            <asp:Label ID="lblServiceTax" runat="server"></asp:Label><br />
            <asp:Label ID="lblAmountAfterTax" runat="server"></asp:Label><br />
            <asp:Label ID="lblRounding" runat="server"></asp:Label><br />
            <asp:Label ID="lblAmountRounded" runat="server"></asp:Label><br />
        </p>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:connNike %>" SelectCommand="SELECT * FROM [Categories] ORDER BY [CatTitle]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProduct" runat="server" ConnectionString="<%$ ConnectionStrings:connNike %>" SelectCommand="SELECT * FROM [Products] WHERE ([CatId] = @CatId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCategory" Name="CatId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:connNike %>" SelectCommand="spOrderGetItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblOrderId" Name="orderid" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
