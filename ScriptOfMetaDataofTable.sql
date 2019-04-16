declare @field_name varchar(50)='%field_name%'
declare @table_name2 varchar(50)='table_name'

use <database_name> /*enter databasename*/

select col.name [Field_name],
Case when typ.name = 'decimal' then typ.name + '(' + Cast(COLUMNPROPERTY(object_id(@table_name2), col.name, 'PRECISION') as varchar(10)) + ',' + Cast(COLUMNPROPERTY(object_id(@table_name2), col.name, 'SCALE')as varchar(10)) + ')'
else case when typ.name = 'nvarchar' then 
typ.name + '(' + Cast(COLUMNPROPERTY(object_id(@table_name2), col.name, 'PRECISION') as varchar(10)) + ')'
else
typ.name
end 
end
[Data type],
col.collation_name
from sys.all_columns col inner join sys.types typ on col.user_type_id = typ.user_type_id  where object_id = object_id(@table_name2)
and col.name like rtrim(ltrim(@field_name))