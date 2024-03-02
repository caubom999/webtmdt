<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="HomeAdmin.aspx.cs" Inherits="QLBanHangThietBiCongNghe.HomeAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quản trị</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <center><h3>Chào mừng bạn đến với hệ thống quản trị </h3></center>
            <div class="col-md-3 listmenu">
                <a href="QuanLyTaiKhoan.aspx">
                    <h1>
                        <i class="fa fa-users" aria-hidden="true"></i>
                    </h1>
                    Quản lý tài khoản
                </a>
            </div>
            <div class="col-md-3 listmenu">
                <a href="QuanLySanPham.aspx">
                    <h1>
                        <i class="fa fa-gift" aria-hidden="true"></i>
                    </h1>
                    Quản lý sản phẩm
                </a>
            </div>
            <div class="col-md-3 listmenu">
                <a href="QuanLyHoaDon.aspx">
                    <h1>
                        <i class="fa fa-file" aria-hidden="true"></i>
                    </h1>
                    Quản lý hóa đơn
                </a>
            </div>
            <div class="col-md-3 listmenu">
                <a href="QuanLyPhanHoi.aspx">
                    <h1><i class="fa fa-comment" aria-hidden="true"></i></h1>
                    Quản lý phản hồi
                </a>
            </div>
    </div>
    </div>
</asp:Content>
