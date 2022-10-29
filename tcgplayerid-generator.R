library(flexdashboard)
library(knitr)
library(DT)
library(rpivotTable)
library(ggplot2)
library(openintro)
library(highcharter)
library(dplyr)
library(tidyverse)
library(plotly)
library(maps)
library(httr)
library(jsonlite)


# $url = 'https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=false&order=set&page=0&q=' . urlencode($query) . '%20lang=en&unique=prints';


### PULL ALL ENGLISH

end = 318
library(jsonlite)

baseurl <- "https://api.scryfall.com/cards/search?format=json&include_extras=false&include_multilingual=false&order=set&page="
pages <- list()
for(i in 0:end){
  fullScryfall <- fromJSON(paste0(baseurl, i, "&q=%20lang=en&unique=prints"), flatten=TRUE)
  message("Pulling from Scryfall, page ", i)
  pages[[i+1]] <- fullScryfall$data
}

### PULL JAPANESE ARCHIVES

# https://api.scryfall.com/cards/search?format=json&q=set:MRD%20lang=en&page=1

end = 1

baseurl <- "https://api.scryfall.com/cards/search?format=json&q=set:sta&unique=art&page="
pagesJP <- list()
for(i in 1:end){
  fullScryfall <- jsonlite::fromJSON(paste0(baseurl, i), flatten=TRUE)
  message("Pulling from Scryfall, page ", i)
  pagesJP[[i+1]] <- fullScryfall$data
}

### PULL SAHEELI

end = 1

baseurl <- "https://api.scryfall.com/cards/search?format=json&q=set:pwar&unique=art&page="
pagesJP <- list()
for(i in 1:end){
  fullScryfall <- jsonlite::fromJSON(paste0(baseurl, i), flatten=TRUE)
  message("Pulling from Scryfall, page ", i)
  pagesJP[[i+1]] <- fullScryfall$data
}

library(plyr)
scryfallDataPWAR <- rbind.fill(pagesJP)

scryfallDataPWAR <-data.frame(lapply(scryfallDataPWAR, as.character), stringsAsFactors=FALSE)


scryfallTest <- rbind.fill(fullScryfall, scryfallDataPWAR)


write.csv(scryfallDataPWAR,"~/Documents/GitHub/mtg/ScryfallJPPWAR.csv", row.names = TRUE)
