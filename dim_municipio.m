let
    Fonte = Json.Document(
        Web.Contents("https://apisidra.ibge.gov.br/values/t/6579/n6/all/v/all/p/last")
    ),
    ParaTabela = Table.FromList(Fonte, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    Expandido = Table.ExpandRecordColumn(ParaTabela, "Column1",
        {"D1C", "D1N", "D3N", "V"},
        {"cod_municipio_ibge", "nome_municipio", "ano_referencia", "populacao"}),
    RemoveCabecalho = Table.Skip(Expandido, 1),
    AddChave = Table.AddColumn(RemoveCabecalho, "cod_municipio",
        each Text.Start(Text.From([cod_municipio_ibge]), 6), type text),
    AddUF = Table.AddColumn(AddChave, "uf",
        each Text.End([nome_municipio], 2), type text),
    AddNomeLimpo = Table.AddColumn(AddUF, "municipio",
        each Text.Trim(Text.BeforeDelimiter([nome_municipio], " - ")), type text),
    Reordena = Table.SelectColumns(AddNomeLimpo,
        {"cod_municipio", "cod_municipio_ibge", "municipio", "uf", "ano_referencia", "populacao"}),
    Tipos = Table.TransformColumnTypes(Reordena, {
        {"cod_municipio", type text},
        {"cod_municipio_ibge", type text},
        {"municipio", type text},
        {"uf", type text},
        {"ano_referencia", Int64.Type},
        {"populacao", Int64.Type}
    })
in
    Tipos