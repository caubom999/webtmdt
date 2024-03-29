USE [master]
GO
/****** Object:  Database [QLBanHangGiaDung]    Script Date: 9/22/2020 10:02:54 AM ******/
CREATE DATABASE [QLBanHangGiaDung]
use [QLBanHangGiaDung]

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLBanHangGiaDung].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLBanHangGiaDung] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLBanHangGiaDung] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLBanHangGiaDung] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLBanHangGiaDung] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLBanHangGiaDung] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLBanHangGiaDung] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLBanHangGiaDung] SET  MULTI_USER 
GO
ALTER DATABASE [QLBanHangGiaDung] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLBanHangGiaDung] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLBanHangGiaDung] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLBanHangGiaDung] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLBanHangGiaDung] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLBanHangGiaDung] SET QUERY_STORE = OFF
GO
USE [QLBanHangGiaDung]
GO
/****** Object:  Table [dbo].[tblBills]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBills](
	[PK_iBillID] [int] PRIMARY KEY NOT NULL,
	[dDateCreated] [date] NULL,
	[iProductPayment] [int] NULL,
	[iShippingPayment] [int] NULL,
	[FK_iCustomerID] [int] NULL)
GO
/****** Object:  Table [dbo].[tblCarts]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCarts](
	[PK_iCartID] [int] PRIMARY KEY NOT NULL,
	[iAmount] [int] NOT NULL,
	[dDate] [date] NOT NULL,
	[FK_iProductID] [int] NOT NULL,
	[FK_iCustomerID] [int] NOT NULL)
	GO
/****** Object:  Table [dbo].[tblCustomers]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomers](
	[PK_iCustomerID] [int] PRIMARY KEY NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sAddress] [nvarchar](255) NULL,
	[sPhoneNumber] [char](12) NULL,
	[dDoB] [date] NULL,
	[bStatus] [bit] NULL,
	[FK_iUserID] [int] NULL)
/****** Object:  Table [dbo].[tblDetailBills]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDetailBills](
	[FK_iBillID] [int] PRIMARY KEY NOT NULL,
	[FK_iProductID] [int] NOT NULL,
	[iAmount] [int] NOT NULL)
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[PK_iEmployeeID] [int]  PRIMARY KEY NOT NULL,
	[sName] [nvarchar](100) NOT NULL,
	[sAddress] [nvarchar](100) NULL,
	[sPhoneNumber] [char](12) NULL,
	[dDoB] [date] NULL,
	[iSalary] [int] NOT NULL,
	[bStatus] [bit] NOT NULL,
	[FK_iUserID] [int] NOT NULL)
GO
/****** Object:  Table [dbo].[tblFavourites]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFavourites](
	[FK_iProductID] [int] PRIMARY KEY NOT NULL,
	[FK_iCustomerID] [int] NOT NULL)
GO
/****** Object:  Table [dbo].[tblFeedbacks]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedbacks](
	[PK_iFeedbackID] [int] PRIMARY KEY,
	[fEvaluate] [float] NULL,
	[sContent] [nvarchar](200) NULL,
	[dDate] [date] NOT NULL,
	[FK_iProductID] [int] NOT NULL,
	[FK_iCustomerID] [int] NOT NULL)
/****** Object:  Table [dbo].[tblPermissions]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPermissions](
	[PK_sPermissionID] [varchar](50) PRIMARY KEY NOT NULL,
	[sPermissionName] [nvarchar](100) NOT NULL)
GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducts](
	[PK_iProductID] [int] PRIMARY KEY  NOT NULL,
	[sName] [nvarchar](100) NOT NULL,
	[sUnit] [nvarchar](50) NOT NULL,
	[iPrice] [int] NOT NULL,
	[sType] [nvarchar](50) NOT NULL,
	[imgImage] [image] NOT NULL,
	[sDescription] [nvarchar](200) NULL,
	[bStatus] [bit] NOT NULL,
	[iAmount] [int] NOT NULL,
	[fEvaluate] [float] NULL,
	[fPromotion] [float] NULL)
/****** Object:  Table [dbo].[tblUsers]    Script Date: 9/22/2020 10:02:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[PK_iUserID] [int] PRIMARY KEY  NOT NULL,
	[sUserName] [varchar](100) NOT NULL,
	[sPassword] [varchar](100) NOT NULL,
	[bStatus] [bit] NOT NULL,
	[FK_sPermissionID] [varchar](50) NOT NULL)
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
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblPermissions] FOREIGN KEY([FK_sPermissionID])
REFERENCES [dbo].[tblPermissions] ([PK_sPermissionID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblPermissions]
GO
ALTER TABLE [dbo].[tblFavourites]  WITH CHECK ADD  CONSTRAINT [FK_tblFavorites_tblProduct] FOREIGN KEY([FK_iProductID])
REFERENCES [dbo].[tblProducts] ([PK_iProductID])

ALTER TABLE [dbo].[tblFavourites]  WITH CHECK ADD  CONSTRAINT [FK_tblFavorites_tblCustomer] FOREIGN KEY([FK_iCustomerID])
REFERENCES [dbo].[tblCustomers] ([PK_iCustomerID])
GO
USE [master]
GO
ALTER DATABASE [QLBanHangGiaDung] SET  READ_WRITE 
GO
ALTER AUTHORIZATION ON DATABASE::QLBanHangGiaDung TO sa;

-- Baonv-dev
-- Proc HomePage

-- Lấy sản phẩm mới 
--****************************************
alter proc getProductNew
as
begin 
 select TOP 4 * from tblProducts where FK_iType = 1
end
-- Lấy sản phẩm nổi bật
create proc getProductHot
as
begin 
 select TOP 8 * from tblProducts where FK_iType = 2
end
-- Lấy sản phẩm qc
create proc getProductPromo
as
begin 
 select TOP 2 * from tblProducts where FK_iType = 3 
end
-- Proc ListProduct
create proc getListProduct
as 
begin
	select * from tblTypeProducts 
end
-- Proc getAllProduct...
alter proc getAllProduct
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

alter proc getProductByIDType
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

-- Proc Sort/Search
create proc getProductByPrice
@giatu float,
@giaden float
as
begin 
	select * from tblProducts where iPrice > @giatu and iPrice < @giaden
end

alter proc getProductSearch
@keySearch nvarchar(MAX)
as
begin
	select * from tblProducts where sName like '%'+@keySearch+'%'
end

create proc getProductID
@masp int
as
begin
	select * from tblProducts where PK_iProductID = @masp
end

exec getProductID 6

SET IDENTITY_INSERT tblPermissions Off; 
insert into tblPermissions(PK_sPermissionID,sPermissionName) values (3,'user')

create proc getProductRelation
@maloai int
as
begin
	select TOP 3 * from tblProducts where FK_iType = @maloai 
end


-----------------------------------proc tạo thông tin người dùng
alter proc createUser
@ten varchar(255), @sdt char(12), @tendangnhap varchar(255), @password char(12), @permission int 
as
begin
	insert into tblUsers(sUserName, sPassword, bStatus, FK_sPermissionID) values (@tendangnhap, @password, 1, @permission)

	DECLARE @idUser int

	SELECT @idUser = PK_iUserID FROM tblUsers WHERE sUserName = @tendangnhap

	insert into tblCustomers(sName,sPhoneNumber, bStatus, FK_iUserID) values (@ten, @sdt, 1, @idUser)
end


alter proc checkLogin
@tendangnhap varchar(255), @password char(12)
as
begin
	DECLARE @idUser int
	select @idUser = PK_iUserID FROM tblUsers WHERE sUserName = @tendangnhap and sPassword = @password and bStatus = 1
	select * FROM tblCustomers WHERE FK_iUserID = @idUser and bStatus = 1
end



alter proc getUser
@idCustomer int
as
begin 
	select * FROM tblUsers inner join tblCustomers on tblUsers.PK_iUserID = tblCustomers.FK_iUserID WHERE PK_iCustomerID = @idCustomer
end


create proc deleteUser
@idUser int
as
begin 
	update tblUsers set bStatus = 0 where PK_iUserID = @idUser
	update tblCustomers set bStatus = 0 where FK_iUserID = @idUser
end



-----------------------------------------------proc thêm vào yêu thích
create proc createFavourites
@idUser int, @idProduct int 
as
begin
	insert into tblFavourites(FK_iProductID, FK_iCustomerID) values (@idProduct, @idUser)
end



create proc deleteFavourites
@idUser int, @idProduct int 
as
begin
	delete from tblFavourites where FK_iProductID = @idProduct and FK_iCustomerID = @idUser
end


----------------------------------------------proc phản hồi
create proc createFeedback
@evaluate float, @content nvarchar(200), @idproduct int, @idcustommer int 
as
begin
	insert into tblFeedbacks(fEvaluate, sContent, dDate, FK_iProductID, FK_iCustomerID) values (@evaluate, @content, getdate(), @idproduct, @idcustommer)
end



create proc deleteFeedback
@idfeddback int 
as
begin
	delete from tblFeedbacks where PK_iFeedbackID = @idfeddback
end

----------------------------------------------proc giỏ hàng

alter proc getProductInCart
@idcustomer int
as
begin
	select tblProducts.*, tblCarts.* from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1
end




create proc getCheckedProductInCart
@idcustomer int
as
begin
	select tblProducts.*, tblCarts.* from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1 and tblCarts.bCheck = 1
end





create proc getOneProductInCart
@idcart int
as
begin
	select tblProducts.*, tblCarts.iAmount as soluong, tblCarts.PK_iCartID as idcart from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where PK_iCartID = @idcart and tblCarts.bStatus = 1
end



drop proc geCartForBill
@list varchar(max)
as
begin
	select tblProducts.*, tblCarts.iAmount as soluong, tblCarts.PK_iCartID as idcart from tblProducts inner join tblCarts on tblCarts.FK_iProductID = tblProducts.PK_iProductID
	where PK_iCartID in (@list) and tblCarts.bStatus = 1
end

exec geCartForBill (56, 58, 60)





drop trigger checkAmountInsert
on tblCarts for insert
as
begin
	declare @idcustomer int = (select FK_iCustomerID from inserted)
	declare @idproduct int = (select FK_iProductID from inserted)
	if exists (Select * From tblCarts Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and bStatus = 1)
	begin
		update tblCarts set iAmount = iAmount + 1
		Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1
		RollBack Tran
	end
end




alter proc createCart
@idproduct int, @idcustomer int, @amount int
as
begin
	if exists (Select * From tblCarts Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and bStatus = 1)
		update tblCarts set iAmount = iAmount + @amount
		Where FK_iProductID = @idproduct and FK_iCustomerID = @idcustomer and tblCarts.bStatus = 1
	else
		insert into tblCarts(iAmount, dDate, FK_iProductID, FK_iCustomerID, bStatus, bCheck) values (@amount, getdate(), @idproduct, @idcustomer, 1, 0)
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




alter proc deleteCart
@idcart int 
as
begin
	update tblCarts set bStatus = 0 where PK_iCartID = @idcart
end





alter proc checkCart
@idcart int, @check int
as
begin
	update tblCarts set bCheck = @check where PK_iCartID = @idcart and bStatus = 1
end






create proc checkCartCheck
@idcart int
as
begin
	select * from tblCarts where bCheck = 1 and PK_iCartID = @idcart and bStatus = 1
end

exec checkCartCheck 62

----------------------------------------------proc hóa đơn
create proc selectBills
as
begin
	select * from tblBills
end




create proc selectDetailBills
@idbill int
as
begin
	select * from tblDetailBills where FK_iBillID = @idbill
end

create proc selectDetailBillsProduct
@idbill int
as
begin
	select tblDetailBills.*, tblProducts.* from tblDetailBills inner join tblProducts on tblProducts.[PK_iProductID] = tblDetailBills.[FK_iProductID]  
	where FK_iBillID = @idbill
end

exec selectDetailBillsProduct 6

----------------------------------------------proc quản trị sản phẩm
alter proc createProduct
@name nvarchar(100), @unit nvarchar(50), @price float, @type int, @description nvarchar(200), @promotion float, @image varchar(500) 
as
begin
	insert into tblProducts(sName, sUnit, iPrice, FK_iType, sDescription, fEvaluate, fPromotion, sImage, bStatus) values (@name, @unit, @price, @type, @description, 5, @promotion, @image, 1)
end





alter proc updateProduct
@idproduct int, @name nvarchar(100), @unit nvarchar(50), @price float, @type int, @description nvarchar(200), @status int, @promotion float, @image varchar(500) 
as
begin
	update tblProducts set sName = @name, sUnit = @unit, iPrice = @price, FK_iType = @type, sDescription = @description, fPromotion = @promotion, sImage = @image, bStatus = @status where PK_iProductID = @idproduct
end



exec updateProduct 20, 'bskjdfsdkf', 'b', 1, 1, 'b', 1, 1, 'a'

alter proc deleteProduct
@idproduct int 
as
begin
	update tblProducts set bStatus = 0 where PK_iProductID = @idproduct
end






-- SQL bảo
/****** Object:  StoredProcedure [dbo].[getInfo]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[updateInfo]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[unlockuser]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[lockuser]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[getAllUser]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[getComment]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[XoaPhanHoi]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[getAllFeedback]    Script Date: 10/15/2020 10:23:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[getAllFeedback]
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

exec getAllFeedback 3
/****** Object:  StoredProcedure [dbo].[getFeedback]    Script Date: 10/15/2020 10:23:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[chitietdonhang]    Script Date: 10/15/2020 9:39:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter proc [dbo].[chitietdonhang]
@makh int
as
begin
	select [PK_iBillID],[dDateCreated],sum(iAmount) as Soluong,iProductPayment from tblBills inner join tblDetailBills 
	on tblBills.PK_iBillID = tblDetailBills.FK_iBillID  where [FK_iCustomerID] = @makh
	group by PK_iBillID, [dDateCreated], iProductPayment
end
GO



alter proc createBill
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

exec createBill 300000, 4