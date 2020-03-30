
# v202003301933

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
  prof <- readLines(prof_fic, encoding = "UTF-8", skipNul = TRUE)
  prof_ptn <- paste0(prof, collapse = "|")
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
  if (!exists("ngs")){
    ngs <- readRDS("./Data/n_gram_npp.Rds")
  }
  t_limpio <- limpia_texto(t)
  if (t_limpio == ""){
    stop("Entered text is not valid.")
  }
  t_vector <- unlist(strsplit(t_limpio, " "))
  longitud <- length(t_vector)
  t_buscado_4 <- character(length = 3)
  t_buscado_3 <- character(length = 2)
  t_buscado_2 <- character(length = 1)
  pred <- character(length = 0)
  if (longitud >= 3L){
    t_buscado_4 <- paste0(t_vector[(longitud - 2):longitud], collapse = " ")
    pred <- ngs$post[ngs$pre == t_buscado_4]
  }
  if (longitud >= 2L & is.na(pred[1])){
    t_buscado_3 <- paste0(t_vector[(longitud - 1):longitud], collapse = " ")
    pred <- ngs$post[ngs$pre == t_buscado_3]
  }
  if (is.na(pred[1])){
    t_buscado_2 <- t_vector[1]
    pred <- ngs$post[ngs$pre == t_buscado_2]
  }
  if (is.na(pred[1])){
    pred <- NA
  }
  pred
}
