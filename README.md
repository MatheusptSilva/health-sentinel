# Health Sentinel

Monitoramento da rede hospitalar paulista a partir de dados públicos.
Challenge FIAP 2026.

## Sobre

Mede a pressão assistencial dos municípios de São Paulo cruzando as internações do SUS com a população de cada cidade. O número absoluto não permite comparar municípios de portes diferentes — normalizando pela população, aparecem os que realmente operam sob maior carga.

Recorte: 327 municípios paulistas, 2.896.180 internações em 2025.

## Fontes

- **Internações:** SIH/SUS (DATASUS/TabNet), extraídas por local de internação
- **População:** API SIDRA do IBGE, tabela 6579

## Arquitetura

O CSV do SIH/SUS é armazenado no Azure Blob Storage e a população é consumida direto da API. O ETL foi feito em Power Query (linguagem M), com o dashboard em Power BI. O Python entra como camada de validação e análise exploratória.

## Estrutura

```
data/          base tratada de internações
notebooks/     análise exploratória em Python
powerquery/    código M das consultas e medidas
powerbi/       arquivo do relatório (.pbix)
```

## Alguns achados

- 13 municípios concentram metade das internações do estado
- Sazonalidade com pico em maio e queda em dezembro
- Distribuição bastante assimétrica: média de 738 internações por município/mês contra mediana de 190

## Próximos passos

Integrar o CNES para incluir dados de leitos e passar a medir capacidade, não só demanda.

## Equipe

| Nome | RM |
|---|---|
| Breno Maldonado Rodrigues | 573142 |
| Matheus Pereira Thomé da Silva | 571980 |
