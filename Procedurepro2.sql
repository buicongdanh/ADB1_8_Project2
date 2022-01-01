USE CUA_HANG_HOA
GO
--Store procedure để khách hàng xem sản phẩm
CREATE PROC khach_hang_xem_san_pham @ma_kh CHAR(10)
AS
BEGIN TRANSACTION

	SELECT *
	FROM SAN_PHAM sp
COMMIT TRANSACTION;
GO

--Store procedure để khách hàng xem lịch sử mua hàng 
CREATE PROC khach_hang_xem_lich_su_mua_hang @ma_kh CHAR(10)
AS
BEGIN TRANSACTION

	SELECT lsmh.MA_KH,dh.LOAI_DON_HANG,dh.NGAY_LAP,dh.DIA_CHI_NH,dh.HO_TEN_NN,dh.THOI_GIAN_GH
	FROM DON_HANG dh,LICH_SU_MUA_HANG lsmh
	WHERE lsmh.MA_KH = @ma_kh and lsmh.MA_DH=dh.MA_DH;
COMMIT TRANSACTION;
GO
--Store procedure để quản trị cập nhật sản phẩm
--Procedure cập nhật sản phẩm
CREATE PROCEDURE cap_nhat_san_pham @ma_sp CHAR(10), @ten_sp NVARCHAR(20), @mo_ta NVARCHAR(30), @gia INT, @loai CHAR(10),@so_luong_ton INT,@giam_gia FLOAT
AS
BEGIN TRANSACTION
	--Nếu tên sản phẩm, mô tả không trống, giá không bị âm -> cập nhật giá trị mới
	--Nếu không thì giữ những giá trị cũ lại
	IF (@ten_sp = '')
		BEGIN
			SET @ten_sp = (SELECT TEN_SP FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	IF (@mo_ta = '')
		BEGIN
			SET @mo_ta = (SELECT MO_TA_SP FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	IF (@gia < 0)
		BEGIN
			SET @gia = (SELECT GIA_SP FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	IF (@loai = '')
		BEGIN
			SET @loai = (SELECT LOAI_HANG FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	IF (@so_luong_ton< 0)
		BEGIN
			SET @so_luong_ton = (SELECT SO_LUONG_TON FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	IF (@giam_gia< 0)
		BEGIN
			SET @giam_gia = (SELECT MUC_GIAM_GIA FROM SAN_PHAM WHERE MA_SP = @ma_sp);
		END
	UPDATE SAN_PHAM
	SET TEN_SP = @ten_sp,
		MO_TA_SP = @mo_ta,
		GIA_SP = @gia,
		LOAI_HANG= @loai,
		SO_LUONG_TON=@so_luong_ton,
		MUC_GIAM_GIA=@giam_gia
	WHERE MA_SP = @ma_sp
COMMIT TRANSACTION
GO
--Store procedure để quản lí tồn kho
CREATE PROC quan_li_ton_kho @ma_kho CHAR(10),@ma_sp CHAR(10)
AS
BEGIN TRANSACTION

	SELECT *
	FROM CHI_TIET_KHO ctk
	WHERE ctk.MA_KHO = @ma_kho and ctk.MA_SP=@ma_sp;
COMMIT TRANSACTION;
GO
--Store procedure lịch sử nhập hàng
CREATE PROC xem_lich_su_nhap_hang @ma_qt CHAR(10)
AS
BEGIN TRANSACTION

	SELECT pn.MA_PN,pn.NGAY_NHAP,pn.KH_HANG,ctpn.DON_GIA,ctpn.MA_SP,ctpn.SO_LUONG
	FROM PHIEU_NHAP pn,CT_PHIEU_NHAP ctpn
	WHERE pn.MA_PN=ctpn.MA_PN and pn.QT_PHUTRACH=@ma_qt;
	
COMMIT TRANSACTION;
GO
--Store procedure lịch sử xuất hàng
CREATE PROC xem_lich_su_xuat_hang @ma_qt CHAR(10)
AS
BEGIN TRANSACTION

	SELECT px.MA_PX,px.NGAY_XUAT,px.KH_HANG,ctpx.DON_GIA,ctpx.MA_SP,ctpx.SO_LUONG
	FROM PHIEU_XUAT px,CT_PHIEU_XUAT ctpx
	WHERE px.MA_PX=ctpx.MA_PX and px.QT_PHUTRACH=@ma_qt;
	
COMMIT TRANSACTION;
GO
--Store procedure thống kê số lượng hàng
CREATE PROC thong_ke_so_luong @ma_ql CHAR(10),@ma_shop CHAR(10)
AS
BEGIN TRANSACTION

	SELECT shsh.MA_SHOP,shsh.MA_SP,shsh.SO_LUONG
	FROM SP_SHOP shsh,SHOP sh,QUAN_LI ql
	WHERE sh.MA_SHOP=@ma_shop and shsh.MA_SHOP= sh.MA_SHOP and ql.MA_SHOP=sh.MA_SHOP and ql.MA_QL=@ma_ql;
	
COMMIT TRANSACTION;
GO
--Store procedure nhân sự điểm danh:Thêm cột trong chi tiet ngay lam
CREATE PROC nv_diem_danh @ma_nv CHAR(10),@ngaylv DATE,@sogio INT
AS
BEGIN TRANSACTION
		INSERT INTO CHI_TIET_NGAY_LAM(MA_NV, NGAY_LAM_VIEC, SO_GIO )
		VALUES (@ma_nv,@ngaylv,@sogio);
COMMIT TRANSACTION;
GO
--Store procedure lịch sử lương của nhân viên
CREATE PROC lich_su_luong @ma_nv CHAR(10)
AS
BEGIN TRANSACTION

	SELECT *
	FROM LICH_SU_LUONG lsl
	WHERE lsl.MA_NV=@ma_nv
	
COMMIT TRANSACTION;
GO
--Store procedure số đơn hàng cho nhân viên
CREATE PROC so_luong_don_hang @ma_nv CHAR(10)
AS
BEGIN TRANSACTION
	SELECT dh.NV_TT,count(dh.MA_DH)
	FROM DON_HANG dh
	WHERE dh.NV_TT=@ma_nv
	GROUP BY dh.NV_TT
COMMIT TRANSACTION;
GO
--Store procedure doanh số cho nhân viên 
CREATE PROC doanh_so_nhan_vien @ma_nv CHAR(10)
AS
BEGIN TRANSACTION
	SELECT sum(gh.TONG_THANH_TIEN)
	FROM DON_HANG dh,GIO_HANG gh
	WHERE dh.NV_TT=@ma_nv and dh.MA_GH=gh.MA_GH
	GROUP BY dh.NV_TT
COMMIT TRANSACTION;
GO
--Store procedure thêm sản phẩm 
CREATE PROC them_san_pham @ma_sp CHAR(10),@ten_sp NVARCHAR(20),@mo_ta NVARCHAR(30),@gia INT,@loai char(10),@so_luong_ton INT ,@giam_gia FLOAT
AS
BEGIN TRANSACTION
		INSERT INTO SAN_PHAM(MA_SP, TEN_SP, MO_TA_SP , GIA_SP, LOAI_HANG, SO_LUONG_TON, MUC_GIAM_GIA)
		VALUES (@ma_sp, @ten_sp , @mo_ta, @gia, @loai, @so_luong_ton, @giam_gia);
COMMIT TRANSACTION;
GO
