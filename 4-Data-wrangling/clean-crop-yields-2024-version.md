---
title: "Clean crop yields"
date: '2024-05-27'
output: 
  bookdown::html_document2:
    toc: false
    fig_caption: yes
    keep_md: true
    self_contained: true
    number_sections: false
---



## Update to the previous version

This script is a more streamlined version of `clean-crop-yields-17-20.R`. Data was loaded directly from the shared Box folder and curated extensively in R instead of copying and pasting desirable rows and columns. That practice resulted in an error that the standardized crop yields, to industry level moisture, at the experiment site was compared to the 0% moisture published by USDA NASS. This error is corrected here and will reflect in `Crop-yields.Rmd`.

## Conversion factor
From <https://www.ers.usda.gov/webdocs/publications/41880/33132_ah697_002.pdf>

Corn, 1 bushel = 56 pounds
Oats, 1 bushel = 32 pounds
Soybean, 1 bushel = 60 pounds
1 metric ton = 2,204.622 pounds
1 U.S. (short) ton = 2,000 pounds
1 pound = 0.00045359237 Mg
1 acre = 0.404686 ha

## NASS county and State yield data

Original links from which csv files were downloaded, as of May 8, 2024:

+ corn and soy: <https://quickstats.nass.usda.gov/results/659D7374-9FE1-3604-82D4-C2F1C4DAB810>

+ oat: <https://quickstats.nass.usda.gov/results/C4885A45-1B6A-3EBA-88CD-4AE88E87176F>

+ alfalfa, whole state only: <https://quickstats.nass.usda.gov/results/79392111-271D-38B9-BBC3-83081D333639>

+ alfalfa, county, available up to 2018 only: <https://quickstats.nass.usda.gov/results/4386A120-915F-351C-A470-E66244312FF1>

Note: choosing non-irrigated yield would not return Iowa.


```
## Rows: 749 Columns: 21
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (12): Program, Period, Geo Level, State, Ag District, County, County ANS...
## dbl  (5): Year, State ANSI, Ag District Code, Value, CV (%)
## lgl  (4): Week Ending, Zip Code, Region, Watershed
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```
## Rows: 151 Columns: 21
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (12): Program, Period, Geo Level, State, Ag District, County, County ANS...
## dbl  (5): Year, State ANSI, Ag District Code, Value, CV (%)
## lgl  (4): Week Ending, Zip Code, Region, Watershed
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


Alfalfa yield by county is available up to 2018, as of May 2024


```
## Rows: 93 Columns: 21
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (12): Program, Period, Geo Level, State, Ag District, County, County ANS...
## dbl  (4): Year, State ANSI, Ag District Code, Value
## lgl  (5): Week Ending, Zip Code, Region, Watershed, CV (%)
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```
## Rows: 4 Columns: 21
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (9): Program, Period, Geo Level, State, watershed_code, Commodity, Data ...
## dbl (3): Year, State ANSI, Value
## lgl (9): Week Ending, Ag District, Ag District Code, County, County ANSI, Zi...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

### Check alfalfa yield in 2017 and 2018: county vs. state average



```
##                            
##                             2017 2018
##   ADAIR                        0    1
##   ALLAMAKEE                    1    1
##   APPANOOSE                    0    1
##   AUDUBON                      1    1
##   BOONE                        0    1
##   CASS                         1    0
##   CHICKASAW                    1    0
##   CLARKE                       0    1
##   CLAY                         0    1
##   CLAYTON                      1    1
##   CLINTON                      1    0
##   DAVIS                        1    1
##   DECATUR                      1    0
##   DELAWARE                     1    0
##   DES MOINES                   1    1
##   DUBUQUE                      1    1
##   EMMET                        1    1
##   FAYETTE                      1    0
##   FRANKLIN                     1    0
##   FREMONT                      1    0
##   GRUNDY                       1    0
##   HAMILTON                     1    1
##   HANCOCK                      1    0
##   HOWARD                       1    0
##   HUMBOLDT                     1    1
##   JACKSON                      1    1
##   JOHNSON                      1    0
##   JONES                        1    0
##   KEOKUK                       0    1
##   LEE                          1    1
##   LINN                         1    0
##   LOUISA                       1    1
##   LYON                         1    1
##   MADISON                      1    0
##   MARION                       1    0
##   MILLS                        0    1
##   MITCHELL                     1    0
##   MONONA                       1    0
##   MONROE                       0    1
##   MONTGOMERY                   1    0
##   O BRIEN                      1    0
##   OTHER (COMBINED) COUNTIES    9    9
##   PALO ALTO                    0    1
##   POLK                         0    1
##   POWESHIEK                    1    0
##   RINGGOLD                     1    1
##   TAYLOR                       0    1
##   UNION                        0    1
##   VAN BUREN                    1    1
##   WAPELLO                      1    0
##   WARREN                       0    1
##   WASHINGTON                   1    0
##   WEBSTER                      1    1
##   WINNEBAGO                    1    1
##   WINNESHIEK                   1    1
##   WORTH                        1    0
##   WRIGHT                       1    1
```

```
## # A tibble: 2 × 2
##    Year Value_m
##   <dbl>   <dbl>
## 1  2017    3.61
## 2  2018    3.59
```


```
## # A tibble: 2 × 3
##   County  Year Value
##   <lgl>  <dbl> <dbl>
## 1 NA      2018  3.2 
## 2 NA      2017  3.08
```
The county-based hay yields were 0.3 - 0.5 ton/ac higher than those of state-based yields.

Use the 2019 and 2020 state-based alfalfa hay yields because county-based values are unavailable. 


### All NASS yield together 



### Write data



## Marsden raw data processing by crop

All dataframes starting with "M" indicate the yield at Marsden.

### Corn

#### 2017

```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2018

```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2019


```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2020


```
## New names:
## • `` -> `...5`
## • `` -> `...16`
## • `` -> `...17`
## • `` -> `...18`
```

#### All corn together




### Soybean

#### 2017

```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2018

```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2019


```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### 2020


```
## New names:
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
```

#### All soybean together





### Oat

from the equipment note: "Grain was harvested with a John Deere 9450 plot combine. Weights, test weight and % moisture taken from the combine." That is the reason why each bushel of oat weights 32.9 lbs instead of 32 lbs as in USDA standard.
USDA standard, as detailed in the conversion factor section, are used to calculate yield in ton/acre at 0%

Any columns after bu/acre at 14% moisture sre about straw

#### 2017

```
## New names:
## • `` -> `...3`
## • `lbs/acre` -> `lbs/acre...5`
## • `% moisture` -> `% moisture...7`
## • `` -> `...11`
## • `` -> `...12`
## • `lbs/acre` -> `lbs/acre...14`
## • `` -> `...17`
## • `% moisture` -> `% moisture...20`
```

#### 2018

Oat was harvested for hay, not grain

#### 2019


```
## New names:
## • `` -> `...3`
## • `lbs/acre` -> `lbs/acre...5`
## • `% moisture` -> `% moisture...7`
## • `` -> `...11`
## • `` -> `...12`
## • `` -> `...13`
## • `` -> `...14`
## • `lbs/acre` -> `lbs/acre...16`
## • `` -> `...19`
## • `% moisture` -> `% moisture...22`
```

#### 2020

To be consistent with previous years, in which oat was harvested on a whole-plot basis, 2020 data are averaged by whole-plot identity


```
## New names:
## • `` -> `...2`
## • `` -> `...4`
## • `lbs/acre` -> `lbs/acre...6`
## • `% moisture` -> `% moisture...7`
## • `` -> `...14`
## • `` -> `...16`
## • `lbs/acre` -> `lbs/acre...18`
## • `` -> `...21`
## • `% moisture` -> `% moisture...24`
```

#### All oat together




### Alfalfa

Whole plots were harvested so there was no distinction of herbicide regimes applied to the corn phase that the alfalfa followed.
`fresh weight (g)`: weight at cutting  
`dry weight (g)`: weight after oven dried to constant value  
`% moisture` = 100 * [`fresh weight (g)` - `dry weight (g)`]/`fresh weight (g)`, as in <https://forages.ca.uky.edu/baleageq27>
Numbers in gram unit were measured in the lab and otherwise in the field. The moisture from lab measurement was used to calculate hay yield at 0% moisture  


#### 2017

```
## New names:
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...13`
## • `` -> `...14`
```

```
## [1] "Block"               "Bale wts (lb)"       "Fresh wt  (lb/acre)"
## [4] "Fresh wt (ton/acre)" "Dry wt (ton/acre)"   "fresh weight (g)"   
## [7] "dry weight (g)"      "% moisture"          "Year"
```

#### 2018

```
## New names:
## • `` -> `...2`
## • `` -> `...3`
```

```
## [1] "Block"               "Bale wts (lb)"       "Fresh wt  (lb/acre)"
## [4] "Fresh wt (ton/acre)" "Dry wt (ton/acre)"   "fresh weight (g)"   
## [7] "dry weight (g)"      "% moisture"          "Year"
```

#### 2019


```
## New names:
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...13`
## • `` -> `...14`
## • `` -> `...15`
```

```
## [1] "Block"               "Bale wts (lb)"       "Fresh wt  (lb/acre)"
## [4] "Fresh wt (ton/acre)" "Dry wt (ton/acre)"   "fresh weight (g)"   
## [7] "dry weight (g)"      "% moisture"          "Year"
```

#### 2020


```
## New names:
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...13`
## • `` -> `...14`
```

```
## [1] "Block"               "Bale wts (lb)"       "Fresh wt  (lb/acre)"
## [4] "Fresh wt (ton/acre)" "Dry wt (ton/acre)"   "fresh weight (g)"   
## [7] "dry weight (g)"      "% moisture"          "Year"
```

#### All alfalfa together 



### Write data


