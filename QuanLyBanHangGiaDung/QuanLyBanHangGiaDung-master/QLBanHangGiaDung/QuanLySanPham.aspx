<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="QLBanHangThietBiCongNghe.QuanLySanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quản lý sản phẩm</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">

            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="capthongtin box">
                    <center><h3><b>Mặt Hàng</b></h3></center>

                    <center>
						<div class="form-group row">
                            <div class="col-md-6">
                                <div class="row">
							        <label for="inputTenHang1" class="col-md-3 col-form-label">Tên mặt hàng</label>
							        <div class="col-md-9">
								        <input type="text" class="form-control" id="inputTenMH" placeholder="Tên Hàng" runat="server">
    							    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <label for="inputGia1" class="col-md-3 col-form-label">Giá</label>
							        <div class="col-md-9">
    								    <input type="number" class="form-control" id="inputGiaBan" placeholder="Nhập giá" runat="server" name="txtGia">
	    						    </div>
                                </div>
                                
                                <br />
                                 <div class="row">
                                    <label for="inputDonViTinh1" class="col-md-3 col-form-label">Đơn vị tính</label>
							        <div class="col-md-9">
    								    <input type="text" class="form-control" id="inputDVT" placeholder="Nhập đơn vị tính" runat="server">
	    						    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <label for="inputGia1" class="col-md-3 col-form-label">Giảm giá</label>
							        <div class="col-md-9">
							    	    <input type="number" class="form-control" id="inputGiamGia" placeholder="Nhập giảm giá"  runat="server">
    							    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <label for="inputAnh1" class="col-md-3 col-form-label">Ảnh</label>
							        <div class="col-md-6">
                                        <asp:FileUpload ID="inputAnh1" runat="server" name="myImage" CssClass="form-control" />
							        </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-basic" runat="server" Text="Upload" onserverClick="btnUpload_Click">Upload</button>
                                    </div>
                                 </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <asp:Image ID="ImgSP" runat="server" width="150px" />
                                </div>
                                <div class="row">
                                        <label for="inputLoaiHang" class="col-md-3 col-form-label">Chọn loại hàng</label>
                                     <div class="col-md-9">
                                     <asp:DropDownList CssClass="form-control" id="ddlLoaiHang" runat="server">

                                     </asp:DropDownList>
                                     </div>
                                </div>
                                <br />
                                <div class="row">
                                    <label for="inputMoTa" class="col-md-3 col-form-label">Mô tả</label>
							        <div class="col-md-9">
    								    <textarea type="text" class="form-control" id="inputMoTa" placeholder="Nhập mô tả cho sản phẩm" runat="server" cols="5"></textarea>
	    						    </div>
                                </div>
                                <div class="row" id="radioStatus" runat="server">
                                    <label for="inputMoTa" class="col-md-3 col-form-label">Trạng thái</label>
							        <div class="col-md-9">
    								    <div class="radio">
                                          <label><input type="radio" id="dangban" name="optradio" runat="server" checked>  Đang bán</label>
                                        </div>
                                        <div class="radio">
                                          <label><input type="radio" id="ngungkinhdoanh" name="optradio" runat="server">Ngừng kinh doanh</label>
                                        </div>
	    						    </div>
                                </div>
                                <br />
                            </div>
                </div>
						<div class="form-group row">
							<div class="col-sm-12 ">									
                                <input type="hidden" />
								<asp:Button ID="btnCapNhat" runat="server"  Text="Thêm mới" OnClick="clickButtonAddUpdate" CommandName="add"/>
								<br>
								<center> 
                                    <button Text="ADD" type="submit" runat="server" class="btn btn-basic" ID="buttonCancel" onserverClick="btnCancel_Click">Hủy</button>
								</center>
							</div>

						</div>
					</center>
                </div>
            </div>
        </div>
        <div class="row">
            <h3 style="color:red">
                 <asp:Label runat="server" ID="thongbaosanpham"></asp:Label>
            </h3>
             <center><h2>Danh sách sản phẩm trong hệ thống</h2></center>
            <table class="table table-bordered">
                <thead>
                    <td>STT</td>
                    <td>Ảnh sản phẩm</td>
                    <td>Tên sản phẩm</td>
                    <td>Giá bán</td>
                    <td>Giảm giá</td>
                    <td>Trạng Thái</td>
                    <td class="text-center">Tác vụ</td>
                </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="rpDanhSachSP">
                        <ItemTemplate>
                            <tr>
                                <td><%# Container.ItemIndex + 1 %></td>
                                <td><img width="100px" src="images/<%# Eval("sImage") %>"</td>
                                <td><%# Eval("sName") %></td>
                                <td><%# Eval("iPrice") %></td>                                
                                <td><%# Eval("fPromotion") %> %</td>                                
                                <td><%# (bool)Eval("bStatus") ?  "<b>Đang bán</b>" : "Ngừng kinh doanh"%></td>                          
                                <td class="text-center">
                                    <a class="btn btn-danger" href="QuanLySanPham.aspx?action=delete&masp=<%# Eval("PK_iProductID") %>" onclick="return confirm('Xác nhận ngừng kinh doanh sản phẩm này?')">Ngừng kinh doanh</a>
                                    <a class="btn btn-primary" href="QuanLySanPham.aspx?action=edit&masp=<%# Eval("PK_iProductID") %>">Sửa</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
