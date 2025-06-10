# Uma Inteligência para Chamar de Nossa – IA-UFF

Projeto para o desenvolvimento de um modelo de linguagem treinado a partir de teses e dissertações da UFF, com aplicações voltadas ao ensino, pesquisa e gestão universitária.

## Objetivo
Criar uma IA institucional de código aberto.

## Linguagem
- R (tidyverse, text2vec, quanteda, keras)

## Etapas
1. Coleta de teses/dissertações
   - Utilização de APIs do Repositório Institucional da UFF
   - Extração de metadados e textos completos
   - Bibliotecas R: `rvest`, `dplyr`, `purrr`, `stringr`
   
2. Preprocessamento textual
   - Limpeza de dados
   - Tokenização e vetorização
   - Criação de embeddings semânticos
   - Bibliotecas R: `quanteda`
   
3. Treinamento de modelos de linguagem
4. Avaliação e interfaces

## Estrutura do repositório
Em construção. A estrutura do repositório está projetada para ser organizada da seguinte forma:

```plaintext
uff-ia/
├── README.md           # Apresentação do projeto
├── LICENSE             # GPL-3, conforme seu plano
├── .gitignore          # Ignorar cache, `.Rhistory`, data/raw, data, etc.
├── data/
│   ├── raw/            # Dados brutos (não versionar)
│   ├── processed/      # Dados limpos ou prontos para modelagem
├── scripts/
│   ├── R/
│   │   ├── 01_Coleta.R         # Scraping, pré-processamento
│   │   └── 02_modelo_texto.R   # NLP, embeddings, etc.
│   ├── python/
│   │   ├── 00_scraper_riuff.py
│   │   └── utils.py
├── notebooks/
│   ├── R/              # Explorações, protótipos em R
│   └── python/         # Jupyter ou Quarto
├── requirements.txt    # dependências Python
├── renv.lock           # dependências R
└── environment.yml     # compatibilidade (opcional para conda/mamba)
```

## Dados

Os dados não são incluídos diretamente no repositório. Apenas um arquivo de exemplo está no repositório (`dissertacoes_31003010095P5.csv`).

Para gerar os arquivos localmente, execute `scripts/R/01_Coleta.R` para coletar os dados do Repositório Institucional da UFF, alterando o endereço do repositório de interesse.

## Licença
Este projeto está licenciado sob os termos da [GNU General Public License v3.0](LICENSE).
