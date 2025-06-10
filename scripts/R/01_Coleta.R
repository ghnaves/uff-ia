library('rvest')
library('dplyr')
library('purrr')
library('stringr')


url <- "https://app.uff.br/riuff/handle/1/34087"
page <- read_html(url)

titulos <- page %>%
  html_nodes(".first-page-header") %>% 
  html_text()
resumo <- page %>%
  html_nodes(xpath = "//h5[span[text()='Resumo']]/following-sibling::div[1]") %>%
  html_text2()
autor <- page %>%
  html_nodes("#item_author a") %>%
  html_text2()

get_links_uma_pagina <- function(url) {
  page <- read_html(url)
  page %>%
    html_nodes("div.artifact-title a") %>%
    html_attr("href") %>%
    paste0("https://app.uff.br", .)
}



gerar_links_paginacao <- function(base_url, n_paginas, offset = 20) {
  paste0(base_url, "?offset=", seq(0, by = offset, length.out = n_paginas))
}





extrair_detalhes_tese <- function(link) {
  page <- read_html(link)
  titulo <- page %>%
    html_nodes(".first-page-header.bold") %>%
    html_text2()
  autores <- page %>%
    html_nodes("#item_author a") %>%
    html_text2() %>%
    paste(collapse = "; ")
  resumo <- page %>%
    html_nodes(xpath = "//h5[span[text()='Resumo']]/following-sibling::div[1]") %>%
    html_text2()
  tibble::tibble(
    titulo = titulo,
    autores = autores,
    resumo = resumo,
    link = link
  )
}

get_detalhes_listagem <- function(url) {
  page <- read_html(url)
  
  itens <- page %>% html_nodes("li.ds-artifact-item")
  
  map_dfr(itens, function(item) {
    titulo <- item %>%
      html_node("h4.artifact-title a") %>%
      html_text2()%>%
      stringr::str_trim()
    
    link_rel <- item %>%
      html_node("h4.artifact-title a") %>%
      html_attr("href")
    
    link <- paste0("https://app.uff.br", link_rel)
    
    autor <- item %>%
      html_node("span.author") %>%
      html_text2()%>%
      stringr::str_trim()
    
    ano <- item %>%
      html_node("div.artifact-info") %>%
      html_text2() %>%
      stringr::str_extract("\\d{4}")
    
    resumo <- item %>%
      html_node("div.artifact-abstract") %>%
      html_text2()%>%
      stringr::str_trim()
    
    tibble::tibble(
      titulo = titulo,
      autor = autor,
      ano = ano,
      resumo = resumo,
      link = link
    )
  })
}

# 1. Obter todos os links de dissertações

#  <https://app.uff.br/riuff/handle/1/14230> é a URL base para dissertações do PPG em Geografia de Campos.
#    Para outros programas, mude o número após o "handle/1/" e o n_paginas.

urls_paginas <- gerar_links_paginacao("https://app.uff.br/riuff/handle/1/14230/recent-submissions",n_paginas = 2)

# 2. Captura os links de cada uma das páginas
todos_links <- map(urls_paginas, get_links_uma_pagina) %>%
  flatten_chr()

# 3. Extrai os detalhes de cada dissertação
df_dissertacoes <- map_dfr(urls_paginas, get_detalhes_listagem)

# 4. Exporta os dados das dissertações para um arquivo CSV
readr::write_csv(df_dissertacoes, "data/raw/dissertacoes_31003010095P5.csv")
saveRDS(df_dissertacoes, file = "data/raw/dissertacoes_31003010095P5.rds")


