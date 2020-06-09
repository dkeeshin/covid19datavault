#T:\Documents\SQL Server Management Studio\18GenerateCoreDataVaultTable.ps1
$outerTemplate = @'
USE $($item.DatabaseName) 
GO

BEGIN TRANSACTION

$($items -join "`n")  
COMMIT TRANSACTION
'@


$innerTemplate = @'

If NOT exists (select * from sys.tables where name = '$($item.TableName)' )
 
CREATE TABLE Core.$($item.TableName) 
($($item.TableName)ID int  NOT NULL,
SourceReferenceKey nvarchar(64)  NOT NULL,
Source nvarchar(108)  NOT NULL,
EffectiveStartDate datetime2  NOT NULL,
EffectiveEndDate datetime2  NOT NULL,
HashValue varbinary(32)  NOT NULL,
CONSTRAINT $($item.TableName)PK PRIMARY KEY ($($item.TableName)ID)); `n
'@

#SourceReferencKey, Source, EffectiveStartDate, EffectiveEndDate, HashValue Constraint

$currentFile = "T:\Documents\kDSResearch2020\CoreTableCreate.csv"

Write-Host $currentFile 

CLS

$sql = Import-Csv $currentFile | Group-Object Date -ov grp | ForEach-Object {
$items = foreach ($item in $_.Group) {
$ExecutionContext.InvokeCommand.ExpandString($innerTemplate)
}
$ExecutionContext.InvokeCommand.ExpandString($outerTemplate) 
}

Write-Host $sql
Set-Content -Path ("T:\Documents\kDSResearch2020\CoreTableCreate.sql") -Value $sql

