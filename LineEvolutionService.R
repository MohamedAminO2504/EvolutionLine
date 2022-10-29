#Récupérer la direction du dossier
library(rstudioapi)
thisFilePath<-rstudioapi::getSourceEditorContext()$path
thisDir = dirname(thisFilePath)
setwd(thisDir)

#
script_file <- paste0(thisDir,"/","LineEvolutionAPI.R")
source(file= script_file)

test <- CreateLine()
UpdateLine(test)
