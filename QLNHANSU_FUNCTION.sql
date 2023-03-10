--Tao MANV tu dong
CREATE FUNCTION AUTO_IDNV()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(MANV) FROM tb_NHANVIEN) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(MANV, 3)) FROM tb_NHANVIEN
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'NV00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'NV0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
--Tao MABH TU DONG

CREATE FUNCTION AUTO_MA_BH()
RETURNS VARCHAR(15)
AS
BEGIN
	DECLARE @MABH VARCHAR(15)
	IF (SELECT COUNT(SOBH) FROM tb_BAOHIEM) = 0
		SET @MABH = '0'
	ELSE
		SELECT @MABH = MAX(RIGHT(SOBH, 2)) FROM tb_BAOHIEM
		SELECT @MABH = CASE
			WHEN @MABH >= 0 and @MABH < 9 THEN 'DN479122510020' + CONVERT(CHAR, CONVERT(INT, @MABH) + 1)
			WHEN @MABH >= 9 and @MABH <20 THEN 'DN40101161520' + CONVERT(CHAR, CONVERT(INT, @MABH) + 1)
			WHEN @MABH >= 20 THEN 'DN47912299020' + CONVERT(CHAR, CONVERT(INT, @MABH) + 1)
		END
	RETURN @MABH
END



ALTER TABLE tb_BAOHIEM ADD CONSTRAINT SOBH_TUDONG DEFAULT DBO.AUTO_MA_BH() FOR SOBH;
--Ma Hop Dong Tu Dong

CREATE FUNCTION AUTO_MA_HD()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @ID VARCHAR(10)
	IF (SELECT COUNT(SOHD) FROM tb_HOPDONG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(SOHD, 2)) FROM tb_HOPDONG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'HDLD00000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'HDLD0000' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

---Set trang thai 



CREATE FUNCTION AUTO_MA_THANGCONGCHITIET()
RETURNS INT
AS
BEGIN
	DECLARE @ID VARCHAR(10), @YEAR1 varchar(4)
	IF (SELECT COUNT(MATHANGCONG) FROM tb_THANGCONGCHITIET) = 0
	begin
		SET @ID = '0'
		set @YEAR1='2022'
	end
	ELSE
		SELECT @ID = MAX(RIGHT(MATHANGCONG, 2)) FROM tb_THANGCONGCHITIET
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN @YEAR1 +'0'+ CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID<=12 THEN @YEAR1 + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			when @ID>12 then  CONVERT(CHAR, CONVERT(INT, @YEAR1) + 1)+'0'+ CONVERT(CHAR, CONVERT(INT, @ID) - 13)
		END
	RETURN CONVERT(INT,@ID)
END

select 2022+MONTH(GETDATE())

drop function AUTO_MA_THANGCONGCHITIET