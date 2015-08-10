---
layout: post
title: Sql行列转换
categories: home
---

#程序如下


		DECLARE @sql_str NVARCHAR(MAX)
		DECLARE @sql_col NVARCHAR(MAX)
		DECLARE @tableName SYSNAME --行转列表
		DECLARE @groupColumn SYSNAME --分组字段
		DECLARE @row2column SYSNAME --行变列的字段
		DECLARE @row2columnValue SYSNAME --行变列值的字段
		SET @tableName = '#weig'
		SET @groupColumn = 'SShipp'
		SET @row2column = 'ZoningNO'
		SET @row2columnValue = 'Weig'

		--从行数据中获取可能存在的列
		SET @sql_str = N'
		SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME(['+@row2column+']) 
		    FROM ['+@tableName+'] GROUP BY ['+@row2column+']'
		--PRINT @sql_str
		EXEC sp_executesql @sql_str,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@sql_col OUTPUT
		--PRINT @sql_col

		SET @sql_str = N'
		SELECT * FROM (
		    SELECT ['+@groupColumn+'],['+@row2column+'],['+@row2columnValue+'] FROM ['+@tableName+']) p PIVOT 
		    (SUM(['+@row2columnValue+']) FOR ['+@row2column+'] IN ( '+ @sql_col +') ) AS pvt 
		ORDER BY pvt.['+@groupColumn+']'
		--PRINT (@sql_str)
		EXEC (@sql_str)