create procedure PROC_COUNT_ORDERS
as 
begin 
declare @k int = (select count (*) from dbo.ORDERS)
select @k[NumOfOrders];
return @k;
end;