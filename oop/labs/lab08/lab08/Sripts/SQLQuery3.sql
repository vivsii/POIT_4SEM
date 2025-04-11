create procedure PROC_COUNT_PRODUCTS
as 
begin 
declare @k int = (select count (*) from dbo.PRODUCTS)
select @k[NumOfProducts];
return @k;
end;
