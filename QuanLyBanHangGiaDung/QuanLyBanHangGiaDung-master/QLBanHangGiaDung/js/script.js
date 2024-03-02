var txtEmail = document.getElementById("inputEmail3");
var txtPass = document.getElementById("inputPassword3");
var txtPassR = document.getElementById("inputPasswordR");
var btnSignUp = document.getElementById("btnSignUp");

txtPassR.addEventListener("change", () => {
    if (txtPass.value == txtPassR.value) {
        btnSignUp.classList.remove("non-active");
    }
    else {
        alert("Mật khẩu không khớp!!!");
    }
});

btnSignUp.addEventListener("mousemove", () => {
    if (txtEmail.value == "") {
        alert("Bạn chưa nhập Email.");
    } else if (txtPass.value == "") {
        alert("Bạn chưa nhập mật khẩu.");
    } else if (txtPassR.value == "") {
        alert("Bạn chưa nhập lại mật khẩu.");
    }
});