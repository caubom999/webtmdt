<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="QLBanHangThietBiCongNghe.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Trang chủ</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <%-- tao slide carousel trinh chieu --%>
        <div id="x" class="carousel slide pt-5" data-bs-ride="carousel">
            <%-- tao 3 cai nut chuyen dong --%>
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#x" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#x" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#x" data-bs-slide-to="2"></button>
                </div>
                       <div class="carousel-inner">
                           <div class="carousel-item active">
                                <img class="rounded" src="./images/banner4.jpg" style="width:100%; height:500px" alt="">
                               <div class="carousel-caption" style="font-family: 'Abril Fatface', serif; font-size: 30px;color: white;text-shadow: 2px 2px 2px black, 0 0 25px blue, 0 0 5px darkblue;">
                                   <h3>SUPPER TECHNOLOGY DEVICE</h3>
                                      <p>Cửa Hàng Thiết Bị Công Nghệ Chính Hãng!</p>
                               </div>
                           </div>
                 
                           <div class="carousel-item">
                                <img class="rounded" src="./images/banner5.jpg" alt="" style="width:100%; height:500px">
                               <div class="carousel-caption" style="font-family: 'Abril Fatface', serif; font-size: 30px;color: white;text-shadow: 2px 2px 2px black, 0 0 25px blue, 0 0 5px darkblue;">
                                   <h3>SUPPER TECHNOLOGY DEVICE</h3>
                                     <p>Cửa Hàng Thiết Bị Công Nghệ Chính Hãng!</p>
                               </div>
                           </div>
                                  <div class="carousel-item">
                                        <img class="rounded" src="./images/banner3.jpg" alt="" style="width:100%; height:500px">
                                      <div class="carousel-caption" style="font-family: 'Abril Fatface', serif; font-size: 30px;color: white;text-shadow: 2px 2px 2px black, 0 0 25px blue, 0 0 5px darkblue;">
                                    <h3>SUPPER TECHNOLOGY DEVICE</h3>
                                      <p>Cửa Hàng Thiết Bị Công Nghệ Chính Hãng!</p>
                                     </div>
                                       </div>
                              </div>
                           <button class="carousel-control-prev" type="button" data-bs-target="#x" data-bs-slide="prev">
                       <span class="carousel-control-prev-icon" ></span>
                   </button>
                     <button class="carousel-control-next" type="button" data-bs-target="#x" data-bs-slide="next">
                   <span class="carousel-control-next-icon"></span>
              </button>
       </div>


        <br />
        <div class="row">
            <!-- Wrapper for slides -->
            <div class="col-md-6">
                <img src="images/banner.jpg" class="img-thumbnail" alt="Chania" width="100%" height="100%">
            </div>
            <div class="col-md-6">
                <div class="text-center">
                    <h1 style="font-size: 70px; color: white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Kinh doanh thiết bị công nghệ hiện đại</h1>
                    <p style="color:red;">Hàng ngàn Ưu đãi từ Gói Chào Mừng hiện chỉ có trên ứng dụng SUPER TECH. sản phẩm giảm giá 66% và những phần quà hấp dẫn</p>
                </div>
            </div>
        </div>
        <div id="main-content">
            <div class="container">
                <center><h2 style="text-shadow: 1px 1px 2px black, 0 0 25px red, 0 0 5px darkblue;">Hàng đang được bán chạy nhất</h2></center>
                <center><p class="text-danger">Sản phẩm HOT nhất năm 2023</p></center>
                <div class="row pt-5">
                    <asp:Repeater ID="rpSpMoi" runat="server">
                        <ItemTemplate>
                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2 product">
                                <div class="anhproduct">
                                    <img src="images/<%# Eval("sImage") %>" width="100%" alt="">
                                </div>
                                <div class="infoproduct">
                                    <center><p><%# Eval("fPromotion") %>%</p></center>
                                </div>
                                <div class="infonew">
                                    <center><p>Sale</p></center>
                                </div>
                                <div class="addclass">
                                    <center>
                                        <div class="iconadd">
                                            <button type="button" onclick="addCart('<%# Eval("PK_iProductID") %>')" class="btn" value="<%# Eval("PK_iProductID") %>" name="btnAddCart">
                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                            </button> 
                                        </div>
                                    </center>
                                    <center>
                                                                    <a href="ChiTietMatHang.aspx?masp=<%# Eval("PK_iProductID") %>">

                                        <h4 class=""><%# Eval("sName") %></h4>
                                                                        </a>
                                        <h5 class="colorprice">

                                            <b><%# Eval("iPrice")%> VNĐ</b> 
                                            </h5>

                                    </center>
                                </div>

                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="container">
                <div class="row" style="margin-top: 40px; margin-bottom: 40px">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                        <div class="anhproduct">
                            <img src="images/Banner-2l.jpg" width="100%" alt="">
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                        <div class="anhproduct">
                            <img src="images/Banner_2r.jpg" width="100%" alt="">
                        </div>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row">
                    <center><h2 style="text-shadow: 1px 1px 2px black, 0 0 25px red, 0 0 5px darkblue;">Sản Phẩm Nổi Bật</h2></center>
                    <center><p class="text-danger">Có lượt yêu thích nhiều nhất tháng</p></center>
                </div>
                <div class="row pt-5">
                    <asp:Repeater ID="rpSpNoiBat" runat="server">
                        <ItemTemplate>
                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2 product ">

                                <div class="anhproduct">
                                    <img src="images/<%# Eval("sImage") %>" width="100%" alt="">
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
                                        <a href="ChiTietMatHang.aspx?masp=<%# Eval("PK_iProductID") %>">
                                        <h4><%# Eval("sName") %></h4>
                                            </a>
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
        </div>
         </div>
       
</asp:Content>
