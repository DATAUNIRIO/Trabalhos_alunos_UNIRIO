library(janitor)
library(readxl)

nomes_e_links_rpubs <- read_excel("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2021/segundo semestre/NOTAS_3.xlsx", 
                      sheet = "adm", skip = 6) %>% clean_names()
names(nomes_e_links_rpubs)
nomes_e_links_rpubs<-nomes_e_links_rpubs[,c(3,5)]

nomes_e_links_rpubs<-na.omit(nomes_e_links_rpubs)
names(nomes_e_links_rpubs)
nomes_e_links_rpubs$nome<-tolower(nomes_e_links_rpubs$nome)

# Convert First letter of every word to Uppercase in R
library(stringr) 
nomes_e_links_rpubs$nome<-str_to_title(nomes_e_links_rpubs$nome)  
nomes_e_links_rpubs$nome<-gsub("De","de",nomes_e_links_rpubs$nome)
nomes_e_links_rpubs$nome<-gsub(" Da"," da",nomes_e_links_rpubs$nome)
nomes_e_links_rpubs$nome<-gsub(" Dos"," dos",nomes_e_links_rpubs$nome)


SEQ  <- seq(1,44)
pb   <- txtProgressBar(1, 44, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu8">  <a href="',nomes_e_links_rpubs[i,2],
    '"><br><br><img src="depoimentos.png" alt="',nomes_e_links_rpubs[i,1],'" title="',nomes_e_links_rpubs[i,1],'" />'
    ,nomes_e_links_rpubs[i,1],
    '</a>
      </li>
    '
)}

cat(dados)

#--------------------------------------------------------------------------------------

library(readxl)

Eng_Civil_2021_1 <- read_excel("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2021/primeiro semestre/notas/Engenharia Civil 2021.xlsx")  %>% clean_names()
Eng_Civil_2021_2 <- read_excel("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2021/segundo semestre/MESTRADO ENGENHARIA.xlsx")  %>% clean_names()


Eng_Civil_2021_1 <- Eng_Civil_2021_1[,c(1,3)]
Eng_Civil_2021_1 <- na.omit(Eng_Civil_2021_1)

Eng_Civil_2021_1$x3 <- gsub("Trabalho André Hozumi e Nathan Barbosa: ","",Eng_Civil_2021_1$x3)
Eng_Civil_2021_1$x3
Eng_Civil_2021_1 <- Eng_Civil_2021_1[1:6,]
Eng_Civil_2021_1


Eng_Civil_2021_2 <- Eng_Civil_2021_2[,c(3,4)]
Eng_Civil_2021_2 <- na.omit(Eng_Civil_2021_2)

names(Eng_Civil_2021_1)[1]<-'nome'
names(Eng_Civil_2021_2)[1]<-'nome'

Eng_Civil_2021_2$nome<-tolower(Eng_Civil_2021_2$nome)
# Convert First letter of every word to Uppercase in R
library(stringr) 
Eng_Civil_2021_2$nome<-str_to_title(Eng_Civil_2021_2$nome)  
Eng_Civil_2021_2$nome<-gsub("De","de",Eng_Civil_2021_2$nome)
Eng_Civil_2021_2$nome<-gsub(" Da"," da",Eng_Civil_2021_2$nome)
Eng_Civil_2021_2$nome<-gsub(" Dos"," dos",Eng_Civil_2021_2$nome)


SEQ  <- seq(1,6)
pb   <- txtProgressBar(1, 6, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu1">  <a href="',Eng_Civil_2021_1[i,2],
                   '"><br><br><img src="depoimentos.png" alt="',Eng_Civil_2021_1[i,1],'" title="',Eng_Civil_2021_1[i,1],'" />'
                   ,Eng_Civil_2021_1[i,1],
                   '</a>
      </li>
    '
  )}

cat(dados)


SEQ  <- seq(1,11)
pb   <- txtProgressBar(1, 11, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu3">  <a href="',Eng_Civil_2021_2[i,2],
                   '"><br><br><img src="depoimentos.png" alt="',Eng_Civil_2021_2[i,1],'" title="',Eng_Civil_2021_2[i,1],'" />'
                   ,Eng_Civil_2021_2[i,1],
                   '</a>
      </li>
    '
  )}

cat(dados)







