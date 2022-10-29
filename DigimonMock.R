#Récupérer la direction du dossier
library(rstudioapi)
thisFilePath<-rstudioapi::getSourceEditorContext()$path
thisDir = dirname(thisFilePath)
setwd(thisDir)

#############################
######## EVOLUTIONS  ########
#############################

#Vecteurs evolutions
Rookie <- c("Agumon", "Gabumon", "Piyomon", "Palmon", "Tentomon", "Gomamon", "Patamon", "Salamon")
Champion <- c("Greymon", "Garurumon", "Birdramon", "Togemon", "Ikkakumon", "Angemon", "Tailmon")
Ultime <- c("MetalGreymon", "WerGarurumon", "Garudamon", "Lilymon", "Zudomon","MagnaAngemon", "AngeWomon")
Mega <- c("WerGreymon", "MetalGarurumon", "Hououmon", "Rosemon", "Vikemon", "Seraphimon", "MagnaDramon")

#Liste d'évolutions
evolutions <- list(Rookie,Champion,Ultime,Mega)

#création des noms des éléments de la liste
evolutions_names <- c("Rookie","Champion","Ultime","Mega")
names(evolutions) <- evolutions_names