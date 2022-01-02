--TH1
--khách hàng tìm kiếm các loại hoa có tên Hướng Dương.
create nonclustered index Index_LoaiHoa
on San_Pham(Ten_SP)
include
(
	[Loai_Hang], [So_Luong_Ton], [Muc_Giam_Gia]
)


select * from SAN_PHAM
where TEN_SP = N'Hướng Dương'


select * from SAN_PHAM
with (index(Index_LoaiHoa))
where TEN_SP = N'Hướng Dương'

--TH2
--cửa hàng muốn tìm xem khách hàng nào là người mua hàng nhiều nhất để tri ân.


select *
from KHACH_HANG
where SO_LAN_MH = (select max(SO_LAN_MH) from KHACH_HANG)

create nonclustered index Index_SoLanMua
on Khach_hang(So_Lan_MH)
include
(
	[Ma_KH], [Ho_Ten_KH], [So_DT_KH]
)


select *
from KHACH_HANG
with (index(Index_SoLanMua))
where SO_LAN_MH = (select max(SO_LAN_MH) from KHACH_HANG)

--TH3
--Khách hàng muốn xem các cửa hàng nào mở cửa lúc 6h30 sáng để có thể mua hoa vào buổi sáng.
create nonclustered index index_GioMoCua
on Shop(Gio_Mo_Cua)
include
(
	[Ma_Shop], [Dia_Chi]
)

select * from SHOP
where GIO_MO_CUA = '06:30'

select * from SHOP
with (index(index_GioMoCua))
where GIO_MO_CUA = '06:30'



--NV muốn coi những đơn hàng thành lập vào năm 2016
select * from DON_HANG
where YEAR(Ngay_Lap) = 2016

create nonclustered index index_NgayLap
on Don_Hang(Ngay_Lap)
include
(
	[Ma_DH], [Loai_Don_Hang], [Dia_Chi_NH]
)

select * from DON_HANG
with (index(index_NgayLap))
where YEAR(Ngay_Lap) = 2016


--Quản trị muốn xem những tài khoản được đăng kí trong năm 2018
select * from TAI_KHOAN
where Year(Ngay_DK) = 2018

create nonclustered index index_NgayDK
on Tai_Khoan(Ngay_DK)
include
(
	[Loai_TK], [Trang_Thai_Khoa]
)

select * from TAI_KHOAN
with (index(index_NgayDK))
where Year(Ngay_DK) = 2018




--quản lí muốn xem những giỏ hàng có hình thức thanh toán là tiền mặt.
select * from GIO_HANG
where HINH_THUC_THANH_TOAN = N'tiền mặt'

create nonclustered index index_HTTT
on Gio_Hang(Hinh_Thuc_Thanh_toan)
include
(
	[Ma_GH],[Tong_Thanh_Tien]
)

select * from GIO_HANG
with (index(index_HTTT))
where HINH_THUC_THANH_TOAN = N'tiền mặt'




--khách hàng muốn xem sản phẩm của 1 shop.
SELECT sp.MA_SP,sp.TEN_SP,sp.MO_TA_SP,sp.GIA_SP,sp.SO_LUONG_TON,sp.LOAI_HANG
FROM SAN_PHAM sp, SP_SHOP spsh
WHERE spsh.MA_SHOP='SHOP_2WSDK' and spsh.MA_SP=sp.MA_SP

create index index_SP_cua_shop
on San_Pham(Ma_SP)
include
(
	[Ten_SP],[Mo_Ta_SP],[Gia_SP],[Loai_Hang]
)

create index index_SP_cua_shop
on SP_SHOP(Ma_Shop)
include
(
	[Ma_SP]
)


SELECT sp.MA_SP,sp.TEN_SP,sp.MO_TA_SP,sp.GIA_SP,sp.SO_LUONG_TON,sp.LOAI_HANG
FROM SAN_PHAM sp, SP_SHOP spsh
with (index(index_SP_cua_shop))
WHERE spsh.MA_SHOP='SHOP_2WSDK' and spsh.MA_SP=sp.MA_SP





--nhân viên muốn xem lịch sử mua hàng của 1 khách hàng.
SELECT lsmh.MA_DH,dh.DIA_CHI_NH,dh.HO_TEN_NN,dh.LOAI_DON_HANG,dh.MA_GH,dh.NGAY_LAP,dh.THOI_GIAN_GH
FROM LICH_SU_MUA_HANG lsmh,DON_HANG dh
WHERE lsmh.MA_KH='KH_593' and lsmh.MA_DH=dh.MA_DH

--quản lí muốn xem số giờ làm việc của 1 nhân viên.
SELECT *
FROM CHI_TIET_NGAY_LAM ctnl
WHERE ctnl.MA_NV='NV_956'

create nonclustered index index_NgayLam
on Chi_Tiet_Ngay_Lam(Ma_NV)
include
(
	[So_Gio]
)

SELECT *
FROM CHI_TIET_NGAY_LAM ctnl
with (index(index_NgayLam))
WHERE ctnl.MA_NV='NV_956'




--drop index index_LoaiHoa on San_Pham
--drop index index_SoLanMua on Khach_Hang
--drop index index_GioMoCua on Shop
--drop index index_NgayLap on Don_Hang
--drop index index_NgayDK on Tai_Khoan
--drop index index_HTTT on Gio_Hang

