library(janitor)
library(readxl)
nomes_e_links_rpubs <- read_excel("C:/Users/Hp/Google Drive (steven.ross@uniriotec.br)/2021/primeiro semeste notas/RelatoriodeDiariodeClasseExcel(adm)2.xlsx", 
                             range = "A8:Z45") %>% clean_names()


names(nomes_e_links_rpubs)
nomes_e_links_rpubs<-nomes_e_links_rpubs[,4:5]
nomes_e_links_rpubs<-na.omit(nomes_e_links_rpubs)
names(nomes_e_links_rpubs)
nomes_e_links_rpubs$nome<-tolower(nomes_e_links_rpubs$nome)

# Convert First letter of every word to Uppercase in R
library(stringr) 
nomes_e_links_rpubs$nome<-str_to_title(nomes_e_links_rpubs$nome)  
nomes_e_links_rpubs$nome<-gsub("De","de",nomes_e_links_rpubs$nome)
nomes_e_links_rpubs$nome<-gsub(" Da"," da",nomes_e_links_rpubs$nome)

SEQ  <- seq(1,35)
pb   <- txtProgressBar(1, 35, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu5">  <a href="',nomes_e_links_rpubs[i,2],
    '"><br><br><img src="depoimentos.png" alt="',nomes_e_links_rpubs[i,1],'" title="',nomes_e_links_rpubs[i,1],'" />'
    ,nomes_e_links_rpubs[i,1],
    '</a>
      </li>
    '
)}

cat(dados)
