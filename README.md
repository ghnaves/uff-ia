# Uma Inteligência para Chamar de Nossa – IA-UFF

Projeto para o desenvolvimento de um modelo de linguagem treinado a partir de teses e dissertações da UFF, com aplicações voltadas ao ensino, pesquisa e gestão universitária.

## Objetivo
Criar uma IA institucional de código aberto que compreenda a produção acadêmica da universidade e apoie tarefas como resumo, busca semântica, suporte à escrita e análise de textos.

## Linguagem
- R (tidyverse, text2vec, quanteda, keras)

## Etapas
1. Coleta de teses/dissertações
   - Utilização de APIs do Repositório Institucional da UFF
   - Extração de metadados e textos completos
   - Bibliotecas R: `rvest`
   
2. Preprocessamento textual
   - Limpeza de dados
   - Tokenização e vetorização
   - Criação de embeddings semânticos
   - Bibliotecas R: `quanteda`
   
3. Treinamento de modelos de linguagem
4. Avaliação e interfaces

## Licença
A definir (Provavelmente GPL-3)# uff-ia
