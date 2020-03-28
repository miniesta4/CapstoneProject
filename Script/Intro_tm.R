 
library(tm)
library(ngram)

fics <- list.files("./Data/en_US", full.names = TRUE)
docs <- lapply(fics, readLines, encoding = "UTF-8", skipNul = TRUE)
names(docs) <- c("blogs", "news", "twitter")

longitudes <- sapply(docs, length)

set.seed(20200401)
samples <- lapply(longitudes, function(x) sample(x, .05 * x))
docs_sample <- mapply(`[`, docs, samples)
rm(docs)

docs_sample_ascii <- lapply(docs_sample, iconv, "UTF-8", "ASCII", "")
rm(docs_sample)

docs_corpus <- VCorpus(VectorSource(docs_sample_ascii))
rm(docs_sample_ascii)

docs_corpus <- tm_map(docs_corpus, content_transformer(tolower))
docs_corpus <- tm_map(docs_corpus, removeNumbers)
docs_corpus <- tm_map(docs_corpus, removeWords, stopwords("english"))
docs_corpus <- tm_map(docs_corpus, removePunctuation)
docs_corpus <- tm_map(docs_corpus, stripWhitespace)

cadena <- concatenate(lapply(docs_corpus, "[", 1))
cadena <- preprocess(cadena, case = "lower", remove.punct = TRUE, 
                     remove.numbers = TRUE, fix.spacing = TRUE)

n2_gram <- ngram(cadena, n = 2)
n2_gram_freqs <- get.phrasetable(n2_gram)

n3_gram <- ngram(cadena, n = 3)
n3_gram_freqs <- get.phrasetable(n3_gram)

n4_gram <- ngram(cadena, n = 4)
n4_gram_freqs <- get.phrasetable(n4_gram)

n_grams <- rbind(n2_gram_freqs, n3_gram_freqs, n4_gram_freqs)
saveRDS(n_grams, file = "./Data/n_grams.RData")

n_grams <- readRDS("./Data/n_grams.RData")
summary(n_grams)
head(n_grams)
tail(n_grams)