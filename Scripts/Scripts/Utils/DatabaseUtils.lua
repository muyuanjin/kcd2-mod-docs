DatabaseUtils = {}

-- =============================================================================
function DatabaseUtils.LoadTable(tableName)

	local lineCount = Database.GetTableInfo(tableName).LineCount
	local result = {}

	for n=0, lineCount-1 do
		result[n+1] = Database.GetTableLine(tableName, n)
	end

	return result

end

-- =============================================================================
function DatabaseUtils.LoadTableColumns(tableName, columns)

  local numCols = Database.GetTableInfo(tableName).ColumnCount
  local colDictionary = {}
  for c=0,numCols-1 do
    colDictionary[Database.GetColumnInfo(tableName,c).Name] = c
  end

  local table = {}

  for i=1,#columns do
	table[ columns[i] ] = Database.GetTableColumnData(tableName,colDictionary[columns[i]])
  end

  return table

end

-- =============================================================================
function DatabaseUtils.LoadTableColumn(tableName, column)
	return DatabaseUtils.LoadTableColumns(tableName, { column, })[column]
end

-- =============================================================================
function DatabaseUtils.RemapColumns(columns, indexColumn)

	local remapped = {}

	for i=1,#columns[indexColumn] do
		remapped[ columns[indexColumn][i] ] = {}
	end

	for cName,cVal in pairs(columns) do

			for i=1,#cVal do
				remapped[ columns[indexColumn][i] ][cName] = cVal[i]
			end

		end

	return remapped
end

-- =============================================================================
function DatabaseUtils.RemapSingleColumn(columns, indexColumn)

	local remapped = {}

	for cName,cVal in pairs(columns) do
			if(cName ~= indexColumn) then
				for i=1,#cVal do
					remapped[ columns[indexColumn][i] ] = cVal[i]
				end
			end
		end

	return remapped
end

-- =============================================================================
function DatabaseUtils.LoadTableColumnsWithIndex(tableName, primaryColumn, columns)
	columns[#columns+1] = primaryColumn
	return DatabaseUtils.RemapColumns(DatabaseUtils.LoadTableColumns(tableName, columns), primaryColumn)
end

-- =============================================================================
function DatabaseUtils.LoadTableColumnWithIndex(tableName, primaryColumn, secondaryColumn)
	local columns = { primaryColumn, secondaryColumn }
	return DatabaseUtils.RemapSingleColumn(DatabaseUtils.LoadTableColumns(tableName, columns), primaryColumn)
end