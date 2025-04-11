create procedure PROC_COUNT_CLIENTS
as 
begin 
declare @k int = (select count (*) from dbo.CLIENT)
select @k[NumOfClients];
return @k;
end;