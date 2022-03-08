The clean and raw data and code are available in this repository. The data set is also available at Iowa State University's DataShare via <10.25380/iastate.19111376>.


## Clean  

Each experimental unit (eu) data is recorded in one row. Variable explanation in each data sheet is provided below:

#### General variables (column names) that exist in all the data sheets

+ Plot: Two-digit plot identification at the experiment with the first digit represents the block number (1, 2, 3, 4) and the second the plot number (1, 2, ..., 9).
+ Block: Block number (1, 2, 3, 4).
+ Crop: Crop species name.
+ Crop_ID: Alpha-numeric code for the combination of crop species (first letter in species name) and the rotation (2-, 3-, or 4-year rotation) to which they belonged
+ Corn_weed_management: conv or low - the weed management applied to the corn phase.
+ Year: The year that the data was collected, 2017, 2018, 2019, and 2020.
+ Rot: Rotation system: 2-, 3-, or 4-year


#### corn_1720_clean.csv, soybean_1720_clean.csv, oat_g_1720_clean.csv, and alfalfa_1720_clean.csv (continued from the general variables list)
+ Variety: Crop variety name
+ Planted: Planting date
+ Harvested: Harvesting date
+ lb_p_plot: Pound per plot
+ Moisture: Moisture at dried state
+ Standard_moisture: Standard moisture requirement for a specific commodity
+ Standardized_yield_MgpHa: Standardized yield in Mg per hectare
+ bu_p_acre: Yield in bushel per acre  

*In alfalfa_1720_clean only:*  
+ Bale_lbs: Bale weight, in pound
+ Fresh_lb_p_ac: yield in pound per acre, fresh
+ Fresh_ton_p_ac: yield in ton per acre, fresh
+ Dry_ton_p_ac: yield in ton per acre, dried
+ Cut_n: Cut number (1 to 4) 
+ Fresh_MgpHa: yield in Mg per hectare, fresh
+ Dry_MgpHa: yield in Mg per hectare, dried 

#### IA_yield_clean.csv from USDA/NASS 
+ State: Iowa
+ County: Name of 99 counties in Iowa
+ Commodity: Crop: corn grain, soybean grain, oat grain, and alfalfa hay
+ Value: Yield in bushel per acre
+ Yield_Mg_p_ha: Yield in Mg per hectare

#### biom_1720_clean.csv and and pldens_1720_clean.csv (continued from the general variables list)
+ from DIGSA to ARFMI: Bayer codes for weed species names' abbreviation, numbers are either gram per meter squared or plants per meter squared  
+ Total: Whole-community aboveground mass or whole-community plant density, numbers are either gram per meter squared or plants per meter squared  

#### biom_indices_1720_clean.csv and pldens_indices_1720_clean.csv (continued from the general variables list)
+ sample area (m^2): Sampled area per experimental unit
+ Diversity: Simpson's diversity index, calculated with either individual species aboveground mass or density
+ Dominance: Simpson's dominance index
+ Richness: Number of species 
+ Evenness: Simpson's evenness index, calculated with either individual species aboveground mass or density

#### herb_id3.csv: for the associated publication's Table 1 - Crop variety or hybrid and management from 2017 through 2020 field seasons arranged in a grid of 2 x 2 for corn, soybean, oat, and afalfa phases   
+ Year: 2017 to 2020
+ Activity or input: List of crop management activities and inputs
+ Low herbicide (column 3): Details on each activity/input in and follow corn under low herbicide weed management regime
+ Conventional herbicide (column 4): Details on each activity/input in and follow corn under conventional herbicide weed management regime
+ Low herbicide (column 5): Details on each activity/input in and follow soybean that followed corn under low herbicide weed management regime
+ Conventional herbicide (column 6): Details on each activity/input in and follow soybean that followed corn under conventional herbicide weed management regime

#### all-sp.csv: for Table 6 - List of weed species (in alphabetical order) from 2017 through 2020 field season in the associated publication
+ Bayer code: Bayer's five-letter abbreviation for species names
+ Scientific name: Latin names
+ Common name: common names
+ Life cycle: brief description of plant stature and course of time to complete a full generation 

## Raw  
Each experimental unit (eu) data is recorded in one row. Variable explanation in each data sheet is provided below:

### Weed-aboveground  

These data sheets below were manipulated using the script in <https://github.com/hnguyen19/Weed-community/blob/master/4-Data-wrangling/clean-weed-data.R>

#### biom_17.csv, biom_18.csv, biom19.csv, and biom_20.csv: records in pairs of stand density and dried aboveground mass of all the weed species found from 2017 to 2020 field seasons 
+ Date: date of field survey 
+ Other variables: see "General variables (column names) that exist in all the data sheets"
+ DIGSA to ASCSY: pairs of stand density and dried aboveground mass of each weed species. The numbers are plants and grams. 

### Yields  

These data sheets below were manipulated using the script in <https://github.com/hnguyen19/Weed-community/blob/master/4-Data-wrangling/clean-crop-yields-17-20.R>

#### corn_17_20.csv, soybean_17_20.csv, oat_17_20.csv: corn, soybean, and oat grain yields at the experiment site from 2017 through 2020 field seasons 

#### alfalfa_17_20.csv: alfalfa hay yield at the experiment site from 2017 through 2020 field seasons 

#### oatstraw_17_20.csv: oat straw yield at the experiment site in 2018

#### IA_OAyield.csv: oat straw and alfalfa hay yields in Iowa overall and 99 Iowan counties  
Each row provides a record of crop yield in each county in a year
+ Value: crop yield in bushel per acre
+ Year: year of the record
+ Other variables are explained at <<https://quickstats.nass.usda.gov/results/3D206F23-8AAF-3737-9033-1D81A2208FB9>

#### IA_CSOyield.csv: corn, soybean, and oat grain yields in Iowa overall and 99 Iowan counties
Each row provides a record of crop yield in each county in a year
+ Value: crop yield in bushel per acre
+ Year: year of the record
+ Other variables are explained at <https://quickstats.nass.usda.gov/results/6467D646-F314-33B3-B14D-A73D84313E80>