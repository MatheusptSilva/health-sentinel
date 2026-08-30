let
    Fonte = AzureStorage.Blobs("https://storagehealthsentinel.blob.core.windows.net/"),
    curated1 = Fonte{[Name="curated"]}[Data],
    #"Arquivos Ocultos Filtrados1" = Table.SelectRows(curated1, each [Attributes]?[Hidden]? <> true),
    #"Invocar Função Personalizada1" = Table.AddColumn(#"Arquivos Ocultos Filtrados1", "Transformar Arquivo", each #"Transformar Arquivo"([Content])),
    #"Colunas Renomeadas1" = Table.RenameColumns(#"Invocar Função Personalizada1", {"Name", "Nome da Origem"}),
    #"Outras Colunas Removidas1" = Table.SelectColumns(#"Colunas Renomeadas1", {"Nome da Origem", "Transformar Arquivo"}),
    #"Coluna de Tabela Expandida1" = Table.ExpandTableColumn(#"Outras Colunas Removidas1", "Transformar Arquivo", Table.ColumnNames(#"Transformar Arquivo"(#"Arquivo de Amostra"))),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Coluna de Tabela Expandida1",{{"Nome da Origem", type text}, {"cod_municipio", type text}, {"municipio", type text}, {"uf", type text}, {"data_competencia", type date}, {"ano", Int64.Type}, {"mes", Int64.Type}, {"internacoes", Int64.Type}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Tipo Alterado",{"Nome da Origem"})
in
    #"Colunas Removidas"