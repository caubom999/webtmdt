function addCart(id) {
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
                alert("Bạn đã thêm thàng công vào giỏ hàng");
            } else {
                alert("Lỗi");
            }

        }
    };
    var url = "TrangChu.aspx";
    var params = "idproduct=" + id;
    console.log(params);
    xhttp.open('POST', url, true);
    xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhttp.send(params);
}