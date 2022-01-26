The clean and raw data and code are available in this repository. The clean data set is also available at Iowa State University's DataShare.

Each experimental unit (eu) data is recorded in one row. Variable explaination in each data sheet is provided below:

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

#### IA_yield.csv from USDA/NASS 
+ State: Iowa
+ County: Name of 99 counties in Iowa
+ Commodity: Crop: corn grain, soybean grain, oat grain, and alfalfa hay
+ Value: Yield in bushel per acre

#### biom_1720.csv and pldens_1720.csv (continued from the general variables list)
+ from SETFA to ARFMI: Bayer codes for weed species names  
+ Total: Whole-community aboveground mass or plant density

#### biom_indices_1720.csv and pldens_indices_1720.csv (continued from the general variables list)
+ sample area (m^2): Sampled area per experimental unit
+ Diversity: Simpson's diversity index, calculated with either individual species aboveoground mass or density
+ Dominance: ???
+ Richness: Number of species 
+ Evenness: Simpson's evenness index, calculated with either individual species aboveoground mass or density
