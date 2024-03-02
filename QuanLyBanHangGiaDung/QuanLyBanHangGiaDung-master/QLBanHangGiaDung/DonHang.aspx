<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DonHang.aspx.cs" Inherits="QLBanHangThietBiCongNghe.DonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Danh sách hóa đơn</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container">
     <div class="row">
         <center><h2>Danh sách hóa đơn đã lập</h2></center>
             <table class="table table-bordered">
                        <thead>
                            <td>STT</td>
                            <td>Mã hóa đơn</td>
                            <td>Ngày tạo</td>
                            <td>Số lượng</td>
                            <td>Tổng tiền</td>
                            <td>Tác vụ</td>
                            <td>Hủy đơn hàng</td>
                        </thead>
                            <tbody>
                         <asp:Repeater runat="server" ID="rpDanhSachHD">                    
                             <ItemTemplate>
                                 <tr>
                                    <td><%# Container.ItemIndex + 1 %> </td>
                                    <td><%# Eval("PK_iBillID") %></td>
                                    <td><%# Eval("dDateCreated") %></td>            
                                     <td><%# Eval("Soluong") %></td>
                                     <td><%# Eval("iProductPayment") %></td>
                                    <td>
                                        <a href="HoaDon.aspx?idBill=<%# Eval("PK_iBillID") %>&total=<%# Eval("iProductPayment") %>">Xem Chi Tiết</a>
                                    </td>

                                     <td>
                                        <button class='btn btn-danger btn-block' type='button' onclick="btnhuydon('<%# Eval("PK_iBillID") %>')" value='9' id='idbill' name='idbill'>
                                        <i aria-hidden='true'></i> Hủy Đơn</button> </td> 
                                </tr>
                             </ItemTemplate>
                         </asp:Repeater> 
                      </tbody>
            </table>
         </div>
     </div>
    <script>
        function btnhuydon(idbill) {
            var xhttp;
            var isConfirmed = confirm('Bạn có chắc chắn muốn hủy đơn này?');
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    if (this.responseText == "success" && isConfirmed) {
                        alert("Bạn Hủy thành công");
                        window.location.reload();
                    } else {
                        alert("Có lỗi xảy ra");
                    }

                }
            };

            var url = window.location.href;
            var params = "idbill=" + idbill + "&type=delete";
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);

        }
    </script>
</asp:Content>
