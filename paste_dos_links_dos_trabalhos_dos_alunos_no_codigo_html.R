
library(readr)
nomes_e_links_rpubs <- read_delim("C:/Users/Steven/Dropbox/2019/2 semestre/nomes_e_links_rpubs.csv", 
                                  ";", escape_double = FALSE, trim_ws = TRUE)
View(nomes_e_links_rpubs)

SEQ  <- seq(1,33)
pb   <- txtProgressBar(1, 33, style=3)
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

