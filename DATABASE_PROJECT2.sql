﻿CREATE DATABASE CUA_HANG_HOA
GO
USE CUA_HANG_HOA
GO

CREATE TABLE NHAN_VIEN
(
	MA_NV CHAR(10) PRIMARY KEY  ,
	TEN_TK_NV VARCHAR(20) UNIQUE NOT NULL,
	HO_TEN_NV NVARCHAR(30) NOT NULL,
	CMND_NV  CHAR(10) UNIQUE NOT NULL,
	SO_DT_NV VARCHAR(10) NOT NULL,
	MA_SHOP CHAR(10) NOT NULL,
	Q_LI CHAR(10) NOT NULL,
	CONSTRAINT FK_NV_SH FOREIGN KEY(MA_SHOP) REFERENCES SHOP(MA_SHOP),
	CONSTRAINT FK_QL_NV FOREIGN KEY(Q_LI) REFERENCES QUAN_LI (MA_QL) 
)
GO
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT FK_TK_NV
FOREIGN KEY (TEN_TK_NV)
REFERENCES TAI_KHOAN(TEN_TK)
CREATE TABLE LICH_SU_LUONG
(
	MA_NV CHAR(10) PRIMARY KEY  ,
	THANG INT NOT NULL,
	LUONG_CO_BAN INT NOT NULL CONSTRAINT CHK_LUONG_CO_BAN CHECK (LUONG_CO_BAN >= 0),
	PHU_CAP INT ,
	TIEN_THUONG INT ,
	TIEN_PHAT INT ,
	CONSTRAINT FK_LS_NV FOREIGN KEY(MA_NV) REFERENCES NHAN_VIEN (MA_NV) 
	
)
GO
CREATE TABLE QUAN_LI
(
	MA_QL CHAR(10) PRIMARY KEY,
	TEN_TK_QL VARCHAR(20) UNIQUE NOT NULL,
	HO_TEN_QL NVARCHAR(30) NOT NULL,
	CMND_QL  CHAR(10) UNIQUE NOT NULL,
	SO_DT_QL VARCHAR(10) NOT NULL,
	MA_SHOP CHAR(10) NOT NULL,
)
GO
ALTER TABLE QUAN_LI
ADD CONSTRAINT FK_TK_QL
FOREIGN KEY (TEN_TK_QL)
REFERENCES TAI_KHOAN(TEN_TK)
CREATE TABLE CHI_TIET_NGAY_LAM
(
	MA_NV CHAR(10) PRIMARY KEY  ,
	NGAY_LAM_VIEC DATE DEFAULT GETDATE(),
	SO_GIO INT NOT NULL,
	CONSTRAINT FK_CT_NV FOREIGN KEY(MA_NV) REFERENCES NHAN_VIEN (MA_NV) ,
)
GO
--Tạo bảng tài khoản
CREATE TABLE TAI_KHOAN
(
	TEN_TK VARCHAR(20) PRIMARY KEY,
	MAT_KHAU VARCHAR(50) NOT NULL,
	NGAY_DK DATE DEFAULT GETDATE(),
	LOAI_TK CHAR(2),
	TRANG_THAI_KHOA BIT DEFAULT 0,
)
GO


CREATE TABLE SHOP
(
	MA_SHOP CHAR(10) PRIMARY KEY  ,
	TEN_SHOP VARCHAR(20) UNIQUE NOT NULL,
	SO_DT_LL VARCHAR(10) UNIQUE NOT NULL,
	DIA_CHI NVARCHAR(30) UNIQUE NOT NULL,
	GIO_MO_CUA CHAR(5) NOT NULL,
	GIO_DONG_CUA CHAR(5)  NOT NULL,
)
GO
CREATE TABLE SP_SHOP
(
	MA_SHOP CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	SO_LUONG INT NOT NULL,
	PRIMARY KEY(MA_SHOP, MA_SP),
	CONSTRAINT FK_SHSP_SH FOREIGN KEY(MA_SHOP) REFERENCES SHOP (MA_SHOP) ,
	CONSTRAINT FK_SHSP_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
CREATE TABLE SAN_PHAM
(
	MA_SP CHAR(10) PRIMARY KEY ,
	TEN_SP NVARCHAR(20) NOT NULL,
	MO_TA_SP NVARCHAR(30) DEFAULT '',
	GIA_SP INT NOT NULL CONSTRAINT CHK_SP_GIA_SP CHECK (GIA_SP >= 0),
	LOAI_HANG CHAR(10) NOT NULL,
	SO_LUONG_TON INT NOT NULL,
	MUC_GIAM_GIA FLOAT,
)
GO
CREATE TABLE SP_GIOHANG
(
	MA_GH CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	PRIMARY KEY(MA_GH, MA_SP),
	CONSTRAINT FK_GHSP_SH FOREIGN KEY(MA_GH) REFERENCES GIO_HANG (MA_GH) ,
	CONSTRAINT FK_GHSP_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
--Tạo bảng giỏ hàng
CREATE TABLE GIO_HANG
(
	MA_GH CHAR(10) PRIMARY KEY ,
	PHI_TAM_TINH INT NOT NULL,
	GIAM_GIA FLOAT,
	Voucher CHAR(10) NOT NULL,
	HINH_THUC_THANH_TOAN NVARCHAR(30) NOT NULL,
	TONG_THANH_TIEN FLOAT,
	CONSTRAINT FK_GH_PGG FOREIGN KEY(Voucher) REFERENCES PHIEU_GIAM_GIA(MA_PHIEU)
)
GO
CREATE TABLE PHIEU_GIAM_GIA
(
	MA_PHIEU CHAR(10) PRIMARY KEY ,
	MUC_GIAM_GIA FLOAT NOT NULL,
	NOI_DUNG NVARCHAR(30) NOT NULL,
	HAN_SU_DUNG DATETIME,
)
GO
--Tạo bảng loại hàng sản phẩm
CREATE TABLE LOAI_HANG_SP
(
	MA_LH CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	PRIMARY KEY(MA_LH, MA_SP),
	CONSTRAINT FK_LHSP_LH FOREIGN KEY(MA_LH) REFERENCES LOAI_HANG (MA_LH) ,
	CONSTRAINT FK_LHSP_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
--Tạo bảng loại hàng
CREATE TABLE LOAI_HANG
(
	MA_LH CHAR(10) PRIMARY KEY ,
	TEN_LH NVARCHAR(20) NOT NULL,
)
GO
--Tạo bảng chi tiết kho
CREATE TABLE CHI_TIET_KHO
(
	MA_KHO CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	SO_LUONG INT NOT NULL,
	PRIMARY KEY(MA_KHO, MA_SP),
	CONSTRAINT FK_CTK_KHO FOREIGN KEY(MA_KHO) REFERENCES KHO_HANG (MA_KHO) ,
	CONSTRAINT FK_CTK_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
--Tạo bảng kho hàng
CREATE TABLE KHO_HANG
(
	MA_KHO CHAR(10) PRIMARY KEY ,
	TEN_KHO VARCHAR(20) UNIQUE NOT NULL,
	DIA_CHI_KHO NVARCHAR(30) UNIQUE NOT NULL,
)
GO
--Tạo bảng quản trị
CREATE TABLE QUAN_TRI
(
	MA_QT CHAR(10) PRIMARY KEY,
	TEN_TK_QT VARCHAR(20) UNIQUE NOT NULL,
	HO_TEN_QT NVARCHAR(30) NOT NULL,
	CMND_QT  CHAR(10) UNIQUE NOT NULL,
	SO_DT_QT VARCHAR(10) NOT NULL,
	MA_SHOP CHAR(10) NOT NULL,
)
GO
ALTER TABLE QUAN_TRI
ADD CONSTRAINT FK_TK_QT
FOREIGN KEY (TEN_TK_QT)
REFERENCES TAI_KHOAN(TEN_TK)
--Tạo bảng phiếu nhập 
CREATE TABLE PHIEU_NHAP
(
	MA_PN CHAR(10) PRIMARY KEY,
	NGAY_NHAP DATE DEFAULT GETDATE(),
	KH_HANG CHAR(10) NOT NULL,
	QT_PHUTRACH CHAR(10) NOT NULL,
	CONSTRAINT FK_PN_KH FOREIGN KEY(KH_HANG) REFERENCES KHO_HANG(MA_KHO),
	CONSTRAINT FK_PN_QT FOREIGN KEY(QT_PHUTRACH) REFERENCES QUAN_TRI(MA_QT)
)
GO
CREATE TABLE CT_PHIEU_NHAP
(
	MA_PN CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	SO_LUONG INT NOT NULL,
	DON_GIA INT NOT NULL,
	PRIMARY KEY(MA_PN, MA_SP),
	CONSTRAINT FK_CTPN_PN FOREIGN KEY(MA_PN) REFERENCES PHIEU_NHAP (MA_PN) ,
	CONSTRAINT FK_CTPN_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
CREATE TABLE PHIEU_XUAT
(
	MA_PX CHAR(10) PRIMARY KEY,
	NGAY_XUAT DATE DEFAULT GETDATE(),
	KH_HANG CHAR(10) NOT NULL,
	QT_PHUTRACH CHAR(10) NOT NULL,
	CONSTRAINT FK_PX_KH FOREIGN KEY(KH_HANG) REFERENCES KHO_HANG(MA_KHO),
	CONSTRAINT FK_PX_QT FOREIGN KEY(QT_PHUTRACH) REFERENCES QUAN_TRI(MA_QT)
)
GO
CREATE TABLE CT_PHIEU_XUAT
(
	MA_PX CHAR(10) NOT NULL,
	MA_SP CHAR(10) NOT NULL,
	SO_LUONG INT NOT NULL,
	DON_GIA INT NOT NULL,
	PRIMARY KEY(MA_PX, MA_SP),
	CONSTRAINT FK_CTPX_PX FOREIGN KEY(MA_PX) REFERENCES PHIEU_XUAT (MA_PX) ,
	CONSTRAINT FK_CTPX_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)
)
GO
--Tạo bảng đơn hàng
CREATE TABLE DON_HANG
(
	MA_DH CHAR(10) PRIMARY KEY ,
	MA_GH CHAR(10) NOT NULL,
	LOAI_DON_HANG NVARCHAR(20) NOT NULL,
	NGAY_LAP DATE DEFAULT GETDATE(),
    NV_TT CHAR(10)  NOT NULL,
	DIA_CHI_NH NVARCHAR(30) NOT NULL,
	HO_TEN_NN NVARCHAR(30) NOT NULL,
	THOI_GIAN_GH DATETIME,
	CONSTRAINT FK_DH_NV FOREIGN KEY(NV_TT) REFERENCES NHAN_VIEN(MA_NV),
	CONSTRAINT FK_DH_GH FOREIGN KEY(MA_GH) REFERENCES GIO_HANG(MA_GH)
)
GO
CREATE TABLE LICH_SU_MUA_HANG
(
	MA_KH CHAR(10) NOT NULL,
	MA_DH CHAR(10) NOT NULL,
	PRIMARY KEY(MA_KH, MA_DH),
	CONSTRAINT FK_LSMH_KH FOREIGN KEY(MA_KH) REFERENCES KHACH_HANG (MA_KH) ,
	CONSTRAINT FK_LSMH_DH FOREIGN KEY(MA_DH) REFERENCES DON_HANG(MA_DH)
)
GO

--Tạo bảng khách hàng
CREATE TABLE KHACH_HANG
(
	MA_KH CHAR(10) PRIMARY KEY ,
	TEN_TK_KH VARCHAR(20) UNIQUE NOT NULL,
	HO_TEN_KH NVARCHAR(30) NOT NULL,
	DIA_CHI_KH NVARCHAR(30),
	SO_DT_KH VARCHAR(10) UNIQUE NOT NULL,
	EMAIL_KH VARCHAR(30) UNIQUE NOT NULL,
	SO_LAN_MH INT,
)
GO
ALTER TABLE KHACH_HANG
ADD CONSTRAINT FK_TK_KH
FOREIGN KEY (TEN_TK_KH)
REFERENCES TAI_KHOAN(TEN_TK)

