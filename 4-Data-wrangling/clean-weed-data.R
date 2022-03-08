# This script produced biom_1720_clean.csv, pldens_1720_clean.csv, biom_indices_1720_clean.csv, and pldens_indices_1720_clean.csv


## List of required packages
library(emmeans)
library(here)
library(MASS)
library(dplyr)
library(lme4)
library(corrr)
library(optimx)
library(psych)
library(data.table)
library(readr)
library(magrittr)
library(readxl)
library(daff)
#options(digits = 5)


# Weeds abbreviations were checked before loading the original data sets. 

#Oats are not weeds, but is coded using bayer's 5-letter code, AVESA, for consistency. This column is oat's post-harvest germination. 

# Some weeds are re-coded as follows

## fescue = FESSP
## maple = ACESP
## cottonwood = POPDE
## unidentified broadleaf = NoIdB
## unidentified grass = NoIdG

## ELYREP = ELYRE
## BRJA = BROJA
## POAPRA = POAPR
## BROINE = BROIN

## FCHGH, a blank column, removed in 2018. This is ECHCG.
## mulberry column is consolidated with MORAL column in 2018.

## rename POPDE as POLPE, Feb 7, 2022

##setwd("./2-Data/Raw/Aboveground")

#All rows are kept, even if summed to zero. 
# All zero rows will be removed for procedures that do not allow all-zero rows and when transformation is not possible. 


#############################################################
### Import raw data
#############################################################

#abg stands for aboveground

abg_17 <- read_excel("./2-Data/Raw/Weed-aboveground/biom_17.xlsx",
                     col_types = c("date", "numeric", "text",  "text", "text", "text", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric",   "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na=".") #72 x 81, the last column is sampled area in m2

abg_17_ordered <- arrange(abg_17, Plot,Side)

abg_17.env <- abg_17_ordered[,c(1:6,81)] #all id columns and sampled area

abg_17.data <- abg_17_ordered[,-c(1:6,81)][,colSums(abg_17_ordered[,-c(1:6,81)]) != 0]



abg_17.data_null <- abg_17_ordered[,-c(1:6,81)][,colSums(abg_17_ordered[,-c(1:6,81)]) == 0]

abg_17.data_m <- data.matrix(abg_17.data)  #sum(abg_17.data_m) matched sum(abg_17.data)

identical(colSums(abg_17.data_m),colSums(abg_17.data)) #TRUE


abg_18 <- read_excel("./2-Data/Raw/Weed-aboveground/biom_18.xlsx", 
                     col_types = c("date", "numeric", "text", "text", "text", "text", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",   "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",   "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",   "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",   "numeric", "numeric", "numeric"), na = ".") #72 x 85 , the last column is sampled area in m2

abg_18_ordered <- arrange(abg_18, Plot,Side)

abg_18.env <- abg_18_ordered[,c(1:6, 85)]
abg_18.data <- abg_18_ordered[,-c(1:6, 85)][,colSums(abg_18_ordered[,-c(1:6, 85)]) != 0]

# rename POPDE as POLPE, Feb 7, 2022
names(abg_18.data)[names(abg_18.data) =="POPDE...77"] <- "POLPE...77"
names(abg_18.data)[names(abg_18.data) =="POPDE...78"] <- "POLPE...78"


abg_18.data_m <- data.matrix(abg_18.data)  #72 x 54

identical(colSums(abg_18.data_m), colSums(abg_18.data)) #true, all columns are in place

abg_19 <- read_excel("./2-Data/Raw/Weed-aboveground/biom_19.xlsx", col_types = c("date",  "numeric", "text", "text", "text", "text", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric"), na = ".") #72 x 85 the last column is sampled area in m2

abg_19_ordered <- arrange(abg_19, Plot,Side)

abg_19.env <- abg_19_ordered[,c(1:6,85)]
abg_19.data <- abg_19_ordered[,-c(1:6,85)][,colSums(abg_19_ordered[,-c(1:6,85)]) != 0] 

abg_19.data_m <- data.matrix(abg_19.data)
colSums(abg_19.data_m) == 0

abg_20 <- read_excel("./2-Data/Raw/Weed-aboveground/biom_20.xlsx", col_types = c("date",  "numeric", "text", "text", "text", "text",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric", "numeric", "numeric", "numeric",  "numeric","numeric", "numeric"), na = ".") # 72x x 89,  the last column is sampled area in m2

abg_20_ordered <- arrange(abg_20, Plot,Side)

abg_20.env <- abg_20_ordered[,c(1:6, 89)]
abg_20.data <- abg_20_ordered[,-c(1:6, 89)][,colSums(abg_20_ordered[,-c(1:6, 89)]) != 0] # 72 x 48
abg_20.data_m <- data.matrix(abg_20.data)

#save biomass to one sheet
abg_17_biom <- abg_17.data_m[ ,rep(c(FALSE,TRUE),22) ]
abg_18_biom <- abg_18.data_m[ ,rep(c(FALSE,TRUE),27) ]
abg_19_biom <- abg_19.data_m[ ,rep(c(FALSE,TRUE),19) ]
abg_20_biom <- abg_20.data_m[ ,rep(c(FALSE,TRUE),24) ]

#save counts to another sheet
abg_17_nopl <- abg_17.data_m[ ,rep(c(TRUE, FALSE),22) ]
abg_18_nopl <- abg_18.data_m[ ,rep(c(TRUE, FALSE),27) ]
abg_19_nopl <- abg_19.data_m[ ,rep(c(TRUE, FALSE),19) ]
abg_20_nopl <- abg_20.data_m[ ,rep(c(TRUE, FALSE),24) ]

## test if data columns match id columns



## R added column numbers to the original col names to prevent duplication so number of plant and biomass columns have to be handled separately as follow.
## keep column names to 5 characters

colnames(abg_17_nopl) <- strtrim(colnames(abg_17_nopl),5)
colnames(abg_18_nopl) <- strtrim(colnames(abg_18_nopl),5)
colnames(abg_19_nopl) <- strtrim(colnames(abg_19_nopl),5)
colnames(abg_20_nopl) <- strtrim(colnames(abg_20_nopl),5)


colnames(abg_17_biom) <- strtrim(colnames(abg_17_biom),5)
colnames(abg_18_biom) <- strtrim(colnames(abg_18_biom),5)
colnames(abg_19_biom) <- strtrim(colnames(abg_19_biom),5)
colnames(abg_20_biom) <- strtrim(colnames(abg_20_biom),5)



#############################################################
### Merge 4 years, separate by mass and stand count
#############################################################

## add historical herbicide information

### to 17 (since the 2017 data sheet has soybean identified by present, not 2016 and earlier herbicide)
abg_17.env <- abg_17.env %>%
  mutate(Corn_weed_management = ifelse(Crop =="soybean", "m", `Herbicide treatment`), #m stands for "to modify"
         Rot_n = as.numeric(substr(.$`Rotation treatment`,2,3)),
         Corn_weed_management = tolower(Corn_weed_management),
         Year = year(Date),
         Block = ifelse(Plot %in% c(11:19),"1",
                        ifelse(Plot %in% c(21:29),"2",
                               ifelse(Plot %in% c(31:39),"3", "4"))))

#identify herbicide regime in each crop
corn_h <- abg_17.env %>%
  filter(Crop == "corn") %>%
  mutate(id = paste(.$Block,.$Rot_n,.$Side))


soy_h <- abg_17.env %>%
  filter(Crop == "soybean") %>%
  mutate(id = paste(.$Block,.$Rot_n,.$Side))

cs_17 <- inner_join(corn_h ,soy_h, by = "id")

cs_17$Corn_weed_management.y <- cs_17$Corn_weed_management.x

soy_17_herb_hist <- cs_17 %>%
  dplyr::select(Crop.y,Corn_weed_management.y ,Plot.y,Side.y,id) # herb_history matches Corn_weed_management

soy_17_all_herb <- inner_join(soy_h,soy_17_herb_hist,by="id") # herb_history matches Corn_weed_management

soy_17_clean <- soy_17_all_herb %>%
  dplyr::select(Crop,Plot,Side,id,Corn_weed_management.y, Year)

biom_17_test <- full_join(abg_17.env, soy_17_clean, by=c("Plot","Side", "Year")) #merge the historical herbicide to original sheet

biom_17.env <- biom_17_test %>%
  mutate(Corn_weed_management = ifelse(Corn_weed_management =="m",Corn_weed_management.y,Corn_weed_management),
         Corn_weed_management = tolower(Corn_weed_management)) %>% 
  dplyr::select(-c(Crop.y, id, Corn_weed_management.y)) #get the relevant cols only

colnames(biom_17.env)[4] <- "Crop"
colnames(biom_17.env)[5] <- "Crop_ID"
colnames(biom_17.env)[6] <- "actual_Herb" # at this point, the df is 72 x 11



### to 18 

colnames(abg_18.env)[6] <- "Corn_weed_management" #weed management regime applied to the corn phase of the rotation
colnames(abg_18.env)[5] <- "Crop_ID"

biom_18.env <- abg_18.env %>%
  mutate(actual_Herb = ifelse(Crop == "soybean", "conv", Corn_weed_management),
         Rot_n = as.numeric(substr(.$Crop_ID,2,3)),
         Corn_weed_management = tolower(Corn_weed_management),
         Year = year(Date),
         Block = ifelse(Plot %in% c(11:19),"1",
                        ifelse(Plot %in% c(21:29),"2",
                               ifelse(Plot %in% c(31:39),"3", "4"))))



### to 19

colnames(abg_19.env)[6] <- "Corn_weed_management"
colnames(abg_19.env)[5] <- "Crop_ID"
biom_19.env <- abg_19.env%>%
  mutate(actual_Herb = ifelse(Crop == "soybean", "conv", Corn_weed_management),
         Rot_n = as.numeric(substr(.$Crop_ID,2,3)),
         Corn_weed_management = tolower(Corn_weed_management),
         Year = year(Date),
         Block = ifelse(Plot %in% c(11:19),"1",
                        ifelse(Plot %in% c(21:29),"2",
                               ifelse(Plot %in% c(31:39),"3", "4")))) 

## add CF to 20, forage quadrats were smaller than ones used in previous years.

colnames(abg_20.env)[5] <- "Crop_ID"

# `Herbicide treatment` in this dataset was corn_weed_management.
biom_20.env <- abg_20.env %>%
  mutate(`Herbicide treatment` = tolower(`Herbicide treatment`),
         Corn_weed_management = `Herbicide treatment`,  ## fix herbicide identity,Herbicide treatment is actually weed management regime applied to the corn phase of the rotation
         actual_Herb = ifelse(Crop == "soybean", "conv", Corn_weed_management ),
         Rot_n = as.numeric(substr(.$Crop_ID,2,3)),
         Year = year(Date),
         Block = ifelse(Plot %in% c(11:19),"1",
                        ifelse(Plot %in% c(21:29),"2",
                               ifelse(Plot %in% c(31:39),"3", "4")))) %>%
  dplyr::select(-`Herbicide treatment`) #72 x 11


#############################################################
### Test if biom and nopl sets have zeros and non-zeros at the right place
#############################################################
# replace non-zero with 1 to check for discrepancy between biomass and number of plant columns
# This zero vs non-zero trick checks Richness 

biom_17_TF <- abg_17.data %>%
  mutate_if(is.numeric, ~1 * (. != 0))
colnames(biom_17_TF) <- strtrim(colnames(biom_17_TF),5)
biom_17_TF_odd <- biom_17_TF[ ,rep(c(TRUE, FALSE),22) ]
biom_17_TF_even <- biom_17_TF[ ,rep(c(FALSE,TRUE),22) ]
sum(biom_17_TF_odd - biom_17_TF_even) # no  discrepancy
render_diff(diff_data(biom_17_TF_odd , biom_17_TF_even))

biom_18_TF <- abg_18.data %>%
  mutate_if(is.numeric, ~1 * (. != 0))
colnames(biom_18_TF) <- strtrim(colnames(biom_18_TF),5)
biom_18_TF_odd <- biom_18_TF[ ,rep(c(TRUE, FALSE),27) ]
biom_18_TF_even <- biom_18_TF[ ,rep(c(FALSE,TRUE),27) ]
render_diff(diff_data(biom_18_TF_odd, biom_18_TF_even)) # no  discrepancy 


biom_19_TF <- abg_19.data %>%
  mutate_if(is.numeric, ~1 * (. != 0))
colnames(biom_19_TF) <- strtrim(colnames(biom_19_TF),5)
biom_19_TF_odd <- biom_19_TF[ ,rep(c(TRUE, FALSE),19) ]
biom_19_TF_even <- biom_19_TF[ ,rep(c(FALSE,TRUE),19) ] 

render_diff(diff_data(data_ref = biom_19_TF_odd, 
                      data = biom_19_TF_even)) #row 15, ABUTH, 2 plants but they did not register on the scale so 0 in weight


biom_20_TF <- abg_20.data %>%
  mutate_if(is.numeric, ~1 * (. != 0))
colnames(biom_20_TF) <- strtrim(colnames(biom_20_TF),5)
biom_20_TF_odd <- biom_20_TF[ ,rep(c(TRUE, FALSE),24) ]
biom_20_TF_even <- biom_20_TF[ ,rep(c(FALSE,TRUE),24) ]


render_diff(diff_data(data_ref = biom_20_TF_odd,
                      data = biom_20_TF_even)) # row 29 AVESA, fixed Aug 1, 2021,BUT AVESA shouldn't matter
setdiff(biom_20_TF_odd , biom_20_TF_even) # no discrepancy

#############################################################
### Data check: save mass and number of plant here to manually calculate in Excel
#############################################################
# Richness will be calculated with number of plant data set because of ABUTH in the 2019 data set.

# Test the calculation of Richness, Dominance, Simpson diversity and Simpson evenness indices on the 2020 data
biom_20 <- cbind(biom_20.env , abg_20_biom); nopl_20 <- cbind(biom_20.env , abg_20_nopl)

#nopl_20$Richness <- rowSums(nopl_20[,-c(1:11, 35)]!=0) #matched excel countif function's result

#write.csv(nopl_20, here("2-Data/Raw/noplant_2020_draft.csv"), row.names = F) #R and excel Richness calculations matched
# biomass evenness and diversity 
# View(abg_20_biom)
# total biomass per EU
abg_20_biom_df <- abg_20_biom %>%
  as.data.frame() %>%
  dplyr::select(-AVESA)

abg_20_biom_df$Total <- rowSums(abg_20_biom_df)

# convert to plant/m2 
biom20_per_unit_area <- sweep(abg_20_biom,1,biom_20.env$`sample area (m^2)`,"/")


# density evenness and diversity  
abg_20_nopl_df <- abg_20_nopl %>%
  as.data.frame() %>%
  dplyr::select(-AVESA)

abg_20_nopl_df$Total <- rowSums(abg_20_nopl_df) # matched Excel calculation  
biom_20.env$CF <- 1/biom_20.env$`sample area (m^2)` # CF: conversion factor = 1/sample area

# convert number of plant of each species to density: plants/m2  
abg_20_nopl_convert_1 <- sweep(abg_20_nopl_df, 1, biom_20.env$CF, "*")

abg_20_nopl_convert_2 <- sweep(abg_20_nopl_df, 1, biom_20.env$`sample area (m^2)`, "/")

render_diff(diff_data(data_ref = abg_20_nopl_convert_1,
                      data = abg_20_nopl_convert_1)) #two conversions matched, and both matched excel calculation 

# species contribution, in proportion
abg_20_nopl_prop <- sweep(abg_20_nopl_convert_1, 1, abg_20_nopl_convert_1$Total, "/") #matched Excel species_p

abg_20_nopl_prop_sq <- abg_20_nopl_prop^2 #matched Excel species_p^2

abg_20_nopl_prop_sq$Dominance <- rowSums(abg_20_nopl_prop_sq[,1:23]) #matched Excel.  

abg_20_nopl_prop_sq$Diversity <- 1/abg_20_nopl_prop_sq$Dominance #matched Excel  


#############################################################
### calculate ecological indices in the biomass data sheet, 2017 to 2020 together 
############################################################# 
## Dominance, Diversity, Evenness only, because of ABUTH in 2019 (line 252)

abg_17_biom_df <- abg_17_biom %>% as.data.frame()
abg_18_biom_df <- abg_18_biom %>% as.data.frame()
abg_19_biom_df <- abg_19_biom %>% as.data.frame()
abg_20_biom_df <- abg_20_biom %>% as.data.frame()

biom_17_20 <- rbindlist(list(abg_17_biom_df, 
                             abg_18_biom_df,
                             abg_19_biom_df,
                             abg_20_biom_df),
                        use.names = TRUE ,fill = TRUE)
# replace all NAs with zeros. NAs were generated from some species missing in some years
biom_17_20_df <-  biom_17_20 %>% 
  replace(is.na(.), 0) %>%
  dplyr::select(-AVESA) #remove oat from all the calculations

biom_17_20_df$Total <- rowSums(biom_17_20_df)
biom_17_20_df_others <-  biom_17_20_df %>%
  mutate(TOPS = AMATA + CHEAL + DIGSA + ECHCG + SETFA + SETLU + TAROF,
         OTHERS = Total - TOPS)


env_17_20 <- rbindlist(list(biom_17.env, biom_18.env, biom_19.env, biom_20.env), use.names = TRUE ,fill = TRUE)

env_17_20$CF <- 1/env_17_20$`sample area (m^2)`

# add Sequence variable to 2017 data
temp2017 <- subset(env_17_20, Year == "2017")

temp2017$Sequence <- temp2017$Crop_ID # Sequence is a new variable that identify the starting crop phase as of 2017 in a specific plot. This caries on to subsequent years and stay the same so all crop phases (identified by Crop_ID) within the same rotation at the same physical plot share the same Sequence identification. Crop_ID is the year's crop phase but Sequence was whatsoever grown in 2017. 

Sequence <- rep(temp2017$Sequence, 4)

env_17_20$Sequence <- Sequence

# convert individual species biomass per eu to gram/m2 for each eu   
biom_17_20_g.p.m.sq <- sweep(biom_17_20_df,1,env_17_20$`sample area (m^2)`, "/")


# species proportion
biom_17_20_prop <- sweep(biom_17_20_g.p.m.sq,1,biom_17_20_g.p.m.sq$Total, "/")
# save species proportion for individual species models (Individual-spm.Rmd)
biom_17_20_prop_full <- cbind(env_17_20,  biom_17_20_prop)

#readr::write_csv(biom_17_20_prop_full, here("2-Data/Clean/biom_prop_1720.csv"),col_names = T)

# species proportion squared
biom_17_20_prop_sq <- biom_17_20_prop^2 

# Dominance 
biom_17_20_prop_sq$Dominance <- rowSums(biom_17_20_prop_sq[,1:34]) 

#Diversity 
biom_17_20_prop_sq$Diversity <- 1/biom_17_20_prop_sq$Dominance 

## need richness to calculate evenness, so richness is calculated, noting ABUTH of 2019
#Richness  
biom_17_20_prop_sq$Richness <-   rowSums(biom_17_20_prop_sq[,-c(35:37)]!=0)

#Evenness 
biom_17_20_prop_sq$Evenness <- biom_17_20_prop_sq$Dominance/biom_17_20_prop_sq$Richness


#save species biomass

biom_17_20_g.p.m.sq <- biom_17_20_g.p.m.sq %>% replace(is.na(.), 0)

biom_17_20_full <- cbind(env_17_20,  biom_17_20_g.p.m.sq)

#save species aboveground mass, without Date (Col 1), actual_Herb (Col 6), Rot_n (Col 9), CF - conversion factor (Col 12), and Sequence (Col 13)  
#readr::write_csv(biom_17_20_full[,-c(1,6,9,12,13)], here("2-Data/Clean/biom_1720_clean.csv"),col_names = T)


biom_17_20_indices <- biom_17_20_prop_sq %>% replace(is.na(.), 0)

biom_17_20_indices_full <- cbind(env_17_20,  biom_17_20_indices[,36:39])

#save ecological indices calculated with aboveground mass, without Date (Col 1), actual_Herb (Col 6), Rot_n (Col 9), CF - conversion factor (Col 12), and Sequence (Col 13)  

#readr::write_csv(biom_17_20_indices_full[,-c(1,6,9,12,13)], here("2-Data/Clean/biom_indices_1720_clean.csv"),col_names = T)

#############################################################
### calculate ecological indices in the density data sheet, 2017 to 2020 together 
############################################################# 

## Dominance, Diversity, Evenness AND Richness, because of ABUTH in 2019 (line 252)
## merge all from 17 to 20
abg_17_nopl_df <- abg_17_nopl %>% as.data.frame()
abg_18_nopl_df <- abg_18_nopl %>% as.data.frame()
abg_19_nopl_df <- abg_19_nopl %>% as.data.frame()
abg_20_nopl_df <- abg_20_nopl %>% as.data.frame()

nopl_17_20 <- rbindlist(list(abg_17_nopl_df, 
                             abg_18_nopl_df,
                             abg_19_nopl_df,
                             abg_20_nopl_df),
                        use.names = T ,fill = T)

nopl_17_20_df <- nopl_17_20 %>%  
  replace(is.na(.), 0) %>%
  dplyr::select(-AVESA)

# Total number of plants  
nopl_17_20_df$Total <- rowSums(nopl_17_20_df)


# convert individual species number of individual per eu to stand density (m2) per eu   
nopl_17_20_plant.p.m.sq <- sweep(nopl_17_20_df, 1, env_17_20$`sample area (m^2)`, "/")

# species proportion
nopl_17_20_prop <- sweep(nopl_17_20_plant.p.m.sq, 1, nopl_17_20_plant.p.m.sq$Total, "/")


# save species proportion for individual species models (Individual-spm.Rmd)
nopl_17_20_prop_full <- cbind(env_17_20,  nopl_17_20_prop)

#readr::write_csv(nopl_17_20_prop_full, here("2-Data/Clean/dens_prop_1720.csv"),col_names = T)

# species proportion squared
nopl_17_20_prop_sq <- nopl_17_20_prop^2 


# Dominance 
nopl_17_20_prop_sq$Dominance <- rowSums(nopl_17_20_prop_sq[,1:34]) 

#Diversity 
nopl_17_20_prop_sq$Diversity <- 1/nopl_17_20_prop_sq$Dominance 

#Richness  
nopl_17_20_prop_sq$Richness <-   rowSums(nopl_17_20_prop_sq[,-c(35:37)]!=0)
#Evenness
nopl_17_20_prop_sq$Evenness <- nopl_17_20_prop_sq$Dominance/nopl_17_20_prop_sq$Richness

#save species density, without Date (Col 1), actual_Herb (Col 6), Rot_n (Col 9), CF - conversion factor (Col 12), and Sequence (Col 13)  
pldens_17_20_plant.p.m.sq <- nopl_17_20_plant.p.m.sq %>% replace(is.na(.), 0)

pldens_17_20_full <- cbind(env_17_20,  pldens_17_20_plant.p.m.sq)

#readr::write_csv(pldens_17_20_full[,-c(1,6,9,12,13)], here("2-Data/Clean/pldens_1720_clean.csv"),col_names = T)


#save species density indices, without Date (Col 1), actual_Herb (Col 6),  Rot_n (Col 9), CF - conversion factor (Col 12), and Sequence (Col 13) 

pldens_17_20_indices <- nopl_17_20_prop_sq %>% replace(is.na(.), 0)

pldens_17_20_indices_full <- cbind(env_17_20,  pldens_17_20_indices[,36:39])

#readr::write_csv(pldens_17_20_indices_full[,-c(1,6,9,12,13)], here("2-Data/Clean/pldens_indices_1720_clean.csv"),col_names = TRUE)
