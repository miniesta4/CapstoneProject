
# v202004151825
# sample 1%
library(ngram)
source("./TextPredApp/Utils.R")

make_ngrams <- function(directorio = "./Data/en_US"){
  fics <- list.files(directorio, full.names = TRUE)
  docs <- lapply(fics, readLines, encoding = "UTF-8", skipNul = TRUE)
  names(docs) <- c("blogs", "news", "twitter")
  
  longitudes <- sapply(docs, length)
  
  set.seed(20200401)
  samples <- lapply(longitudes, function(x) sample(x, .01 * x))
  docs_sample <- mapply(`[`, docs, samples)
  rm(docs, samples)
  
  texto_v <- unlist(docs_sample, use.names = FALSE)
  texto_v1 <- limpia_texto(texto_v)

  # texto <- paste0(texto_v1, collapse = " ")
  texto1 <- grep("\\s", texto_v1, value = TRUE)
  texto2 <- grep("\\s\\w+\\s", texto_v1, value = TRUE)
  texto3 <- grep("\\s\\w+\\s\\w+\\s", texto_v1, value = TRUE)
  
  n2_gram <- ngram(texto1, n = 2)
  n2_gram_freqs <- get.phrasetable(n2_gram)
  n2_gram_freqs$pre_n <- 2
  
  n3_gram <- ngram(texto2, n = 3)
  n3_gram_freqs <- get.phrasetable(n3_gram)
  n3_gram_freqs$pre_n <- 3
  
  n4_gram <- ngram(texto3, n = 4)
  n4_gram_freqs <- get.phrasetable(n4_gram)
  n4_gram_freqs$pre_n <- 4
  
  n_gram_freqs <- rbind(n2_gram_freqs, n3_gram_freqs, n4_gram_freqs)
  rm(n2_gram, n2_gram_freqs, n3_gram, n3_gram_freqs, n4_gram, n4_gram_freqs)
  n_gram_freqs$ngrams <- trimws(n_gram_freqs$ngrams)
  
  index <- regexpr("\\s\\w+$", n_gram_freqs$ngrams)
  n_gram_freqs$pre <- trimws(substr(n_gram_freqs$ngrams, 1, index))
  n_gram_freqs$post <- substr(n_gram_freqs$ngrams, index + 1, nchar(n_gram_freqs$ngrams))

  n_gram_npp <- n_gram_freqs[!duplicated(n_gram_freqs$pre), c("pre_n", "pre", "post")]
  saveRDS(n_gram_npp, file = "./Data/n_gram_npp.Rds")
}

