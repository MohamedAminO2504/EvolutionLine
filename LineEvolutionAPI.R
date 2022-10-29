#Récupérer la direction du dossier
library(rstudioapi)
thisFilePath<-rstudioapi::getSourceEditorContext()$path
thisDir = dirname(thisFilePath)
setwd(thisDir)

#Chargement des librairies
library(svDialogs)
library(stringr)

#Appeler la base de données DigimonMock
script_file <- paste0(thisDir,"/","DigimonMock.R")
source(file= script_file)

#################################################FONCTIONS

#############################
####### CREATION LINE #######
#############################

#Fonction enumerer : on ajoute à chaque élément (chaînes de caractères) d'un vecteur un numéro entre crochets
enumerer <- function(vec){
  N <- 0
  liste <- c()
  for(i in vec){
    N <- N + 1
    liste <- append(liste,paste("[",N,"] ",vec[N]))
  }
  return(liste)
}

#création d'une fonction qui demande à l'utilisateur de choisir chaque digimon pour chaque evolution

fun_choix <- function(){
  vecteur_choix <- c()
  Longueur_evolutions <- length(evolutions)
  Progression_choix <- 0
  reponse <- c()
  for (j in evolutions) {
    Progression_choix <- Progression_choix + 1
    element <- evolutions[[Progression_choix]]
    reponse <- dlgInput(paste("Choisis un des Digimons de niveau '", names(evolutions[Progression_choix]),"' en entrant son numero dans la boite de dialogue: ",str_flatten(enumerer(element)," ; ")), Sys.info()["user"])$res
    vecteur_choix <- append(vecteur_choix, reponse)
  }
  return(vecteur_choix)
}

#Afficher les choix
fun_afficher_choix <- function(choix_evolutions) {
  
  N <- 0
  affichage_choix <- c()
  var <- 0
  for(i in choix_evolutions){
    var <- as.numeric(i)
    N <- N + 1
    element <- evolutions[[N]]
    affichage_choix <- append(affichage_choix,paste("[",N,"] ",names(evolutions[N])," : ",element[var]))
  }
  affichage_choix
  return(affichage_choix)
}

####### CREATION LINE PROGRAMME

CreateLine <- function(evolutions) {
  choix_evolutions <- fun_choix()
  affichage_choix <- fun_afficher_choix(choix_evolutions)
  msg_box(paste("Ta ligne d'evolution est la suivante : ",str_flatten(affichage_choix," ; ")))
  return(choix_evolutions)
}

#############################
##### MODIFICATION LINE #####
#############################

UpdateLine <- function(choix_evolutions){
  souhaite_modifier <- dlg_message("Souhaites-tu modifier une evolution?",type= c("yesno"))$res
  while (souhaite_modifier == "yes") {
    quoi_modifier_evo <- as.numeric(dlgInput(paste("Laquelle ? ",str_flatten(fun_afficher_choix(choix_evolutions), " ; ")), Sys.info()["user"])$res)
    choix_modif <- evolutions[[quoi_modifier_evo]]
    quoi_modifier_dig <- as.numeric(dlgInput(paste("Pour la categorie ",names(evolutions[quoi_modifier_evo])," tu as choisi : ",choix_modif[as.numeric(choix_evolutions[quoi_modifier_evo])],". Par qui souhaites-tu le remplacer ?",str_flatten(enumerer(unlist(evolutions[[quoi_modifier_evo]]))," ; ")), Sys.info()["user"])$res)
    choix_evolutions[quoi_modifier_evo] <- quoi_modifier_dig
    msg_box(paste("D'accord, ta ligne d'evolution est la suivante : ",str_flatten(fun_afficher_choix(choix_evolutions)," ; ")))
    souhaite_modifier <- dlg_message("Souhaites-tu modifier une evolution?",type= c("yesno"))$res
  }
  return(choix_evolutions)
}