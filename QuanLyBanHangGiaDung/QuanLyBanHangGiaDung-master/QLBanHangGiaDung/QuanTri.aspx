<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="QuanTri.aspx.cs" Inherits="QLBanHangGiaDung.QuanTri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <asp:Repeater ID="rpAdmin" runat="server">
                <ItemTemplate>
                    <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 product button-admin">
                        <a href="<%# Eval("link") %>">
                            <h1><%# Eval("name") %></h1>
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>