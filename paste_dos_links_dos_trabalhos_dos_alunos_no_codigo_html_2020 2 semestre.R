library(readxl)
nomes_e_links_rpubs <- read_excel("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2020/segundo semestre/Notas 2020 Adm.xlsx", 
                             range = "D8:E38")
View(nomes_e_links_rpubs)
nomes_e_links_rpubs<-na.omit(nomes_e_links_rpubs)
names(nomes_e_links_rpubs)
nomes_e_links_rpubs<-nomes_e_links_rpubs[,c("Nome","link")]

nomes_e_links_rpubs$Nome<-tolower(nomes_e_links_rpubs$Nome)

# Convert First letter of every word to Uppercase in R
library(stringr) 
nomes_e_links_rpubs$Nome<-str_to_title(nomes_e_links_rpubs$Nome)  
nomes_e_links_rpubs$Nome<-gsub("De","de",nomes_e_links_rpubs$Nome)
nomes_e_links_rpubs$Nome<-gsub(" Da"," da",nomes_e_links_rpubs$Nome)


SEQ  <- seq(1,26)
pb   <- txtProgressBar(1, 26, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu9">  <a href="',nomes_e_links_rpubs[i,2],
    '"><br><br><img src="depoimentos.png" alt="',nomes_e_links_rpubs[i,1],'" title="',nomes_e_links_rpubs[i,1],'" />'
    ,nomes_e_links_rpubs[i,1],
    '</a>
      </li>'
)}

cat(dados)
