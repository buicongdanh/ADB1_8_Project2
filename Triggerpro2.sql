USE CUA_HANG_HOA
GO
create trigger trg_SO_LAN_MH ON KHACH_HANG
for insert,update
as
begin
	if exists(select* from inserted I
				where I.SO_LAN_MH=(select count(lsmh.MA_KH)
									from LICH_SU_MUA_HANG lsmh
									where I.MA_KH=lsmh.MA_KH
									group by MA_KH))
				
	begin
		raiserror('Cap nhat so lan mua khong hop le',15,1)
		rollback
	end
end

create trigger trg_PHI_TAM_TINH ON GIO_HANG
for insert,update
as
begin
	if exists(select* from inserted I
				where I.PHI_TAM_TINH=(select sum(sp.GIA_SP)
									from SP_GIOHANG spgh,SAN_PHAM sp
									where spgh.MA_SP=sp.MA_SP and spgh.MA_GH=I.MA_GH
									group by sp.MA_SP))
				
	begin
		raiserror('Cap nhat phi tam tinh sai nen gio hang khong hop le',15,1)
		rollback
	end
end

create trigger trg_TONG_THANH_TIEN ON GIO_HANG
for insert,update
as
begin
	if exists(select* from inserted I
				where I.TONG_THANH_TIEN=I.PHI_TAM_TINH*I.GIAM_GIA)
				
	begin
		raiserror('Cap nhat tong thanh tien sai nen gio hang khong hop le',15,1)
		rollback
	end
end