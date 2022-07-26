
nomes_e_links_rpubs <- data.frame(
  nome = c('Matheus Grismino',
  'Steffany Oliveira',
  'Estefany Ohana',
  'Késia Ribeiro',
  'Thaynara Velasco',
  'Laryssa Willcox',
  'Marcos Tulio'),
  link = c('https://rpubs.com/matheusgrismino/',
    'https://rpubs.com/Steffanyc/',
    'https://rpubs.com/Estefany_Ohana/',
    'https://rpubs.com/kesiaribeiro/',
    'https://rpubs.com/thaynaravelasco/',
    'https://rpubs.com/LWillcox/',
    'https://rpubs.com/Marcostulio/'))
    
names(nomes_e_links_rpubs)
nomes_e_links_rpubs$nome<-tolower(nomes_e_links_rpubs$nome)

# Convert First letter of every word to Uppercase in R
library(stringr) 
nomes_e_links_rpubs$nome<-str_to_title(nomes_e_links_rpubs$nome)  
nomes_e_links_rpubs$nome<-gsub("De","de",nomes_e_links_rpubs$nome)
nomes_e_links_rpubs$nome<-gsub(" Da"," da",nomes_e_links_rpubs$nome)
nomes_e_links_rpubs$nome<-gsub(" Dos"," dos",nomes_e_links_rpubs$nome)


SEQ  <- seq(1,7)
pb   <- txtProgressBar(1, 7, style=3)
dados<-c()
#soh existe de menu 1 ate 9
for(i in SEQ){
  setTxtProgressBar(pb, i)
  dados[i]<-paste0('<li class="menu-bar" id="menu3">  <a href="',nomes_e_links_rpubs[i,2],
    '"><br><br><img src="depoimentos.png" alt="',nomes_e_links_rpubs[i,1],'" title="',nomes_e_links_rpubs[i,1],'" />'
    ,nomes_e_links_rpubs[i,1],
    '</a>
      </li>
    '
)}

cat(dados)

#--------------------------------------------------------------------------------------







