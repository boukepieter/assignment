dl_from_dropbox <-
function(x, key) { 
  bin <- getBinaryURL(paste0("https://dl.dropboxusercontent.com/s/", key, "/", x), ssl.verifypeer = FALSE) 
  con <- file(x, open = "wb") 
  writeBin(bin, con) 
  close(con) 
  message(noquote(paste(x, "read into", getwd()))) 
}
