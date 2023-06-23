


--Select Distinct  DATEADD(dd,TradeDate,'01-01-1900') as dd ,TradeDate ,ScripCode into #temp from EODdata
--order by TradeDate


--Update EODdata
--SET FinalTrade = [#temp].dd
--from #temp
--where #temp.TradeDate = EODdata.TradeDate
--select * from #temp


--ALTER TABLE EODData 
--add FinalTrade date 

--select * from #temp where TradeDate = 43148





DECLARE @query nvarchar(max)
DECLARE @columnlist nvarchar(max)

Select @columnlist = COALESCE(@columnlist + ',','') + QUOTENAME(FinalTrade) FROM 
(Select distinct top 2000 FinalTrade from EODdata) as datess



--select @columnlist = ISNULL(@columnlist + ',', '') + QUOTENAME(TradeDate) FROM 
--(Select distinct top 5 TradeDate from EODdata) as datess

SET @query = 
N'Select ScripCode,'+ @columnlist + ' 
FROM (Select   ScripCode,CloseRate ,FinalTrade from EODData) as t
PIVOT(sum(CloseRate) for FinalTrade in ( ' + @columnlist +')) as PIVOTTABLE'

exec sp_executesql @query 





