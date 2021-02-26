library(readxl)
nomes_e_links_rpubs<-read_xlsx("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2020/primeiro semestre COVID/NOTAS/notas_ADM_CP.xlsx",
                               sheet="versao final",skip=1)

nomes_e_links_rpubs<-nomes_e_links_rpubs[1:22,]
names(nomes_e_links_rpubs)
nomes_e_links_rpubs<-nomes_e_links_rpubs[,c("Nome","link")]
nomes_e_links_rpubs$link[1]<-"https://rpubs.com/Andressachagas/"
nomes_e_links_rpubs$link[20]<-"https://rpubs.com/ThamaraRodrigues"

View(nomes_e_links_rpubs)

nomes_e_links_rpubs<-nomes_e_links_rpubs[nomes_e_links_rpubs$link!="Sem registro",]
nomes_e_links_rpubs<-na.omit(nomes_e_links_rpubs)


nomes_e_links_rpubs$Nome<-tolower(nomes_e_links_rpubs$Nome)

# Convert First letter of every word to Uppercase in R
library(stringr) 
nomes_e_links_rpubs$Nome<-str_to_title(nomes_e_links_rpubs$Nome)  
nomes_e_links_rpubs$Nome<-gsub("De","de",nomes_e_links_rpubs$Nome)


SEQ  <- seq(1,17)
pb   <- txtProgressBar(1, 17, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id=','menu',sample(1:9,1),'">  <a href="',nomes_e_links_rpubs[i,2],
    '"><br><br><img src="depoimentos.png" alt="',nomes_e_links_rpubs[i,1],'" title="',nomes_e_links_rpubs[i,1],'" />'
    ,nomes_e_links_rpubs[i,1],
    '</a>
      </li>'
)}

dados
