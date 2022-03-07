#This script was used to clean yields data from 2017 to 2020.   
# The outputs are corn_1720_clean.csv, soybean_1720_clean.csv, oat_g_1720_clean.csv, and alfalfa_1720_clean.csv for Marsden yield; and IA_yield_clean.csv for Iowa and Boone County yields of the four commodities. 

## Conversion of lbs per acre and bushel per acre to Mg per ha from <https://www.extension.iastate.edu/agdm/wholefarm/html/c6-80.html>

## Conversion from dry ton/ac to Mg/ha for oat with 32.9 lb/bu from our test weight (ISU extension document reads 32)

library(emmeans)
library(here)
library(readr)
library(readxl)
library(data.table)
library(tidyverse)
library(dplyr)
library(stringr)

## Raw data sheets 
corn <-  read_csv("./2-Data/Raw/Yields/corn_17_20.csv")
soy <-  read_csv("./2-Data/Raw/Yields/soybean_17_20.csv")

oat_straw <- read_csv("./2-Data/Raw/Yields/oatstraw_17_20.csv")

oat_grain <- read_csv("./2-Data/Raw/Yields/oat_17_20.csv")

alfalfa <- read_csv("./2-Data/Raw/Yields/alfalfa_17_20.csv")


## Combine all crops to add Crop name and Block number
crops <- rbindlist(list(corn,soy,oat_straw,oat_grain,alfalfa), fill = TRUE)

crops <- crops %>% mutate(Crop = ifelse(startsWith(Crop_ID,"S"),"soybean",
                                        ifelse(startsWith(Crop_ID,"O"),"oat",
                                               ifelse(startsWith(Crop_ID,"C"),"corn","alfalfa"))),
                          Block = ifelse(Plot %in% c(11:19),"1",
                                         ifelse(Plot %in% c(21:29),"2",
                                                ifelse(Plot %in% c(31:39),"3", "4")))) 

## Save each crop yield sheet as a file for crop yield analysis model 

corn_clean <- crops%>%filter(Crop_ID %in% c("C2","C3","C4"))%>%
  keep(~!all(is.na(.)))

soy_clean <- crops%>%filter(Crop_ID %in% c("S2","S3","S4"))%>%
  keep(~!all(is.na(.)))

alfalfa_clean <- crops%>%filter(Crop_ID == "A4")%>%
  keep(~!all(is.na(.)))


oat_clean <- crops%>%filter(Crop == "oat")

oat_clean <- oat_clean %>% 
  mutate(Crop = ifelse(Conversion_factor== 892,"oat grain" , "oat straw"))

oat_clean$Crop <-  oat_clean$Crop %>% replace_na("oat straw")

oat_grain_clean <- oat_clean%>%filter(Crop=="oat grain") %>% keep(~!all(is.na(.)))

oat_straw_clean <- oat_clean%>%filter(Crop=="oat straw") %>% keep(~!all(is.na(.))) # Oat straw yield was not included in the manuscript

#write.csv(corn, "./2-Data/Clean/corn_1720_clean.csv", row.names =  FALSE)
#write.csv(soy, "./2-Data/Clean/soybean_1720_clean.csv", row.names =  FALSE)
#write.csv(alfalfa, "./2-Data/Clean/alfalfa_1720_clean.csv", row.names =  FALSE)
#write.csv(oat_grain_clean , "./2-Data/Clean/oat_g_1720_clean.csv", row.names =  FALSE)
#write.csv(oat_str, "./2-Data/Clean/oat_str_1720_clean.csv", row.names =  FALSE)

## Iowa numbers 


#oat and alfalfa  #<https://quickstats.nass.usda.gov/results/3D206F23-8AAF-3737-9033-1D81A2208FB9>
OA_yield <- read.csv(here("2-Data/Raw/Yields/IA_OAyield.csv"), header  = TRUE)
#corn, soybean, oat  #<https://quickstats.nass.usda.gov/results/6467D646-F314-33B3-B14D-A73D84313E80>
CSO_yield <- read.csv(here("2-Data/Raw/Yields/IA_CSOyield.csv"), header  = TRUE)

#as of Sep 7, 2021, alfalfa hay yield of 2019 and 2020 are not available 
IA_yield <- rbind(OA_yield, CSO_yield)
IA_yield <- distinct(IA_yield)


## "Value" is yield in bushel per acre 
#select a few columns, s stands for select
IA_yield_s <- IA_yield %>%
  dplyr::select(State, County, Commodity, Value, Year) %>%
  mutate(Commodity = tolower(Commodity),
         State = tolower(State), 
         County = tolower(County),
         Year = as.factor(Year)) %>%
  mutate(State = str_to_title(State),
         County = str_to_title(County)) %>%
  mutate(Yield_Mg_p_ha = ifelse(Commodity == "corn", Value * 0.0628,
                                ifelse(Commodity == "soybeans", Value * 0.0673,
                                       ifelse(Commodity == "oats", Value*0.04, Value * 0.9072)))) 

#write.csv(IA_yield_s, here("2-Data/Clean/IA_yield_clean.csv"), row.names = FALSE)