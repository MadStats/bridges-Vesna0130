### Read txt files
library(dplyr)
reviewpath <- "~/bridges/2016del" 
completepath <- list.files(reviewpath, pattern = "*.TXT$", full.names = TRUE)  
### Read data 
read.txt <- function(x) {  
  awful.table <- read.table(x, header = FALSE, sep = ",", quote = "",
                            na.strings = "", fill = TRUE, strip.white = TRUE,
                            stringsAsFactors = FALSE)
  colnames(awful.table) <- ifelse(is.na(awful.table[1, ]),
                                  colnames(awful.table), awful.table[1, ])
  awful.table <- awful.table[-1, ]
  return(awful.table)
}  
review <- lapply(completepath, read.txt)  

### Transfer list to data frame
docname <- list.files(reviewpath, pattern = "*.TXT$")  
reviewdf <- Reduce(function(x,y) merge(x,y,all=T), review)
bridge <- select(reviewdf,
                  STATE_CODE_001,
                  STRUCTURE_NUMBER_008,
                  ROUTE_NUMBER_005D,
                  PLACE_CODE_004,
                  YEAR_BUILT_027,
                  YEAR_RECONSTRUCTED_106,
                  DESIGN_LOAD_031,
                  ADT_029,
                  YEAR_ADT_030,
                  DECK_COND_058,
                  SUPERSTRUCTURE_COND_059,
                  SUBSTRUCTURE_COND_060,
                  CHANNEL_COND_061,
                  CULVERT_COND_062)
