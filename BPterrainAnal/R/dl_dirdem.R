dl_dirdem <-
function() {
  dl_from_dropbox("dirdem.tif", "v68asekyagzytjl")
  file.copy("dirdem.tif", "data/dirdem.tif")
  file.remove("dirdem.tif")
}
