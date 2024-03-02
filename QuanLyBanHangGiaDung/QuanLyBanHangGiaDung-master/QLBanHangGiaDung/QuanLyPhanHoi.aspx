<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyPhanHoi.aspx.cs" Inherits="QLBanHangThietBiCongNghe.QuanLyPhanHoi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quản lý phản hồi</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container">
     <div class="row">
         <h3 style="color:red">
             <asp:Label runat="server" ID="thongbaophanhoi"></asp:Label>
         </h3>
             <table class="table table-bordered">
                        <thead>
                            <td>STT</td>
                            <td>Sản phẩm</td>
                            <td>Người phản hổi</td>
                            <td>Thời gian phản hồi</td>
                            <td>Nội dung phản hồi</td>
                            <td>Tác vụ</td>
                        </thead>
                            <tbody>
                         <asp:Repeater runat="server" ID="rpDanhSachPhanHoi">                    
                             <ItemTemplate>
                                 <tr>
                                    <td><%# Container.ItemIndex + 1 %>  </td>
                                    <td><%# Eval("ten_sp") %></td>
                                    <td><%# Eval("ten_kh") %></td>
                                     <td><%# Eval("dDate") %></td>
                                    <td><%# Eval("sContent") %></td>                                 
                                    <td>
                                        <a href="QuanLyPhanHoi.aspx?maphanhoi=<%# Eval("PK_iFeedbackID") %>">Xóa</a>
                                    </td>
                                </tr>
                             </ItemTemplate>
                         </asp:Repeater> 
                      </tbody>
            </table>
         </div>
        </div>
</asp:Content>
