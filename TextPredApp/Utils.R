
# v202004172120

ngs <- readRDS("./Data/n_gram_npp.Rds")
ngs_2 <- ngs[ngs$pre_n == 2, ]
ngs_3 <- ngs[ngs$pre_n == 3, ]
ngs_4 <- ngs[ngs$pre_n == 4, ]
rm(ngs)


calcula_mag <- function(x){
  tamano <- sapply(x, object.size)
  tamano <- round(tamano / 1024 ^ 2, 2)
  num_lineas <- sapply(x, length)
  num_car <- sapply(x, function(x) sum(nchar(x)))
  magnitudes <- rbind(tamano, num_lineas, num_car)
  rownames(magnitudes) <- c("Obj size (MB)", "Num lines", "Num characters")
  magnitudes
}

limpia_texto <- function(t, prof_fic = "./Data/en_profanity.txt" ){
  if (!exists("prof")){
    prof <- readLines(prof_fic, encoding = "UTF-8", skipNul = TRUE)
    prof_ptn <- paste0(prof, collapse = "|")  
  }
  t_limpio <- tolower(t)
  t_limpio <- gsub("[^a-z ]", " ", t_limpio)
  t_limpio <- gsub(" m\\b", " am", t_limpio)
  t_limpio <- gsub("n t\\b", " not", t_limpio)
  t_limpio <- gsub(" re\\b", " are", t_limpio)
  t_limpio <- gsub("\\bi\\b", "I", t_limpio)
  t_limpio <- gsub("\\b[^aI ]\\b", "", t_limpio)
  t_limpio <- gsub("\\b\\w*([a-z])\\1{2,}\\w*\\b", "", t_limpio)
  t_limpio <- gsub(" {2, }", " ", t_limpio)
  t_limpio <- gsub(prof_ptn, "", t_limpio)
  t_limpio <- trimws(t_limpio)
  t_limpio
}

predice_texto <- function(t){
  # if (!exists("ngs") & !exists("ngs_2")){
  #   ngs <- readRDS("./Data/n_gram_npp.Rds")
  # }
  # if (!exists("ngs_2")){
  #   ngs_2 <- ngs[ngs$pre_n == 2, ]
  #   ngs_3 <- ngs[ngs$pre_n == 3, ]
  #   ngs_4 <- ngs[ngs$pre_n == 4, ]
  #   rm(ngs)
  # }

  t_limpio <- limpia_texto(t)
  resultado <- character(length = 2)
  res_busq <- character(length = 0)
  
  if (t_limpio == ""){
    resultado[1] <- "Entered text is not valid."
  } else {
    t_vector <- unlist(strsplit(t_limpio, " "))
    t_vector <- t_vector[grep("^$", t_vector, invert = TRUE)]
    t_vector <- tail(t_vector, 3)
    longitud <- length(t_vector)

    if (longitud == 3L){
      t_buscado <- paste0(t_vector, collapse = " ")
      res_busq <- ngs_4$post[ngs_4$pre == t_buscado]
    }
    if (longitud >= 2L && is.na(res_busq[1])){
      t_buscado <- paste0(tail(t_vector, 2), collapse = " ")
      res_busq <- ngs_3$post[ngs_3$pre == t_buscado]
    }
    if (is.na(res_busq[1])){
      t_buscado <- tail(t_vector, 1)
      res_busq <- ngs_2$post[ngs_2$pre == t_buscado]
    }
    if (is.na(res_busq[1])){
      resultado[1] <- "Not found."
    } else {
      resultado[1] <- "Predicted:"
      resultado[2] <- res_busq
    }
  }
  resultado
}
