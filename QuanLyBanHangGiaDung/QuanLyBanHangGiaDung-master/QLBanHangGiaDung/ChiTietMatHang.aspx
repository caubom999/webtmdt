<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChiTietMatHang.aspx.cs" Inherits="QLBanHangThietBiCongNghe.ChiTietMatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Chi tiết mặt hàng</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <asp:Image ID="ImageProduct" runat="server" Width="100%" ImageUrl="~/images/abc (1).png" />
            </div>
            <div class="col-md-6">
                <h3>
                    Tên sản phẩm
                </h3>
                <h1>
                    <asp:Label ID="tieudesanpham" runat="server"></asp:Label>
                </h1>
                <p>
                    Đơn giá: <asp:Label ID="dongia" runat="server"></asp:Label></p>
                    Giảm giá: <asp:Label ID="giamgia" runat="server"></asp:Label></p>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <br>
                        <button type="button" onclick="addCart()" class="btn btn-success" name="btnAddCart" >Thêm vào giỏ hàng <i class="fa fa-shopping-cart" aria-hidden="true"></i></button>
                    </div>
                    <div class="col-md-12">
                        <h3>MÔ TẢ SẢN PHẨM</h3>
                        <asp:Label ID="lbMotasanpham" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <center><h3>SẢN PHẨM LIÊN QUAN</h3></center>
            <asp:Repeater ID="rpSanPhamLienQuan" runat="server">
                <ItemTemplate>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 product">
                        <div class="anhproduct">
                            <img src="images/<%# Eval("sImage") %>" width="100%" alt="" />
                        </div>
                        <div class="infoproduct">
                            <center><p><%# Eval("fPromotion") %>%</p></center>
                        </div>
                        <div class="infonew">
                            <center><p>sale</p></center>
                        </div>
                        <div class="addclass">
                            <center>                                        
                                <div class="iconadd">
                                <button type="button" onclick="addCart('<%# Eval("PK_iProductID") %>')" class="btn" value="<%# Eval("PK_iProductID") %>" name="btnAddCart" >
                                  <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                  </button> 
                                        </div>
                                    </center>
                            <center>
    <a href="ChiTietMatHang.aspx?masp=<%# Eval("PK_iProductID") %>"><h4><%# Eval("sName") %></h4></a>
                                        <h5 class="colorprice">
                                            <b><%# Eval("iPrice") %></b> 
                                        </h5>
                                    </center>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <br />
    <br />
    <br />
    <br />

    <div class="container">
        <div class="row">
            <center><h3>PHẢN HỒI</h3></center>
            <div class="col-md-12">
                <h5>Phản hồi với tư cách: <%= Session["username"] %> </h5>
            </div>
            <div class="col-md-3">
                <h5>Nội dung phản hồi</h5>
            </div>
            <div class="col-md-9">
                <textarea class="form-control" id="txtPhanHoi" cols="5"></textarea>
            </div>
            <div class="col-md-12">
                <br />
                <center><button class="btn btn-success btn-block" type="button" onclick="loadFeedback()" >Gửi</button></center>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <center><h4>DANH SÁCH CÁC PHẢN HỒI</h4></center>
            </div>
            <div id="phanhoi">
                <asp:Repeater ID="rpPhanHoi" runat="server">
                    <ItemTemplate>
                        <p>Họ và tên:<%# Eval("TenKH") %></p>
                        <p>Gửi lúc:<%# Eval("dDate") %></p>
                        <p>Nội dung:<%# Eval("sContent") %></p>
                        <hr />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <script>
        function loadFeedback() {
            var xhttp;
            if (window.XMLHttpRequest) {
                xhttp = new XMLHttpRequest(); //cú pháp để tạo đối tượng XMLHttpRequest trong AJAX:
            } else {
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }


            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    data = this.responseText; // Trả về phản hồi dưới dạng một chuỗi.
                    //console.log(data);
                    document.getElementById("phanhoi").innerHTML += data;
                    document.getElementById("txtPhanHoi").value = null;
                }
            };
            var noidungph = document.getElementById("txtPhanHoi").value;

            //Với phương thức POST
            var url = window.location.href;
            var params = 'noidungph=' + noidungph;

            xhttp.open('POST', url, true);
            //Gửi header kèm request
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }

        function addCart() {
            var myParam = location.search.split('masp=')[1];
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
                        console.log(this.responseText);
                        alert("Thêm giỏ hàng thàng công");
                        window.location = "GioHang.aspx";
                    } else {
                        alert("Lỗi");
                    }

                }
            };
            var url = "TrangChu.aspx";
            var params = "idproduct=" + myParam;
            console.log(params);
            xhttp.open('POST', url, true);
            xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhttp.send(params);
        }

    </script>
</asp:Content>
