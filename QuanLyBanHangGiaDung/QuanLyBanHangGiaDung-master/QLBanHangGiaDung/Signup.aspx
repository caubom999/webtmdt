<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="QLBanHangThietBiCongNghe.Signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Đăng ký</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg">
    <div class="wrapper">
  <div id="formContent">
    <!-- Login Form -->
      <h1 style="color: white; margin: 20px 0px 20px 0px;">Welcome Page</h1>
      <input type="text" id="name" class="form-control" placeholder="Họ và tên" runat="server">
      <asp:RequiredFieldValidator ID="rqHoTen" runat="server" ErrorMessage="Vui lòng nhập họ tên..." ControlToValidate="name"></asp:RequiredFieldValidator>

      <asp:RegularExpressionValidator ID="revFullName" runat="server" ControlToValidate="name"
    ErrorMessage="Họ và tên không được chứa số."
    ValidationExpression="^[^\d]+$" />

      <input type="text" id="username" class="form-control" placeholder="Tên đăng nhập" runat="server">
        <asp:RequiredFieldValidator ID="rqTenDangNhap" runat="server" ErrorMessage="Vui lòng nhập tên đăng nhập..." ControlToValidate="username"></asp:RequiredFieldValidator>

      <input type="text" id="phonenumber" class="form-control" placeholder="Số điện thoại" runat="server">
      <asp:RequiredFieldValidator ID="rqSoDienThoai" runat="server" ErrorMessage="Vui lòng nhập số điện thoại..." ControlToValidate="phonenumber"></asp:RequiredFieldValidator>

      <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="phonenumber"
    ErrorMessage="Số điện thoại không được chứa chữ..."
    ValidationExpression="^[0-9]+$" />

      <input type="password" id="password" class="form-control" placeholder="Mật khẩu" runat="server">
      <asp:RequiredFieldValidator ID="rqPass" runat="server" ErrorMessage="Vui lòng nhập mật khẩu..."  ControlToValidate="password" ></asp:RequiredFieldValidator>
      
     <%-- kiểm tra Mật khẩu phải lớn hơn 5 kí tự và có 1 chữ Hoa--%>
     <%-- <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password"
ErrorMessage="Mật khẩu phải lớn hơn 5 kí tự và có 1 chữ Hoa"
ValidationExpression="^(?=.*[A-Z]).{6,}$"></asp:RegularExpressionValidator>--%>

      <asp:RegularExpressionValidator runat="server" ControlToValidate="password"
    ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất một chữ hoa và một ký tự đặc biệt."
    ValidationExpression="^(?=.*[A-Z])(?=.*\W)(?!.*\s).{6,}$" />
      


      
      <input type="password" id="repassword" class="form-control"  placeholder="Xác nhận mật khẩu" runat="server">

      <asp:RequiredFieldValidator ID="rqRePass" runat="server" ErrorMessage="Vui lòng nhập lại mật khẩu..." ControlToValidate="repassword"></asp:RequiredFieldValidator>

       <%-- kiểm tra Mật khẩu phải lớn hơn 5 kí tự và có 1 chữ Hoa--%>
     <%-- <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password"
ErrorMessage="Mật khẩu phải lớn hơn 5 kí tự và có 1 chữ Hoa"
ValidationExpression="^(?=.*[A-Z]).{6,}$"></asp:RegularExpressionValidator>--%>

      <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password"
    ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất một chữ hoa và một ký tự đặc biệt."
    ValidationExpression="^(?=.*[A-Z])(?=.*\W)(?!.*\s).{6,}$" />


      <asp:CompareValidator ID="cmpRePass" runat="server" ErrorMessage="Mật khẩu nhập lại không khớp" ControlToCompare="password" ControlToValidate="repassword"></asp:CompareValidator>

      <input type="submit" class="btn btn-success btn-block" onserverclick="submitSignup" value="Đăng ký" runat="server">

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a id="hadAccount" class="underlineHover" href="Login.aspx">Bạn đã có tài khoản?</a>
    </div>

  </div>
</div>
        </div>
</asp:Content>
