
# v202003281800
library(ngram)

make_ngrams <- function(directorio = "./Data/en_US"){
  fics <- list.files("./Data/en_US", full.names = TRUE)
  docs <- lapply(fics, readLines, encoding = "UTF-8", skipNul = TRUE)
  names(docs) <- c("blogs", "news", "twitter")
  
  longitudes <- sapply(docs, length)
  
  set.seed(20200401)
  samples <- lapply(longitudes, function(x) sample(x, .01 * x))
  docs_sample <- mapply(`[`, docs, samples)
  rm(docs, samples)
  
  texto_v <- unlist(docs_sample, use.names = FALSE)
  rm(docs_sample)
  texto_v1 <- limpia_texto(texto_v)

  texto <- paste0(texto_v1, collapse = " ")
  
  n2_gram <- ngram(texto, n = 2)
  n2_gram_freqs <- get.phrasetable(n2_gram)
  
  n3_gram <- ngram(texto, n = 3)
  n3_gram_freqs <- get.phrasetable(n3_gram)
  
  n4_gram <- ngram(texto, n = 4)
  n4_gram_freqs <- get.phrasetable(n4_gram)
  
  n_gram_freqs <- rbind(n2_gram_freqs, n3_gram_freqs, n4_gram_freqs)
  n_gram_freqs$ngrams <- trimws(n_gram_freqs$ngrams)
  
  index <- regexpr(" \\w+$", n_gram_freqs$ngrams)
  n_gram_freqs$prefs <- trimws(substr(n_gram_freqs$ngrams, 1, index))
  n_gram_freqs$sufs <- substr(n_gram_freqs$ngrams, index, nchar(n_gram_freqs$ngrams))
  # saveRDS(n_gram_freqs, file = "./Data/n_gram_freqs.RData")
  
  n_gram_ps <- n_gram_freqs[!duplicated(n_gram_freqs$prefs), c("prefs", "sufs")]
  saveRDS(n_gram_ps, file = "./Data/n_gram_ps.RData")
}

