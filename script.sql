USE [teste]
GO
CREATE DATABASE [teste]
use [teste]
/****** Object:  StoredProcedure [dbo].[checkCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[updateInfo]
@hoten nvarchar(255),
@diachi nvarchar(255),
@sdt char(12),
@ngaysinh date,
@matk int
as 
begin
	Update [dbo].[tblCustomers] set [sName] = @hoten, [sAddress]= @diachi,[sPhoneNumber]=@sdt,[dDoB]=@ngaysinh where PK_iCustomerID = @matk
end
GO

CREATE TABLE dbo.LockedAccounts (
    UserID INT PRIMARY KEY,
    FailedLoginAttempts INT NOT NULL DEFAULT 0,
    LockoutExpiration DATETIME NULL
);

create proc [dbo].[checkCart]
@idcart int, @check int
as
begin
	update tblCarts set bCheck = @check where PK_iCartID = @idcart and bStatus = 1
end

GO
/****** Object:  StoredProcedure [dbo].[checkLogin]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[checkLogin]
@tendangnhap varchar(255), @password char(12)
as
begin
	DECLARE @idUser int
	select @idUser = PK_iUserID FROM tblUsers WHERE sUserName = @tendangnhap and sPassword = @password and bStatus = 1
	select * FROM tblCustomers WHERE FK_iUserID = @idUser
end

GO
select * FROM  tblUsers
/****** Object:  StoredProcedure [dbo].[chitietdonhang]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
select * from tblBills
select * from tblDetailBills 


--CREATE proc [dbo].[chitietdonhang]
--@makh int
--as
--begin
--	select [PK_iBillID],[dDateCreated],sum(iAmount) as Soluong,iProductPayment from tblBills inner join tblDetailBills 
--	on tblBills.PK_iBillID = tblDetailBills.FK_iBillID  where [FK_iCustomerID] = @makh
--	group by PK_iBillID, [dDateCreated], iProductPayment
--end

--GO
--CREATE PROCEDURE [dbo].[chitietdonhang1]
--@makh INT
--AS
--BEGIN
--    SELECT 
--        [PK_iBillID],
--        [dDateCreated],
--        SUM(iAmount) AS Soluong,
--        iProductPayment
--    FROM 
--        tblBills
--    INNER JOIN 
--        tblDetailBills ON tblBills.PK_iBillID = tblDetailBills.FK_iBillID
--    WHERE 
--        [FK_iCustomerID] = @makh
--    GROUP BY 
--        PK_iBillID, [dDateCreated], iProductPayment
--    ORDER BY 
--        [dDateCreated] DESC;
--END
--GO
CREATE PROCEDURE [dbo].[chitietdonhang2]
@makh INT
AS
BEGIN
    SELECT 
        [PK_iBillID],
        [dDateCreated],
        SUM(iAmount) AS Soluong,
        iProductPayment
    FROM 
        tblBills
    INNER JOIN 
        tblDetailBills ON tblBills.PK_iBillID = tblDetailBills.FK_iBillID
    WHERE 
        [FK_iCustomerID] = @makh
    GROUP BY 
        PK_iBillID, [dDateCreated], iProductPayment
    ORDER BY 
        [dDateCreated] DESC;
END
GO





/****** Object:  StoredProcedure [dbo].[chitiethoadon]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
select * from tblDetailBills
--CREATE proc [dbo].[chitiethoadon]

--as
--begin
--	select tblDetailBills.*, tblProducts.* from tblDetailBills inner join tblProducts on tblProducts.[PK_iProductID] = tblDetailBills.[FK_iProductID]  

--end
--GO
--CREATE PROCEDURE [dbo].[chitiethoadonnew]
--AS
--BEGIN
--    SELECT 
--        tblDetailBills.*, 
--        tblProducts.*, 
--        tblBills.*
--    FROM 
--        tblDetailBills
--    INNER JOIN 
--        tblProducts ON tblProducts.[PK_iProductID] = tblDetailBills.[FK_iProductID]
--    INNER JOIN
--        tblBills ON tblBills.[PK_iBillID] = tblDetailBills.[FK_iBillID]
--END
--GO
CREATE PROCEDURE [dbo].[chitiethoadonnew1]
AS
BEGIN
    SELECT 
        tblDetailBills.*, 
        tblProducts.*, 
        tblBills.*
    FROM 
        tblDetailBills
    INNER JOIN 
        tblProducts ON tblProducts.[PK_iProductID] = tblDetailBills.[FK_iProductID]
    INNER JOIN
        tblBills ON tblBills.[PK_iBillID] = tblDetailBills.[FK_iBillID]
    ORDER BY
        tblBills.[dDateCreated] DESC; 
END
GO

create proc [dbo].[huydonhang]
@idhuy int 
as
begin
	delete from tblBills where PK_iBillID = @idhuy
end

GO
create proc [dbo].[huydonhang1]
@idhuy int 
as
begin
	delete from tblBills where PK_iBillID = @idhuy
end

GO

select * from tblBills

CREATE proc [dbo].[chitiethoadonfull]

as
begin
	select * from tblBills join tblDetailBills on tblBills.PK_iBillID = tblDetailBills.FK_iBillID 
							join tblProducts on tblDetailBills.FK_iBillID = tblProducts.PK_iProductID

end
GO
select * from tblBills
/****** Object:  StoredProcedure [dbo].[createBill]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[createBill]
@iProductPayment int,  @idCustomer int
as
begin
	DECLARE @idbill int
	DECLARE @tableid table (id int)
	insert into tblDetailBills(FK_iProductID, iAmount) select FK_iProductID, iAmount from tblCarts where FK_iCustomerID = @idCustomer and bCheck = 1 and bStatus = 1
	INSERT INTO tblBills(dDateCreated, iProductPayment, FK_iCustomerID) OUTPUT inserted.PK_iBillID into @tableid VALUES(getdate(), @iProductPayment, @idCustomer)
	SELECT @idbill = id from @tableid
	update tblDetailBills set FK_iBillID = @idbill where FK_iBillID is null
	update tblCarts set bStatus = 0 where FK_iCustomerID = @idCustomer and bCheck = 1 and bStatus = 1
end
GO
/****** Object:  StoredProcedure [dbo].[createCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[createCart]
@idproduct int, @idcustomer int, @amount int
as
begin
	if exists (Select * From tblCarts Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and bStatus = 1)
		update tblCarts set iAmount = iAmount + @amount
		Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1
	else
		insert into tblCarts(iAmount, dDate, FK_iProductID, FK_iCustomerID, bStatus, bCheck) values (@amount, getdate(), @idproduct, @idcustomer, 1, 0)
end

GO
/****** Object:  StoredProcedure [dbo].[createFavourites]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[createFavourites]
@idUser int, @idProduct int 
as
begin
	insert into tblFavourites(FK_iProductID, FK_iCustomerID) values (@idProduct, @idUser)
end

GO
/****** Object:  StoredProcedure [dbo].[createFeedback]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[createFeedback]
@evaluate float, @content nvarchar(200), @idproduct int, @idcustommer int 
as
begin
	insert into tblFeedbacks(fEvaluate, sContent, dDate, FK_iProductID, FK_iCustomerID) values (@evaluate, @content, getdate(), @idproduct, @idcustommer)
end
GO
/****** Object:  StoredProcedure [dbo].[createProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[createProduct]
@name nvarchar(100), @unit nvarchar(50), @price float, @type int, @description nvarchar(200), @promotion float, @image varchar(500) 
as
begin
	insert into tblProducts(sName, sUnit, iPrice, FK_iType, sDescription, fEvaluate, fPromotion, sImage, bStatus) values (@name, @unit, @price, @type, @description, 5, @promotion, @image, 1)
end
GO
/****** Object:  StoredProcedure [dbo].[createUser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[createUser]
@ten varchar(255), @sdt char(12), @tendangnhap varchar(255), @password char(12), @permission int 
as
begin
	insert into tblUsers(sUserName, sPassword, bStatus, FK_sPermissionID) values (@tendangnhap, @password, 1, @permission)

	DECLARE @idUser int

	SELECT @idUser = PK_iUserID FROM tblUsers WHERE sUserName = @tendangnhap

	insert into tblCustomers(sName,sPhoneNumber, bStatus, FK_iUserID) values (@ten, @sdt, 1, @idUser)
end

GO
/****** Object:  StoredProcedure [dbo].[deleteCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteCart]
@idcart int 
as
begin
	delete from tblCarts where PK_iCartID = @idcart
end

GO

select * from tblCarts
create proc [dbo].[deleteCart1]
@idx int 
as
begin
	delete from tblCarts where PK_iCartID = @idx
end

GO

create proc [dbo].[huydonhangx]
@idhuy int 
as
begin
	delete from tblBills where PK_iBillID = @idhuy
end

GO

create proc [dbo].[huydonhang3]
@idbill int 
as
begin
	delete from tblBills where PK_iBillID = @idbill
end

GO
select * from tblBills
delete from tblBills where PK_iBillID = 3


/****** Object:  StoredProcedure [dbo].[deleteFavourites]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteFavourites]
@idUser int, @idProduct int 
as
begin
	delete from tblFavourites where FK_iProductID = @idProduct and FK_iCustomerID = @idUser
end

GO
/****** Object:  StoredProcedure [dbo].[deleteFeedback]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteFeedback]
@idfeddback int 
as
begin
	delete from tblFeedbacks where PK_iFeedbackID = @idfeddback
end

GO
/****** Object:  StoredProcedure [dbo].[deleteProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[deleteProduct]
@idproduct int 
as
begin
	update tblProducts set bStatus = 0 where PK_iProductID = @idproduct
end

GO
/****** Object:  StoredProcedure [dbo].[deleteUser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteUser]
@idUser int
as
begin 
	update tblUsers set bStatus = 0 where PK_iUserID = @idUser
	update tblCustomers set bStatus = 0 where FK_iUserID = @idUser
end

GO
/****** Object:  StoredProcedure [dbo].[getAllFeedback]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getAllFeedback]
@maph int
AS
BEGIN
	SELECT tblFeedbacks.*, tblCustomers.sName as TenKH 
	FROM tblFeedbacks 
	inner join tblCustomers 
	on tblCustomers.PK_iCustomerID = tblFeedbacks.FK_iCustomerID
	where FK_iProductID =@maph
END;

GO
/****** Object:  StoredProcedure [dbo].[getAllProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getAllProduct]
@giatu float,
@giaden float
as
begin
	if @giatu > 0 and @giaden > 0 
		begin
			select * from tblProducts where iPrice >= @giatu and iPrice <= @giaden
		end
	else
		begin
			select * from tblProducts
		end

end

GO
select * from tblUsers
/****** Object:  StoredProcedure [dbo].[getAllUser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getAllUser]
as
begin 
	select * from [dbo].[tblUsers] inner join [dbo].[tblCustomers] on [dbo].[tblUsers].[PK_iUserID] = [dbo].[tblCustomers].[FK_iUserID];
end
GO
/****** Object:  StoredProcedure [dbo].[getCheckedProductInCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

select * from  tblCarts;
create proc [dbo].[getCheckedProductInCart]
@idcustomer int
as
begin
	select tblProducts.*, tblCarts.* from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1 and tblCarts.bCheck = 1
end

GO
/****** Object:  StoredProcedure [dbo].[getComment]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getComment]
as
begin
select [PK_iFeedbackID],[sContent],[dDate], [dbo].[tblCustomers].[sName] as ten_kh,[dbo].[tblProducts].[sName] as ten_sp from [dbo].[tblFeedbacks] inner join [dbo].[tblProducts] 
on [dbo].[tblFeedbacks].FK_iProductID = [dbo].[tblProducts].PK_iProductID inner join dbo.[tblCustomers]
on [dbo].[tblCustomers].[PK_iCustomerID] = [dbo].[tblFeedbacks].FK_iCustomerID
end

GO
/****** Object:  StoredProcedure [dbo].[getFeedback]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getFeedback]
@malsp int,@makh int,@ph nvarchar(200),@date datetime
as
begin
Insert into tblFeedbacks(FK_iProductID,FK_iCustomerID,sContent,dDate) values(@malsp,@makh,@ph,@date)
end
GO
/****** Object:  StoredProcedure [dbo].[getInfo]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getInfo]
@matk int
as
begin
	select * from [dbo].[tblUsers] inner join [dbo].[tblCustomers] on [dbo].[tblUsers].[PK_iUserID] = [dbo].[tblCustomers].[FK_iUserID] where [dbo].[tblCustomers].[PK_iCustomerID] = @matk;
end

GO
/****** Object:  StoredProcedure [dbo].[getListProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getListProduct]
as 
begin
	select * from tblTypeProducts
end

GO
/****** Object:  StoredProcedure [dbo].[getProductByIDType]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getProductByIDType]
@giatu float,
@giaden float,
@ma int
as
begin 
	if @giatu > 0 and @giaden > 0 
		begin
			select * from [dbo].[tblTypeProducts] inner join [dbo].[tblProducts] on [dbo].[tblTypeProducts].PK_iType = [dbo].[tblProducts].FK_iType where FK_iType = @ma and iPrice >= @giatu and iPrice <= @giaden 
		end
	else
		begin
			select * from [dbo].[tblTypeProducts] inner join [dbo].[tblProducts] on [dbo].[tblTypeProducts].PK_iType = [dbo].[tblProducts].FK_iType where FK_iType = @ma
		end
end

GO
/****** Object:  StoredProcedure [dbo].[getProductByPrice]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductByPrice]
@giatu float,
@giaden float
as
begin 
	select * from tblProducts where iPrice > @giatu and iPrice < @giaden
end

GO
/****** Object:  StoredProcedure [dbo].[getProductHot]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductHot]
as
begin 
 select TOP 8 * from tblProducts where FK_iType = 2
end

GO
create proc [dbo].[getProductHot12]
as
begin 
 select TOP 8 * from tblProducts where FK_iType = 12
end

GO
/****** Object:  StoredProcedure [dbo].[getProductID]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[getProductID]
@masp int
as
begin
	select * from tblProducts where PK_iProductID = @masp
end

GO
/****** Object:  StoredProcedure [dbo].[getProductInCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductInCart]
@idcustomer int
as
begin
	select tblProducts.*, tblCarts.* from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1
end
GO
/****** Object:  StoredProcedure [dbo].[getProductNew]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getProductNew]
as
begin 
 select TOP 4 * from tblProducts where FK_iType = 6
end

GO
CREATE proc [dbo].[getProductNew1]
as
begin 
 select TOP 4 * from tblProducts where FK_iType = 6
end

GO
CREATE proc [dbo].[getProductbc]
as
begin 
 select TOP 4 * from tblProducts where FK_iType = 11
end

GO
select * from tblProducts;
CREATE proc [dbo].[getProductbcall]
as
begin 
 select TOP 12 * from tblProducts where FK_iType = 11
end

GO
/****** Object:  StoredProcedure [dbo].[getProductPromo]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductPromo]
as
begin 
 select TOP 2 * from tblProducts where FK_iType = 3 
end

GO
/****** Object:  StoredProcedure [dbo].[getProductRelation]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductRelation]
@maloai int
as
begin
	select TOP 3 * from tblProducts where FK_iType = @maloai 
end

GO
/****** Object:  StoredProcedure [dbo].[getProductSearch]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getProductSearch]
@keySearch nvarchar(MAX)
as
begin
	select * from tblProducts where sName like '%'+@keySearch+'%'
end

GO
/****** Object:  StoredProcedure [dbo].[getUser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getUser]
@idUser int
as
begin 
	select * FROM tblUsers WHERE PK_iUserID = @idUser
end

GO
 delete from tblUsers where PK_iUserID = 9
/****** Object:  StoredProcedure [dbo].[lockuser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[lockuser]
@matk int
as 
begin
	Update [dbo].[tblUsers] set [bStatus] = 0 where PK_iUserID =  @matk
end
GO
create proc [dbo].[lockuser1]
@mahd int
as 
begin
	Update [dbo].[tblBills] set [status] = 0 where PK_iBillID =  @mahd
end
GO

/****** Object:  StoredProcedure [dbo].[selectBills]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[selectBills]
as
begin
	select * from tblBills
end

GO
/****** Object:  StoredProcedure [dbo].[selectDetailBills]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[selectDetailBills]
@idbill int
as
begin
	select * from tblDetailBills where FK_iBillID = @idbill
end

GO
/****** Object:  StoredProcedure [dbo].[selectDetailBillsProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[selectDetailBillsProduct]
@idbill int
as
begin
	select tblDetailBills.*, tblProducts.* from tblDetailBills inner join tblProducts on tblProducts.[PK_iProductID] = tblDetailBills.[FK_iProductID]  
	where FK_iBillID = @idbill
end
GO
/****** Object:  StoredProcedure [dbo].[unlockuser]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[unlockuser]
@matk int
as 
begin
	Update [dbo].[tblUsers] set [bStatus] = 1 where PK_iUserID =  @matk
end

GO




select * from tblUsers
select * from tblBills
/****** Object:  StoredProcedure [dbo].[updateCart]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateCart]
@idcart int, @amount int
as
begin
	update tblCarts set iAmount = @amount where PK_iCartID = @idcart
end

GO
/****** Object:  StoredProcedure [dbo].[updateProduct]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updateProduct]
@idproduct int, @name nvarchar(100), @unit nvarchar(50), @price float, @type int, @description nvarchar(200), @status int, @promotion float, @image varchar(500) 
as
begin
	update tblProducts set sName = @name, sUnit = @unit, iPrice = @price, FK_iType = @type, sDescription = @description, fPromotion = @promotion, sImage = @image, bStatus = @status where PK_iProductID = @idproduct
end
GO
/****** Object:  StoredProcedure [dbo].[XoaPhanHoi]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[XoaPhanHoi]
@ma int
as
begin
	delete from [dbo].[tblFeedbacks] where [PK_iFeedbackID] = @ma
end
GO
/****** Object:  Table [dbo].[tblBills]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBills](
	[PK_iBillID] [int] IDENTITY(1,1) NOT NULL,
	[dDateCreated] [date] NULL,
	[iProductPayment] [int] NULL,
	[iShippingPayment] [int] NULL,
	[FK_iCustomerID] [int] NULL,
 CONSTRAINT [PK__tblBills__606A335340EAFB25] PRIMARY KEY CLUSTERED 
(
	[PK_iBillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[tblBills]
ADD [status] INT NULL;

ALTER TABLE tblDetailBills
ADD [status] BIT NOT NULL DEFAULT 0;

UPDATE tblDetailBills
SET [status] = ISNULL([status], 0);
ALTER TABLE tblDetailBills
ALTER COLUMN [status] BIT NOT NULL;

ALTER TABLE [dbo].[tblBills]
DROP COLUMN [status];

GO
select * from tblDetailBills
create proc [dbo].[unlockuser2]
@mahd int
as 
begin
	Update [dbo].[tblDetailBills] set [status] = 1 where FK_iBillID =  @mahd
end

GO
create proc [dbo].[lockuser2]
@mahd int
as 
begin
	Update [dbo].[tblDetailBills] set [status] = 0 where FK_iBillID =  @mahd
end
GO


CREATE VIEW [dbo].[vwBillStatus]
AS
SELECT
    [PK_iBillID],
    [status]
FROM
    [dbo].[tblBills];

	SELECT [status] FROM [dbo].[vwBillStatus] WHERE [PK_iBillID] = 2;
/****** Object:  Table [dbo].[tblCarts]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCarts](
	[PK_iCartID] [int] IDENTITY(1,1) NOT NULL,
	[iAmount] [int] NOT NULL,
	[dDate] [date] NOT NULL,
	[FK_iProductID] [int] NOT NULL,
	[FK_iCustomerID] [int] NOT NULL,
	[bStatus] [bit] NOT NULL,
	[bCheck] [bit] NULL,
 CONSTRAINT [PK__tblCarts__CAB94E6BDC63F0FC] PRIMARY KEY CLUSTERED 
(
	[PK_iCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCustomers]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCustomers](
	[PK_iCustomerID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sAddress] [nvarchar](255) NULL,
	[sPhoneNumber] [char](12) NULL,
	[dDoB] [date] NULL,
	[bStatus] [bit] NOT NULL,
	[FK_iUserID] [int] NOT NULL,
 CONSTRAINT [PK__tblCusto__23D4F64125BCFE10] PRIMARY KEY CLUSTERED 
(
	[PK_iCustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDetailBills]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDetailBills](
	[FK_iBillID] [int] NULL,
	[FK_iProductID] [int] NULL,
	[iAmount] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[PK_iEmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](100) NOT NULL,
	[sAddress] [nvarchar](100) NULL,
	[sPhoneNumber] [char](12) NULL,
	[dDoB] [date] NULL,
	[iSalary] [int] NOT NULL,
	[bStatus] [bit] NOT NULL,
	[FK_iUserID] [int] NOT NULL,
 CONSTRAINT [PK__tblEmplo__214C055861AD2F4F] PRIMARY KEY CLUSTERED 
(
	[PK_iEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFavourites]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFavourites](
	[FK_iProductID] [int] NOT NULL,
	[FK_iCustomerID] [int] NOT NULL,
 CONSTRAINT [PK__tblFavou__5E26CF9DEB9FB667] PRIMARY KEY CLUSTERED 
(
	[FK_iProductID] ASC,
	[FK_iCustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFeedbacks]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedbacks](
	[PK_iFeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[fEvaluate] [float] NULL,
	[sContent] [nvarchar](200) NULL,
	[dDate] [datetime] NOT NULL,
	[FK_iProductID] [int] NOT NULL,
	[FK_iCustomerID] [int] NOT NULL,
 CONSTRAINT [PK__tblFeedb__4AD17B03C4AAD6B3] PRIMARY KEY CLUSTERED 
(
	[PK_iFeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPermissions]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPermissions](
	[PK_sPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[sPermissionName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__tblPermi__72927D1B6ABF67B9] PRIMARY KEY CLUSTERED 
(
	[PK_sPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProducts](
	[PK_iProductID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](100) NOT NULL,
	[sUnit] [nvarchar](50) NOT NULL,
	[iPrice] [float] NOT NULL,
	[FK_iType] [int] NOT NULL,
	[sDescription] [nvarchar](200) NULL,
	[bStatus] [bit] NOT NULL,
	[fEvaluate] [float] NULL,
	[fPromotion] [float] NULL,
	[sImage] [varchar](500) NULL,
 CONSTRAINT [PK__tblProdu__2980F3B8458C91EC] PRIMARY KEY CLUSTERED 
(
	[PK_iProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTypeProducts]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTypeProducts](
	[PK_iType] [int] IDENTITY(1,1) NOT NULL,
	[sTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblTypeProducts] PRIMARY KEY CLUSTERED 
(
	[PK_iType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 09/25/2021 9:08:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUsers](
	[PK_iUserID] [int] IDENTITY(1,1) NOT NULL,
	[sUserName] [varchar](255) NOT NULL,
	[sPassword] [varchar](255) NOT NULL,
	[bStatus] [bit] NOT NULL,
	[FK_sPermissionID] [int] NOT NULL,
 CONSTRAINT [PK__tblUsers__57DAF7B8ADAD74AC] PRIMARY KEY CLUSTERED 
(
	[PK_iUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

select * from tblBills;
select * from tblCarts;
delete tblCarts where PK_iCartID = 1;
delete tblCarts where PK_iCartID = 20;
delete tblCarts where PK_iCartID = 23;
delete tblCarts where PK_iCartID = 3;
delete tblCarts where PK_iCartID = 14;
delete tblCarts where PK_iCartID = 15;
delete tblCarts where PK_iCartID = 16;
delete tblCarts where PK_iCartID = 17;
delete tblCarts where PK_iCartID = 18;
delete tblCarts where PK_iCartID = 19;
delete tblCarts where PK_iCartID = 10;
delete tblCarts where PK_iCartID = 11;
delete tblCarts where PK_iCartID = 12;
delete tblCarts where PK_iCartID = 13;

delete tblCarts where PK_iCartID = 1;
SET IDENTITY_INSERT [dbo].[tblCarts] ON 
select * from tblCarts;
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (1, 2, CAST(0xAE410B00 AS Date), 3, 3, 1, 0)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (2, 2, CAST(0xAE410B00 AS Date), 3, 3, 1, 0)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (4, 3, CAST(0x09430B00 AS Date), 3, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (5, 1, CAST(0x09430B00 AS Date), 9, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (7, 1, CAST(0x09430B00 AS Date), 5, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (8, 1, CAST(0x09430B00 AS Date), 13, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (9, 1, CAST(0x09430B00 AS Date), 4, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (10, 1, CAST(0x09430B00 AS Date), 4, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (11, 1, CAST(0x09430B00 AS Date), 4, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (12, 1, CAST(0x09430B00 AS Date), 5, 2, 0, 1)
INSERT [dbo].[tblCarts] ([PK_iCartID], [iAmount], [dDate], [FK_iProductID], [FK_iCustomerID], [bStatus], [bCheck]) VALUES (13, 1, CAST(0x09430B00 AS Date), 4, 2, 0, 1)
SET IDENTITY_INSERT [dbo].[tblCarts] OFF



select * from tblUsers;
select * from tblPermissions;
select * from tblEmployees;
delete tblUsers where PK_iUserID=1;
delete tblUsers where PK_iUserID=2;
delete tblUsers where PK_iUserID=3;
delete tblUsers where PK_iUserID=4;
delete tblUsers where PK_iUserID=5;
delete tblUsers where PK_iUserID=6;
delete tblUsers where PK_iUserID=7;
delete tblUsers where PK_iUserID=8;
delete tblUsers where PK_iUserID=9;
delete tblUsers where PK_iUserID=10;
delete tblUsers where PK_iUserID=11;
delete tblUsers where PK_iUserID=12;
delete tblUsers where PK_iUserID=13;
delete tblUsers where PK_iUserID=14;
SET IDENTITY_INSERT [dbo].[tblUsers] ON 
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [bStatus], [FK_sPermissionID]) VALUES (1, N'thanhjhinn9999', N'Vegetables123#', 1, 0)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [bStatus], [FK_sPermissionID]) VALUES (2, N'vanthanhcan3', N'Vegetables123#', 1, 0)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [bStatus], [FK_sPermissionID]) VALUES (3, N'thanhsmile', N'Vegetables123#', 1, 1)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [bStatus], [FK_sPermissionID]) VALUES (4, N'trancung', N'Vegetables123#   ', 1, 1)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF

select * from tblCustomers;
delete tblCustomers where PK_iCustomerID = 1;
delete tblCustomers where PK_iCustomerID = 1;
delete tblCustomers where PK_iCustomerID = 2;
delete tblCustomers where PK_iCustomerID = 3;
delete tblCustomers where PK_iCustomerID = 4;
delete tblCustomers where PK_iCustomerID = 5;
delete tblCustomers where PK_iCustomerID = 6;
delete tblCustomers where PK_iCustomerID = 7;
delete tblCustomers where PK_iCustomerID = 8;
delete tblCustomers where PK_iCustomerID = 9;


SET IDENTITY_INSERT [dbo].[tblCustomers] ON 
INSERT [dbo].[tblCustomers] ([PK_iCustomerID], [sName], [sAddress], [sPhoneNumber], [dDoB], [bStatus], [FK_iUserID]) VALUES (2, N'Tran Thanh', N'LangHa', N'0979326231  ', NULL, 1, 1)
INSERT [dbo].[tblCustomers] ([PK_iCustomerID], [sName], [sAddress], [sPhoneNumber], [dDoB], [bStatus], [FK_iUserID]) VALUES (1, N'Van Thanh', N'QN', N'0979326231  ', NULL, 1, 2)
INSERT [dbo].[tblCustomers] ([PK_iCustomerID], [sName], [sAddress], [sPhoneNumber], [dDoB], [bStatus], [FK_iUserID]) VALUES (3, N'ThanhSmile', N'TayHo', N'0979326231  ', NULL, 1, 3)
INSERT [dbo].[tblCustomers] ([PK_iCustomerID], [sName], [sAddress], [sPhoneNumber], [dDoB], [bStatus], [FK_iUserID]) VALUES (4, N'Tran Cung', N'LinhDam', N'0979326231  ', NULL, 1, 4)
SET IDENTITY_INSERT [dbo].[tblCustomers] OFF

select * from tblCarts;
select * from tblDetailBills;
select * from tblBills; 
select * from tblProducts;
select * from tblCustomers;

select * from tblBills; 
SET IDENTITY_INSERT [dbo].[tblBills] ON 
delete tblBills where PK_iBillID =43;
delete tblBills where PK_iBillID =21;
delete tblBills where PK_iBillID =3;
delete tblBills where PK_iBillID =14;
delete tblBills where PK_iBillID =15;
delete tblBills where PK_iBillID =16;
delete tblBills where PK_iBillID =17;
delete tblBills where PK_iBillID =18;
delete tblBills where PK_iBillID =19;
delete tblBills where PK_iBillID =10;
delete tblBills where PK_iBillID =11;
delete tblBills where PK_iBillID =12;
delete tblBills where PK_iBillID =13;
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (1, CAST(0x09430B00 AS Date), 0, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (2, CAST(0x09430B00 AS Date), 0, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (3, CAST(0x09430B00 AS Date), 1095000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (4, CAST(0x09430B00 AS Date), 558000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (8, CAST(0x09430B00 AS Date), 160000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (9, CAST(0x09430B00 AS Date), 160000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (10, CAST(0x09430B00 AS Date), 160000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (11, CAST(0x09430B00 AS Date), 160000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (12, CAST(0x09430B00 AS Date), 160000, NULL, 2)
INSERT [dbo].[tblBills] ([PK_iBillID], [dDateCreated], [iProductPayment], [iShippingPayment], [FK_iCustomerID]) VALUES (13, CAST(0x09430B00 AS Date), 445000, NULL, 2)
SET IDENTITY_INSERT [dbo].[tblBills] OFF

select * from tblDetailBills;
delete tblDetailBills where FK_iBillID =13;
delete tblDetailBills where FK_iBillID =11;
delete tblDetailBills where FK_iBillID =12;
delete tblDetailBills where FK_iBillID =14;
delete tblDetailBills where FK_iBillID =15;
delete tblDetailBills where FK_iBillID =16;
delete tblDetailBills where FK_iBillID =17;
delete tblDetailBills where FK_iBillID =18;
delete tblDetailBills where FK_iBillID =19;
delete tblDetailBills where FK_iBillID =21;

INSERT [dbo].[tblDetailBills] ([FK_iBillID], [FK_iProductID], [iAmount]) VALUES (1, 4, 1)
INSERT [dbo].[tblDetailBills] ([FK_iBillID], [FK_iProductID], [iAmount]) VALUES (2, 5, 1)
INSERT [dbo].[tblDetailBills] ([FK_iBillID], [FK_iProductID], [iAmount]) VALUES (3, 4, 1)
SET IDENTITY_INSERT [dbo].[tblDetailBills] OFF

SET IDENTITY_INSERT [dbo].[tblFeedbacks] ON 
INSERT [dbo].[tblFeedbacks] ([PK_iFeedbackID], [fEvaluate], [sContent], [dDate], [FK_iProductID], [FK_iCustomerID]) VALUES (1, NULL, N'ok', CAST(0x0000ADAE000487F5 AS DateTime), 4, 2)
INSERT [dbo].[tblFeedbacks] ([PK_iFeedbackID], [fEvaluate], [sContent], [dDate], [FK_iProductID], [FK_iCustomerID]) VALUES (4, NULL, N'San Pham Tot', CAST(0x0000ADAE00048A42 AS DateTime), 4, 2)
INSERT [dbo].[tblFeedbacks] ([PK_iFeedbackID], [fEvaluate], [sContent], [dDate], [FK_iProductID], [FK_iCustomerID]) VALUES (6, NULL, N'Khong Dat', CAST(0x0000ADAE00048AD2 AS DateTime), 4, 2)
SET IDENTITY_INSERT [dbo].[tblFeedbacks] OFF

SET IDENTITY_INSERT [dbo].[tblPermissions] ON 

select * from tblPermissions;
INSERT [dbo].[tblPermissions] ([PK_sPermissionID], [sPermissionName]) VALUES (0, N'admin')
INSERT [dbo].[tblPermissions] ([PK_sPermissionID], [sPermissionName]) VALUES (1, N'user')
INSERT [dbo].[tblPermissions] ([PK_sPermissionID], [sPermissionName]) VALUES (2, N'user')




CREATE PROCEDURE xapxepgia
AS
BEGIN
    SELECT * FROM tblProducts
    ORDER BY iPrice ASC;
END;




SET IDENTITY_INSERT [dbo].[tblPermissions] OFF


delete tblProducts where PK_iProductID = 1;
delete tblProducts where PK_iProductID = 2;
delete tblProducts where PK_iProductID = 3;
delete tblProducts where PK_iProductID = 4;
delete tblProducts where PK_iProductID = 5;
delete tblProducts where PK_iProductID = 6;
delete tblProducts where PK_iProductID = 7;
delete tblProducts where PK_iProductID = 8;
delete tblProducts where PK_iProductID = 9;
delete tblProducts where PK_iProductID = 10;
delete tblProducts where PK_iProductID = 11;
delete tblProducts where PK_iProductID = 12;
delete tblProducts where PK_iProductID = 13;
delete tblProducts where PK_iProductID = 14;
delete tblProducts where PK_iProductID = 15;
delete tblProducts where PK_iProductID = 16;
delete tblProducts where PK_iProductID = 17;
delete tblProducts where PK_iProductID = 18;
delete tblProducts where PK_iProductID = 19;
delete tblProducts where PK_iProductID = 20;
delete tblProducts where PK_iProductID = 21;
delete tblProducts where PK_iProductID = 21;
delete tblProducts where PK_iProductID = 23;
delete tblProducts where PK_iProductID = 24;
delete tblProducts where PK_iProductID = 25;
delete tblProducts where PK_iProductID = 26;
delete tblProducts where PK_iProductID = 27;
delete tblProducts where PK_iProductID = 28;

delete tblProducts where PK_iProductID = 45;
delete tblProducts where PK_iProductID = 46;
delete tblProducts where PK_iProductID = 47;
delete tblProducts where PK_iProductID = 48;
delete tblProducts where PK_iProductID = 49;
delete tblProducts where PK_iProductID = 50;
delete tblProducts where PK_iProductID = 51;
delete tblProducts where PK_iProductID = 52;
delete tblProducts where PK_iProductID = 53;
delete tblProducts where PK_iProductID = 54;
delete tblProducts where PK_iProductID = 55;
delete tblProducts where PK_iProductID = 56;
delete tblProducts where PK_iProductID = 57;
delete tblProducts where PK_iProductID = 58;
delete tblProducts where PK_iProductID = 59;
delete tblProducts where PK_iProductID = 60;
delete tblProducts where PK_iProductID = 61;
delete tblProducts where PK_iProductID = 62;
delete tblProducts where PK_iProductID = 63;
delete tblProducts where PK_iProductID = 64;


SET IDENTITY_INSERT [dbo].[tblProducts] ON 
Insert into [dbo].[tblProducts]([PK_iProductID], [sName], [sUnit], [iPrice], [FK_iType], [sDescription], [bStatus], [fEvaluate], [fPromotion], [sImage]) 
values
(1, N'IP 11', N'chiếc', 12000000, 1, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 64GB', 1, NULL, 50, N'/ip11pro.jpg'),
(2, N'IP 11 PRO', N'chiếc', 14000000, 2, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 128GB.', 1, NULL, 10, N'/ip11pro1.jpg'),
(3, N'IP 14 PRO', N'chiếc', 22540000, 4, N'Bảo hành: 10 tháng chính hãng - Giá sản phẩm mới: 27.990.000₫ - Tiết kiệm: 5.450.000₫ - Có tại: 54-56 đường số 7, P. Bình Trị Đông B, Q. Bình Tân, TP. HCM (Khu Tên Lửa - Ngã 4 đường số 7 và số 6).', 1, NULL, 0, N'/ip14pro.jfif'),
(4, N'IP 14 PRO Max', N'chiếc', 32000000, 4, N'6.7 inch, Super Retina XDR, 2796 x 1290 Pixels - 48.0 MP + 12.0 MP + 12.0 MP - 12.0 MP - Apple A16 Bionic - 128 GB', 1, NULL, 10, N'/ip14promax.jpg'),
(5, N'IP 14 PRO', N'chiếc', 28000000, 4, N'Màn hình: OLED6.1"Super Retina XDR Hệ điều hành:iOS 16 Camera sau: Chính 48 MP & Phụ 12 MP, 12 MP Camera trước: 12 MP Chip:Apple A16 Bionic - RAM:6 GB - Dung lượng lưu trữ: 128 GB ', 1, NULL, 10, N'/ip14pro01.jpg'),
(6, N'IP 14 64GB', N'chiếc', 15500000, 3, N'Thương hiệu:Apple Xuất xứ:Trung Quốc Thời gian bảo hành (tháng):12 Thời điểm ra mắt:09/2022 Hướng dẫn bảo quản:Để nơi khô ráo, nhẹ tay, dễ vỡ Bộ nhớ trong 64 GB ', 1, NULL, 30, N'/ip14thuong.jpg'),
(7, N'IP 14 128GB ', N'chiếc', 19999999, 4, N'6.7 inch, Super Retina XDR, 2796 x 1290 Pixels - 48.0 MP + 12.0 MP + 12.0 MP - 12.0 MP - Apple A16 Bionic - 128 GB Dung lượng pin	20 Giờ', 1, NULL, 10, N'/ip14thuong01.jpeg'),
(8, N'SAMSUNG A73 Đen', N'chiếc', 9100500, 5, N'Màn hình: Super AMOLED+, 120Hz, 800 nits,Hệ điều hành:Android 12, One UI 4.1 Được lên Android 13, One UI 5 Camera sau: 108 MP, f/1.8, (góc rộng), Dung lượng pin Li-Po 5000 mAhSạc nhanh 25W', 1, NULL, 10, N'/ssa73den.jfif'),
(9, N'SAMSUNG A73 Trắng', N'chiếc', 10100500, 5, N'Màn hình: Super AMOLED+ Hệ điều hành:Android 12, One UI 4.1 Được lên Android 13, One UI 5 Camera sau: 108 MP, f/1.8, (góc rộng), Dung lượng pin Li-Po 5000 mAhSạc nhanh 25W', 1, NULL, 65, N'/ssa73trang.jpg'),
(10, N'SAMSUNG A73 Xanh', N'chiếc', 8900999, 5, N'Màn hình: Super AMOLED+, 120Hz, 800 nits, tỷ lệ 20:9 6.7 inches, Full HD+ (1080 x 2400 pixels) Corning Gorilla Glass 5 Cảm biến vân tay dưới màn hình', 1, NULL, 10, N'/ssa73xanh.png'),
(11, N'SAMSUNG S9', N'chiếc', 11100000, 6, N'Siêu phẩm Samsung Galaxy S9 chính thức ra mắt mang theo hàng loạt cải tiến, tính năng cao cấp như camera thay đổi khẩu độ, quay phim siêu chậm 960 fps, AR Emoji... nhanh chóng gây sốt làng công nghệ.', 1, NULL, 10, N'/sss9.jfif'),
(12, N'SAMSUNG ULTRA S22', N'chiếc', 19000000, 6, N'Đúng như các thông tin được đồn đoán trước đó, mẫu flagship mới của gả khổng lồ Hàn Quốc được ra mắt với tên gọi là Samsung Galaxy S22 Ultra với nhiều cải tiến đáng giá. ', 1, NULL, 12, N'/ssutras22.jfif'),
(13, N'SAMSUNG S23', N'chiếc', 25999000, 6, N'Siêu phẩm Samsung Thông số cấu hình Samsung Galaxy S23 Ultra có gì HOT: Chip Snapdragon 8 Gen 2, Camera 200MP Galaxy S23 Ultra là “siêu phẩm” trong số siêu phẩm của nhà Samsung ', 1, NULL, 17, N'/ssutr23.jpg'),
(14, N'SAMSUNG S23', N'chiếc', 23999000, 6, N'Siêu phẩm Samsung Thông số cấu hình Samsung Galaxy S23 Ultra có gì HOT: Chip Snapdragon 8 Gen 2, Camera 200MP Galaxy S23 Ultra là “siêu phẩm” trong số siêu phẩm của nhà Samsung ', 1, NULL, 23, N'/ssutra23.jpg'),
--tainghe
(15, N'Tai nghe chống ồn có dây Targus Mono USB A', N'chiếc',990.000, 7, N'Thương hiệu: TargusMã Sản phẩm: AEH101AP-50 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 25, N'/tainghe1.jpg'),
(16, N'Final Audio D8000 Pro Edition - Silver', N'chiếc',990000, 7, N'Thương hiệu: Final Audio Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 63, N'/tainghe2.jpg'),
(17, N'Ultrasone Meteor One', N'chiếc',6990000 , 7, N'Thương hiệu: Ultrasone Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 45, N'/tainghe3.jfif'),
(18, N'ANC Ulatrasone Isar', N'chiếc',6990000 , 7, N'Thương hiệu: Ultrasone Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/tainghe4.jfif'),
(19, N'Ultrasone Edition Eleven', N'chiếc',36900000 , 7, N'Thương hiệu: Ultrasone Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 0, N'/tainghe5.jfif'),
(20, N'Ultrasone Edition 8 EX', N'chiếc',69000000, 7, N'Thương hiệu: Ultrasone Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 0, N'/tainghe6.jfif'),
--camera
(21, N'DJI FPV Drone Combo', N'chiếc',39000000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly1.jpg'),
(22, N'DJI Mavic Mini 2', N'chiếc',9000000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly2.jpg'),
(23, N'DJI Mavic Air 2', N'chiếc',38000000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 0, N'/fly3.jpg'),
(24, N'DJI Mavic Mini', N'chiếc',7490000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 0, N'/fly4.jpg'),
(25, N'DJI Mavic 2 Enterprise', N'chiếc',17590000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 30, N'/fly5.jpg'),
(26, N'DJI Phantom 4 PRO Plus Ver 2.0', N'chiếc',47590000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 35, N'/fly6.jpg'),
(27, N'DJI Avata Explorer Combo', N'chiếc',27590000, 8, N'Thương hiệu: DJI Tốc độ tăng tốc tối đa Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 45, N'/fly7.jpg'),

(28, N'Gopro Hero 11', N'chiếc',27590000, 8, N'Kích thước 71.8 x 50.8 x 33.6 mm Kích cỡ màn hình 2.27 inch Fixed Touchscreen LCD  Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly8.jpg'),
(29, N'Insta360 GO 3', N'chiếc',10800000, 8, N' Kích thước 71.8 x 50.8 x 33.6 mm Kích cỡ màn hình 2.27 inch Fixed Touchscreen LCD  Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly9.jpg'),
(30, N'Insta360 Pro 2 Spherical VR 360 8K', N'chiếc',121900000 , 8, N' Kích thước 71.8 x 50.8 x 33.6 mm Kích cỡ màn hình 2.27 inch Fixed Touchscreen LCD  Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly10.jpg'),
(31, N'ThiEYE Safeel 3R', N'chiếc',1272000, 8, N' Kích thước 71.8 x 50.8 x 33.6 mm Kích cỡ màn hình 2.27 inch Fixed Touchscreen LCD  Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly11.jfif'),
(32, N'ThiEYE Safeel 3', N'chiếc',27590000, 8, N' Kích thước 71.8 x 50.8 x 33.6 mm Kích cỡ màn hình 2.27 inch Fixed Touchscreen LCD  Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/fly12.jfif'),
--maytinh
(33, N'GIGABYTE AERO 17', N'chiếc',39990000, 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K, ', 1, NULL, 10, N'/lap1.jpg'),
(34, N'Acer Predator Helios Neo', N'chiếc',35990000 , 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/lap2.jfif'),
(35, N'Asus ROG Strix SCAR 18 G834JY-N6039W - i9-', N'chiếc',125000000, 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/lap3.jfif'),
(36, N'Asus ROG Strix SCAR 16 G634JZ-N4029W - i9-', N'chiếc',95000000, 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/lap4.jfif'),
(37, N'ASUS GU603V i7-13620H/16GD4/512GB', N'chiếc',44990000, 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/lap5.jfif'),
(38, N'MSI Cyborg 15', N'chiếc',30490000, 9, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/lap6.jpg'),
--Thietbideotay
(39, N'Garmin Fenix 7X Pro', N'chiếc',24690500, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho1.jfif'),
(40, N'Amazfit GTR 2', N'chiếc',2840500, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho2.jpg'),
(41, N'Garmin VivoSmart 5', N'chiếc',2080500, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho3.jpg'),
(42, N'Fitbit Charge 5', N'chiếc',27590000, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho4.jfif'),
(43, N'Oaxis myFirst Fone R1s', N'chiếc',1320500, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho5.jpg'),
(44, N'Oaxis myFirst Fone R1', N'chiếc',27590000, 10, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/dongho6.jfif'),
--sp bán chạy
(45, N'iPhone 11 64GB - Xanh lá | Apple VN', N'chiếc', 12000000, 11, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 64GB', 1, NULL, 50, N'/sphot1.jpg'),
(46, N'iPhone 11 64GB - Đỏ | Apple VN', N'chiếc', 14000000, 11, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 128GB.', 1, NULL, 10, N'/sphot2.jpg'),
(47, N'iPhone 11 64GB - Đen | Apple VN', N'chiếc', 22540000, 11, N'Bảo hành: 10 tháng chính hãng - Giá sản phẩm mới: 27.990.000₫ - Tiết kiệm: 5.450.000₫ - Có tại: 54-56 đường số 7, P. Bình Trị Đông B, Q. Bình Tân, TP. HCM (Khu Tên Lửa - Ngã 4 đường số 7 và số 6).', 1, NULL, 0, N'/sphot3.jpg'),
(48, N'iPhone 11 64GB - Tím | Apple VN', N'chiếc', 22540000, 11, N'Bảo hành: 10 tháng chính hãng - Giá sản phẩm mới: 27.990.000₫ - Tiết kiệm: 5.450.000₫ - Có tại: 54-56 đường số 7, P. Bình Trị Đông B, Q. Bình Tân, TP. HCM (Khu Tên Lửa - Ngã 4 đường số 7 và số 6).', 1, NULL, 0, N'/sphot4.jpg'),
(49, N'iPhone 13 Pro Max 128GB - Xanh dương |', N'chiếc', 32000000, 11, N'6.7 inch, Super Retina XDR, 2796 x 1290 Pixels - 48.0 MP + 12.0 MP + 12.0 MP - 12.0 MP - Apple A16 Bionic - 128 GB', 1, NULL, 10, N'/sphot5.jfif'),
(50, N'iPhone 13 Pro Max 128GB - Bạc ', N'chiếc', 28000000, 11, N'Màn hình: OLED6.1"Super Retina XDR Hệ điều hành:iOS 16 Camera sau: Chính 48 MP & Phụ 12 MP, 12 MP Camera trước: 12 MP Chip:Apple A16 Bionic - RAM:6 GB - Dung lượng lưu trữ: 128 GB ', 1, NULL, 10, N'/sphot6.jfif'),
(51, N'iPhone 13 Pro Max 128GB - Gold', N'chiếc', 15500000, 11, N'Thương hiệu:Apple Xuất xứ:Trung Quốc Thời gian bảo hành (tháng):12 Thời điểm ra mắt:09/2022 Hướng dẫn bảo quản:Để nơi khô ráo, nhẹ tay, dễ vỡ Bộ nhớ trong 64 GB ', 1, NULL, 30, N'/sphot7.jfif'),
(52, N'iPhone 14 Pro Max | Apple VN', N'chiếc', 19999999, 11, N'6.7 inch, Super Retina XDR, 2796 x 1290 Pixels - 48.0 MP + 12.0 MP + 12.0 MP - 12.0 MP - Apple A16 Bionic - 128 GB Dung lượng pin	20 Giờ', 1, NULL, 10, N'/sphot8.jpg'),
(53, N'Audio Technica Solid Bass ATH-WS33X', N'chiếc', 9100500, 11, N'Màn hình: Super AMOLED+, 120Hz, 800 nits,Hệ điều hành:Android 12, One UI 4.1 Được lên Android 13, One UI 5 Camera sau: 108 MP, f/1.8, (góc rộng), Dung lượng pin Li-Po 5000 mAhSạc nhanh 25W', 1, NULL, 10, N'/sphot9.jpg'),
(54, N'AKG N90Q', N'chiếc',6990000 , 11, N'Thương hiệu: Ultrasone Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 45, N'/sphot10.jpg'),
(55, N'Sennheiser HD800s', N'chiếc',125000000, 11, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/sphot11.jpg'),
(56, N'GIGABYTE AERO 17', N'chiếc',95000000, 11, N'Thương hiệu: LenovoMã Sản phẩm: 20YN001HVN Tùy chọn sản phẩm: Xám, 14", 100% sRGB, R5-5600H, 16GB, 512GB SSD, Radeon Graphics, Windows 11, 2.2K,', 1, NULL, 10, N'/sphot12.jpg'),

--sp hot
(57, N'MSI Vector GP77', N'chiếc', 12000000, 12, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 64GB', 1, NULL, 50, N'/spnoibat1.jpg'),
(58, N'Lenovo ThinkBook 16 G4+ IAP - I5-12500H - 16GB -', N'chiếc', 14000000, 12, N'Nếu như bây giờ để lựa chọn một thiết bị có thể sử dụng ổn định và được cập nhật trong khoảng 3 năm nữa thì không có sự lựa chọn nào xuất sắc hơn chiếc iPhone 11 Pro 128GB.', 1, NULL, 10, N'/spnoibat2.jpg'),
(59, N'Razer Barracuda Quartz', N'chiếc', 22540000, 12, N'Bảo hành: 10 tháng chính hãng - Giá sản phẩm mới: 27.990.000₫ - Tiết kiệm: 5.450.000₫ - Có tại: 54-56 đường số 7, P. Bình Trị Đông B, Q. Bình Tân, TP. HCM (Khu Tên Lửa - Ngã 4 đường số 7 và số 6).', 1, NULL, 0, N'/spnoibat4.jpg'),
(60, N'Garmin Forerunner 265S', N'chiếc',2080500, 12, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/spnoibat5.jpg'),
(61, N'Garmin MARQ Aviator (Gen 2)', N'chiếc',27590000, 12, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/spnoibat6.jpg'),
(62, N'Garmin Forerunner 255', N'chiếc',1320500, 12, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/spnoibat7.jpg'),
(63, N'iPhone 13 Mini 128GB - Trắng | Apple VN', N'chiếc',27590000, 12, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/spnoibat8.jfif'),
(64, N'iPhone 13 Mini 128GB - Đỏ | Apple VN', N'chiếc',1320500, 12, N'Thương hiệu: myFirstMã Sản phẩm: KW1305SB-PE01 Bảo hành: 12 tháng. (Quy định bảo hành)', 1, NULL, 10, N'/spnoibat9.jfif')
SET IDENTITY_INSERT [dbo].[tblProducts] OFF

select * from tblTypeProducts;
select * from tblProducts;
select * from tblCustomers;
select * from tblCarts;
select * from tblFavourites;
select * from tblFeedbacks;
select * from tblDetailBills;
select * from tblBills;
drop table tblProducts;
drop table tblFavourites;
drop table tblCarts;
drop table tblFeedbacks;
drop table tblDetailBills;

delete tblTypeProducts where PK_iType=6;
delete tblTypeProducts where PK_iType=5;
delete tblTypeProducts where PK_iType=4;
delete tblTypeProducts where PK_iType=1;
delete tblTypeProducts where PK_iType=2;
delete tblTypeProducts where PK_iType=3;
SET IDENTITY_INSERT [dbo].[tblTypeProducts] ON 
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (1, N'IPHONE 11')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (2, N'IPHONE 11 PRO')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (3, N'IPHONE 14')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (4, N'IPHONE 14 PRO')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (5, N'SAMSUNG GALAXY A|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (6, N'SAMSUNG GALAXY S|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (7, N'THIẾT BỊ TAI NGHE')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (8, N'CAMERA|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (9, N'MÁY TÍNH|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (10, N'THIẾT BỊ ĐEO TAY|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (11, N'SẢN PHẨM BÁN CHẠY NHẤT|')
INSERT [dbo].[tblTypeProducts] ([PK_iType], [sTypeName]) VALUES (12, N'SẢN PHẨM NỔI BẬT|')
SET IDENTITY_INSERT [dbo].[tblTypeProducts] OFF

ALTER TABLE [dbo].[tblBills]  WITH CHECK ADD  CONSTRAINT [FK_tblBills_tblCustomers] FOREIGN KEY([FK_iCustomerID])
REFERENCES [dbo].[tblCustomers] ([PK_iCustomerID])
GO
ALTER TABLE [dbo].[tblBills] CHECK CONSTRAINT [FK_tblBills_tblCustomers]
GO
ALTER TABLE [dbo].[tblCarts]  WITH CHECK ADD  CONSTRAINT [FK_tblCarts_tblCustomers] FOREIGN KEY([FK_iCustomerID])
REFERENCES [dbo].[tblCustomers] ([PK_iCustomerID])
GO
ALTER TABLE [dbo].[tblCarts] CHECK CONSTRAINT [FK_tblCarts_tblCustomers]
GO
ALTER TABLE [dbo].[tblCarts]  WITH CHECK ADD  CONSTRAINT [FK_tblCarts_tblProducts] FOREIGN KEY([FK_iProductID])
REFERENCES [dbo].[tblProducts] ([PK_iProductID])
GO
ALTER TABLE [dbo].[tblCarts] CHECK CONSTRAINT [FK_tblCarts_tblProducts]
GO
ALTER TABLE [dbo].[tblCustomers]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomers_tblUsers] FOREIGN KEY([FK_iUserID])
REFERENCES [dbo].[tblUsers] ([PK_iUserID])
GO
ALTER TABLE [dbo].[tblCustomers] CHECK CONSTRAINT [FK_tblCustomers_tblUsers]
GO
ALTER TABLE [dbo].[tblDetailBills]  WITH CHECK ADD  CONSTRAINT [FK_tblDetailBills_tblBills] FOREIGN KEY([FK_iBillID])
REFERENCES [dbo].[tblBills] ([PK_iBillID])
GO
ALTER TABLE [dbo].[tblDetailBills] CHECK CONSTRAINT [FK_tblDetailBills_tblBills]
GO
ALTER TABLE [dbo].[tblDetailBills]  WITH CHECK ADD  CONSTRAINT [FK_tblDetailBills_tblProducts] FOREIGN KEY([FK_iProductID])
REFERENCES [dbo].[tblProducts] ([PK_iProductID])
GO
ALTER TABLE [dbo].[tblDetailBills] CHECK CONSTRAINT [FK_tblDetailBills_tblProducts]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblUsers] FOREIGN KEY([FK_iUserID])
REFERENCES [dbo].[tblUsers] ([PK_iUserID])
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblUsers]
GO
ALTER TABLE [dbo].[tblFavourites]  WITH CHECK ADD  CONSTRAINT [FK_tblFavorites_tblCustomer] FOREIGN KEY([FK_iCustomerID])
REFERENCES [dbo].[tblCustomers] ([PK_iCustomerID])
GO
ALTER TABLE [dbo].[tblFavourites] CHECK CONSTRAINT [FK_tblFavorites_tblCustomer]
GO
ALTER TABLE [dbo].[tblFavourites]  WITH CHECK ADD  CONSTRAINT [FK_tblFavorites_tblProduct] FOREIGN KEY([FK_iProductID])
REFERENCES [dbo].[tblProducts] ([PK_iProductID])
GO
ALTER TABLE [dbo].[tblFavourites] CHECK CONSTRAINT [FK_tblFavorites_tblProduct]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblCustomers] FOREIGN KEY([FK_iCustomerID])
REFERENCES [dbo].[tblCustomers] ([PK_iCustomerID])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblCustomers]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblProducts] FOREIGN KEY([FK_iProductID])
REFERENCES [dbo].[tblProducts] ([PK_iProductID])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblProducts]
GO
ALTER TABLE [dbo].[tblProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblProducts_tblTypeProducts] FOREIGN KEY([FK_iType])
REFERENCES [dbo].[tblTypeProducts] ([PK_iType])
GO
ALTER TABLE [dbo].[tblProducts] CHECK CONSTRAINT [FK_tblProducts_tblTypeProducts]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblPermissions] FOREIGN KEY([FK_sPermissionID])
REFERENCES [dbo].[tblPermissions] ([PK_sPermissionID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblPermissions]
GO


create proc checkCartCheck
@idcart int
as
begin
	select * from tblCarts where bCheck = 1 and PK_iCartID = @idcart and bStatus = 1
end

exec checkCartCheck 62

alter proc checkCart
@idcart int, @check int
as
begin
	update tblCarts set bCheck = @check where PK_iCartID = @idcart and bStatus = 1
end

alter proc updateCart
@idcart int, @amount int
as
begin
	if(@amount <=0)
	exec deleteCart @idcart
	else
	update tblCarts set iAmount = @amount where PK_iCartID = @idcart and bStatus = 1
end

select * from tblBills
select * from tblProducts