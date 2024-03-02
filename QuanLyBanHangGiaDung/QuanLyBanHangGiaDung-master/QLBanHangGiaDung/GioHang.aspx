<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="QLBanHangThietBiCongNghe.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Giỏ hàng</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
       <%-- <div class="row">
            <img src="images/bannergiohang2.jpg" width="100%" height="auto" alt="" style="min-height: 300px">
        </div>--%>
    </div>
    <div class="container pt-5">
        <center><h3>GIỎ HÀNG</h3></center>
        <br>
        <div class="row">
            <div id="ContentPlaceHolder1_listCart" class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                <asp:DataList ID="dlGioHang" runat="server">
                    <ItemTemplate>
                        <div class='chitietdondathang box '>
                            <div class='row'>
                                <div class='col-xs-12 col-sm-6 col-md-3 col-lg-3'>
                                    <label class='checkbox-inline'>
                                        <img src='images/<%# Eval("sImage") %>' height='100vh' width='100%' alt=''>
                                    </label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </div>
                                <div class='col-xs-12 col-sm-6 col-md-4 col-lg-4'>
                                    <h4>
                                        <%# Eval("sName") %></h4>
                                    <h5>Số lượng</h5>
                                    <input onkeypress="return isNumberKey(event)" type="text" onchange="updateCart('<%# Eval("PK_iCartID") %>',this)" placeholder="Số lượng" value="<%# Eval("iAmount") %>" />
                                    <h5><%# Eval("sUnit") %></h5>
                                </div>
                                <div class='col-xs-12 col-sm-6 col-md-2 col-lg-2'>
                                    <h4 style='color: orange;'><%# String.Format("{0} vnd", Convert.ToInt32(Eval("iPrice")) * (100 - Convert.ToInt32(Eval("fPromotion"))) / 100) %></h4>
                                    <del><%# Eval("iPrice") %> vnd</del><h5>Discount: <%# Eval("fPromotion") %> %</h5>
                                </div>
                                <div class='col-xs-12 col-sm-6 col-md-3 col-lg-3'>
                                    <button class='btn btn-danger btn-block' type='button' onclick="deleteCart('<%# Eval("PK_iCartID") %>')" value='9' id='btnXoa' name='btnXoa'>
                                        <i class='fa fa-trash' aria-hidden='true'></i> Xóa</button>
                                    <input style="margin:10px 0px 0px 60px" type="checkbox" class="check-input" onclick="checkProduct('<%# Eval("PK_iCartID") %>',this.checked)" <%# (bool)Eval("bCheck") ? "checked" : ""%> />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>

            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="thongtindonhang box">
                   <center><h4>Thông tin đơn hàng</h4></center>
                    <div class="row pt-5">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <p>Số loại sản phẩm</p>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 text-right">

                            <p style="color: red" id="txtnumberOfProduct">0</p>

                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <p>Tổng tiền</p>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 text-right">

                            <p style="color: red" id="txttotalPrice">0</p>

                        </div>
                        <center><button class="btn btn-warning" style="width: 90%" runat="server" onServerClick="Button1_OnClick ">Xác nhận đơn hàng</button></center>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', function () {
            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    var numberofproduct = this.responseText.split("-")[0];
                    var totalprice = this.responseText.split("-")[1];

                    document.getElementById('txtnumberOfProduct').innerText = numberofproduct;
                    document.getElementById('txttotalPrice').innerText = totalprice;
                }
            };

            var url = window.location.href;
            var params = "type=load";
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }, false);


        function deleteCart(idcart) {
            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    if (this.responseText == "success") {
                        alert("Xóa thành công");
                        window.location.reload();
                    } else {
                        alert("Có lỗi xảy ra");
                    }

                }
            };

            var url = window.location.href;
            var params = "idcart=" + idcart + "&type=delete";
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
            
        }

        // Hàm gồm 2 tham số là mã mặt hàng (idcart) với số lượng (input)
        function updateCart(idcart, input) {

            if (input.value == 0 || input.value == "") {
                var r = confirm("Mặt hàng sẽ bị xóa nếu bạn đặt số lượng là 0 hoặc rỗng!");
                if (r == false) {
                    input.value = 1;
                }
            }

            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    sync(idcart);
                    if (this.responseText == "success" && (input.value == 0 || input.value == "")) {
                        window.location.reload();
                    }
                }
            };

            var url = window.location.href;
            var params = "idcart=" + idcart + "&type=update&amount=" + input.value;
            console.log(params);
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }
        // gọi khi nhập số lượng, nếu đc check thì update thông tin lên thông tin đơn hàng, không thì thôi
        function sync(idcart) {
            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    if (this.responseText != "no") {
                        var numberofproduct = this.responseText.split("-")[0];
                        var totalprice = this.responseText.split("-")[1];

                        document.getElementById('txtnumberOfProduct').innerText = numberofproduct;
                        document.getElementById('txttotalPrice').innerText = totalprice;
                    }

                }
            };

            var url = window.location.href;
            var params = "idcart=" + idcart + "&type=sync";
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }

        // hàm này gọi khi nhấn vào nút check, truyền 2 tham số là mã sản phẩm , 2 trạng thái nút check
        function checkProduct(idcart, statusCheck) {
            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest();
            }
            else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);
                    // Cắt chuỗi theo dấu - (3-1000000) split("-")  a[3,100000]
                    var numberofproduct = this.responseText.split("-")[0];
                    var totalprice = this.responseText.split("-")[1];
                    // Sau khi lấy đc giá thì hiển thị lên giao diện
                    // p: id = sanpham
                    // p: không thể đặt thẻ p có id là sanpham nữa
                    document.getElementById('txtnumberOfProduct').innerText = numberofproduct;
                    document.getElementById('txttotalPrice').innerText = totalprice;
                }
            };
            // Nếu nút check là true thì tham số gửi đi là 1
            var value = statusCheck ? 1 : 0;
            var url = window.location.href;
            console.log(url);
            var params = "idcart=" + idcart + "&type=check&value=" + value;
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }
        // Hàm kiểm tra xem giá trị nhập vào có phải là số hay không
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>

</asp:Content>
