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

# 1. Obter todos os links de dissertações

urls_paginas <- gerar_links_paginacao("https://app.uff.br/riuff/handle/1/14230", n_paginas = 5)

todos_links <- urls_paginas %>%
  map(get_links_uma_pagina) %>%
  unlist()

# 2. Iterar sobre todos os links para extrair os dados
df_dissertacoes <- todos_links %>%
  map_dfr(extrair_detalhes_tese)

