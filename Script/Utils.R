
# v202003281808

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
  t_limpio <- gsub(" m ", " am ", t_limpio)
  t_limpio <- gsub("n t ", " not ", t_limpio)
  t_limpio <- gsub(" re ", " are ", t_limpio)
  t_limpio <- gsub(" s ", " is ", t_limpio)
  t_limpio <- gsub(" {2, }", " ", t_limpio)
  t_limpio <- gsub("\\bi\\b", "I", t_limpio)
  t_limpio <- gsub(prof_ptn, "", t_limpio)
  t_limpio <- trimws(t_limpio)
  t_limpio
}