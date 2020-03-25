
calcula_mag <- function(x){
  tamano <- sapply(x, object.size)
  tamano <- round(tamano / 1024 ^ 2, 2)
  num_lineas <- sapply(x, length)
  num_car <- sapply(x, function(x) sum(nchar(x)))
  magnitudes <- rbind(tamano, num_lineas, num_car)
  rownames(magnitudes) <- c("Obj size (MB)", "Num lines", "Num characters")
  magnitudes
}