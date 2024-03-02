<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="HoaDon.aspx.cs" Inherits="QLBanHangThietBiCongNghe.HoaDon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Hóa đơn</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="chitietdondathang row box">
            <center><h1>Thông tin đơn hàng</h1>
                <p>Họ và tên khách hàng: <asp:Label id="hotenkh" runat="server"></asp:Label> </p>
                <p>Địa chỉ: <asp:Label id="diachi" runat="server"></asp:Label></p>
                <p>Số điện thoại: <asp:Label id="sodienthoai" runat="server"></asp:Label></p>
                <p>Tổng tiền: <%= total %></p>
            </center>
            <table class="table table-bordered">
                <thead>
                    <td>STT</td>
                    <td>Tên hàng</td>
                    <td>Số lượng</td>
                    <td>Giá</td>
                    <td>Giảm giá</td>
                    <td>Thành tiền</td>
                </thead>
                <tbody>
                    <asp:Repeater ID="rpDonHang" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Container.ItemIndex + 1 %></td>
                                <td><%# Eval("sName") %></td>
                                <td><%# Eval("iAmount") %></td>
                                <td><%# Eval("iPrice") %></td>
                                <td><%# Eval("fPromotion") %> %</td>  
                                <td><%# String.Format("{0}",Convert.ToInt32(Eval("iPrice")) *Convert.ToInt32(Eval("iAmount"))* (100-Convert.ToInt32(Eval("fPromotion")))/100) %> vnd</td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <asp:Label  ID="tongtien" runat="server"></asp:Label>
            <button type="button" class="btn btn-block btn-warning" runat="server" onserverclick="buttonSubmit" id="buttonsubmit">Đặt hàng</button>
        </div>


        <div class="col-md-12 order-md-1">

    <h4>Chọn phương thức thanh toán:</h4>

    <div class="d-block my-3">

         <h5 class="mb-3">Cách 1: Thanh toán khi nhận hàng</h5>
        <div class="custom-control custom-radio">
        <asp:RadioButton Text="Thanh Toán COD" Checked="True" GroupName="RadioGroup1" runat="server" /><br />
        </div>

         <h5 class="mb-3">Cách 2: Chuyển hướng sang VNPAY chọn phương thức thanh toán</h5>
        <div class="custom-control custom-radio">
          <asp:RadioButton id="bankcode_Default" Text="Cổng thanh toán VNPAYQR" Checked="True" GroupName="RadioGroup1" runat="server" /><br />
        </div>

        <h5 class="mb-3">Cách 3: Tách phương thức thanh toán tại site của Merchant</h5>
        <div class="custom-control custom-radio">
           <asp:RadioButton id="bankcode_Vnpayqr" Text="Thanh toán qua ứng dụng hỗ trợ VNPAYQR" GroupName="RadioGroup1" runat="server"/><br />
           
        </div>
        <div class="custom-control custom-radio">
          <asp:RadioButton id="bankcode_Vnbank" Text="ATM-Tài khoản ngân hàng nội địa" GroupName="RadioGroup1" runat="server"/><br />
        </div>
        <div class="custom-control custom-radio">
           <asp:RadioButton id="bankcode_Intcard" Text="Thanh toán qua thẻ quốc tế" GroupName="RadioGroup1" runat="server"/><br />
        </div>

        <h4>Chọn ngôn ngữ thanh toán:</h4>
         <div class="custom-control custom-radio">
          <asp:RadioButton id="locale_Vn" Text="Tiếng việt" Checked="True" GroupName="RadioGroup2" runat="server" /><br />
          <asp:RadioButton id="locale_En" Text="Tiếng anh" GroupName="RadioGroup2" runat="server" /><br />
        </div>
       <button type="button" class="btn btn-default btn-warning" runat="server" onserverclick="btnPay_Click" id="btnPay">Thanh toán</button>
    </div>

</div>


    </div>
</asp:Content>
