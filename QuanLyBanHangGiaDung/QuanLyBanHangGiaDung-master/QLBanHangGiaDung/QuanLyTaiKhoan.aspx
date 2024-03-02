<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyTaiKhoan.aspx.cs" Inherits="QLBanHangThietBiCongNghe.QuanLyTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quản lý tài khoản</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <center><h2>Danh sách tài khoản trong hệ thống</h2></center>
          <h3 style="color:red">
             <asp:Label runat="server" ID="thongbaotaikhoan"></asp:Label>
         </h3>
		<div class="list-account box">
			<div class="row">
                 <table class="table table-bordered">
                        <thead>
                            <td>STT</td>
                            <td>Họ tên</td>
                            <td>Tài khoản</td>
                            <td>Địa chỉ</td>
                            <td>Ngày sinh</td>
                            <td>Trạng thái</td>
                            <td class="text-center">Tác vụ</td>
                         </thead>
                <asp:Repeater ID="rpListAccount" runat="server">
                    <HeaderTemplate>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td><%# Eval("sName") %></td>
                            <td><%# Eval("sUserName") %></td>
                            <td><%# Eval("sAddress") %></td>
                            <td><%# Eval("dDoB") %></td>
                            <td><%# (bool)Eval("bStatus") ? "Đang kích hoạt" : "Tạm khóa" %></td>
                            <td class="text-center">
                                <%# (bool)Eval("bStatus") ?
                                "<a class='btn btn-danger' href='QuanLyTaiKhoan.aspx?action=lock&matk="+Eval("PK_iUserID")+"'>Khóa tài khoản</a>" : 
                                "<a class='btn btn-success' href='QuanLyTaiKhoan.aspx?action=unlock&matk="+Eval("PK_iUserID")+"'>Mở khóa tài khoản</a>"
                                %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                       </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
</table>
			</div>
		</div>
	</div>
</asp:Content>

