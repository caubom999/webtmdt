<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ThongTinCaNhan.aspx.cs" Inherits="QLBanHangThietBiCongNghe.ThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Thông tin cá nhân</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <img class="rounded-circle" src="images/avt.jpg" alt="avatar" width="100%" />
                <hr />
                <p>Tài khoản: <%= Session["username"] %></p>
                <p>Trạng thái:
                <asp:Label ID="lbTrangThai" runat="server"></asp:Label></p>
                <h2 style="color:red">
                <asp:Label ID="lbThongBaoKetQua" runat="server"></asp:Label>
                </h2>
            </div>
            <div class="col-md-10">
                <div class="form-group row">
                    <div class="col-md-12">
                        <label for="inputhoten" class="col-sm-3 col-form-label">Họ tên</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputhoten" runat="server"  placeholder="Nhập họ tên">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label for="inputsdt" class="col-sm-3 col-form-label">Số điện thoại</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputsdt" runat="server" placeholder="Nhập số điện thoại">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label for="inputNgaySinh" class="col-sm-3 col-form-label">Ngày sinh</label>
                        <div class="col-sm-9">
                            <input type="date" class="form-control" id="inputNgaySinh" runat="server" placeholder="Nhập ngày sinh">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label for="inputDiaChi" class="col-sm-3 col-form-label">Địa chỉ Giao Hàng</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="inputDiaChi" runat="server" placeholder="Nhập địa chỉ">
                        </div>
                    </div>

                    <div class="col-md-12">
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-success btn-block" OnClick="Button1_Click" Text="Cập nhật thông tin" />
                     
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        const fileUpload = document.querySelector("#file-upload");
        fileUpload.addEventListener("change", (event) => {
            const { files } = event.target;

            console.log("files", files)
        })
</script>
</asp:Content>
