df=read.csv('adresses-69.csv',header=TRUE,sep=";",dec=".")
View(df)
df=unique(df$code_postal)