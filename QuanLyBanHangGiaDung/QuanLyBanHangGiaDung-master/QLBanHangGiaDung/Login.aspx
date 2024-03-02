<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QLBanHangThietBiCongNghe.Login1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Đăng nhập</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg">
    <div id="formLogin">
    <div class="wrapper">
  <div id="formContent">
    <!-- Login Form -->
       <h1 style="color: white;margin: 20px 0px 20px 0px;">Welcome Page</h1>
        <input type="text" id="login" class="form-control" name="login" placeholder="Tên đăng nhập" runat="server">
        <input type="password" id="password" class="form-control" name="login" placeholder="Mật khẩu" runat="server">

      <asp:RequiredFieldValidator ID="rqPass" runat="server" ErrorMessage="Vui lòng nhập mật khẩu"  ControlToValidate="password" ></asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password"
ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất một chữ hoa và một ký tự đặc biệt."
ValidationExpression="^(?=.*[A-Z])(?=.*\W)(?!.*\s).{6,}$"></asp:RegularExpressionValidator>
     

        <input type="submit" class="btn btn-success btn-block" value="Đăng nhập" runat="server" onserverclick="submitLogin">
    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a id="noAccount" class="underlineHover" href="Signup.aspx">Bạn chưa có tài khoản?</a>
    </div>

  </div>
</div>
        </div>
    </div>
    </asp:Content>
