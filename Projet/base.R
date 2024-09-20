adresse=read.csv('adresses-03.csv',header=TRUE,sep=";",dec=".")
adresse=unique(adresse$code_postal)
View(adresse)
rm(list=ls())
install.packages(c("httr", "jsonlite"))
library(httr)
library(jsonlite)

base_url <- "https://data.ademe.fr/data-fair/api/v1/datasets/dpe-v2-logements-existants/lines"
# Paramètres de la requête
params <- list(
  page = 1,
  size = 5,
  select = "N°DPE,Code_postal_(BAN),Etiquette_DPE,Date_réception_DPE",
  q = "03100",
  q_fields = "Code_postal_(BAN)",
  qs = "Date_réception_DPE:[2023-06-29 TO 2023-08-30]"
) 

# Encodage des paramètres
url_encoded <- modify_url(base_url, query = params)
print(url_encoded)

# Effectuer la requête
response <- GET(url_encoded)

# Afficher le statut de la réponse
print(status_code(response))

# On convertit le contenu brut (octets) en une chaîne de caractères (texte). Cela permet de transformer les données reçues de l'API, qui sont généralement au format JSON, en une chaîne lisible par R
content = fromJSON(rawToChar(response$content), flatten = FALSE)

# Afficher le nombre total de ligne dans la base de données
print(content$total)

# Afficher les données récupérées
df <- content$result
dim(df)
View(df)