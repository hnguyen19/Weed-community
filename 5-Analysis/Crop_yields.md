---
output: 
  # bookdown::pdf_document2: 
  #   keep_tex: yes
  #   toc: false
  #   number_sections: false
  #   extra_dependencies: ["float"]
  bookdown::html_document2:
    toc: false
    fig_caption: yes
    number_sections: false
    keep_md: true
    self_contained: true
#bibliography: ecol.bib
---


 






`oat.lmer` run, erroneously, because one crop ID was mislabeled. 


``` r
table(oat$Crop_ID, oat$Year)
```

```
##     
##      2017 2019 2020
##   O3    4    4    3
##   O4    4    4    5
```





#### How did rotation system and corn weed management affect crop yields? {-}   

Results of the experiment indicated that crop diversification and reduced use of herbicides were not associated with lower crop yields (Table \@ref(tab:crop-jt-ct)). Averaged over four years, soybean was the only crop whose yield was affected by rotation (p = 0.0191, Table \@ref(tab:crop-jt-ct)). Soybean yield was 16% higher in the 4-year rotation than in the 2-year rotation (p = 0.0181). Crop yields in the experiment were as high or higher than the averages for the state of Iowa and Boone County (Figure \@ref(fig:crop-bar)). 

<table style="NAborder-bottom: 0;">
<caption>(\#tab:crop-jt-ct)Contrasts of rotation effect (expressed by Crop ID) on crop yields. The abbreviations on the contrast column are crop identities, which are the combinations of the first letter in crop species names and the rotation in which it occurred.</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="5"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">ANOVA</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Comparison</div></th>
</tr>
  <tr>
   <th style="text-align:left;"> Source of variation </th>
   <th style="text-align:right;"> df1 </th>
   <th style="text-align:right;"> df2 </th>
   <th style="text-align:right;"> F </th>
   <th style="text-align:right;"> p </th>
   <th style="text-align:left;"> contrast </th>
   <th style="text-align:right;"> ratio </th>
   <th style="text-align:right;"> p </th>
  </tr>
 </thead>
<tbody>
  <tr grouplength="3"><td colspan="8" style="border-bottom: 1px solid;"><strong>(A) - Corn</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Crop ID </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3.19 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.1138 </td>
   <td style="text-align:left;"> C2 vs C3 </td>
   <td style="text-align:right;"> 0.94 </td>
   <td style="text-align:right;"> 0.1882 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Corn weed management </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.32 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.6088 </td>
   <td style="text-align:left;"> C2 vs C4 </td>
   <td style="text-align:right;"> 0.93 </td>
   <td style="text-align:right;"> 0.1278 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Crop ID x Corn weed management </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2.20 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.1914 </td>
   <td style="text-align:left;"> C3 vs C4 </td>
   <td style="text-align:right;"> 0.99 </td>
   <td style="text-align:right;"> 0.9507 </td>
  </tr>
  <tr grouplength="3"><td colspan="8" style="border-bottom: 1px solid;"><strong>(B) - Soybean</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Crop ID </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 8.22 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.0191 </td>
   <td style="text-align:left;"> S2 vs S3 </td>
   <td style="text-align:right;"> 0.96 </td>
   <td style="text-align:right;"> 0.5499 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Corn weed management </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0.18 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.7018 </td>
   <td style="text-align:left;"> S2 vs S4 </td>
   <td style="text-align:right;"> 0.86 </td>
   <td style="text-align:right;"> 0.0181 </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Crop ID x Corn weed management </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 0.62 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.5677 </td>
   <td style="text-align:left;"> S3 vs S4 </td>
   <td style="text-align:right;"> 0.90 </td>
   <td style="text-align:right;"> 0.0670 </td>
  </tr>
  <tr grouplength="1"><td colspan="8" style="border-bottom: 1px solid;"><strong>(C) - Oat</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> Crop ID </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1.14 </td>
   <td style="text-align:right;border-right:1px solid;"> 0.3979 </td>
   <td style="text-align:left;"> O3 vs O4 </td>
   <td style="text-align:right;"> 0.91 </td>
   <td style="text-align:right;"> 0.3979 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<span style="font-style: italic;">Note: </span> <sup></sup> Corn weed management: low herbicide or conventional. Crop ID: crop species and the cropping system in which it occurred: C2 - corn in the 2-year rotation, C3 - corn in the 3-year rotation, C4 - corn in the 4-year rotation, S2 - soybean in the 2-year rotation, S3 - soybean in the 3-year rotation, S4 - soybean in the 4-year rotation, O3 - oat in the 3-year rotation, and O4 - oat in the 4-year rotation.</td></tr></tfoot>
</table>








Erroneous yields from incorrect conversion factor applied on hay


``` r
IA_avg_yield 
```

```
## # A tibble: 4 × 3
##   Commodity IA_avg IA_sd
##   <chr>      <dbl> <dbl>
## 1 corn       11.9  1.29 
## 2 hay         3.27 0.575
## 3 oats        2.86 0.621
## 4 soybeans    3.69 0.327
```


``` r
Boone_yield
```

```
## # A tibble: 4 × 3
##   Commodity Boone_avg Boone_sd
##   <chr>         <dbl>    <dbl>
## 1 corn          11.7     1.01 
## 2 hay            3.04   NA    
## 3 oats           3.66    1.18 
## 4 soybeans       3.61    0.189
```



<div class="figure">
<img src="Crop_yields_files/figure-html/crop-bar-1.png" alt="Mean crop yields by rotation from 2017 to 2020. The color-coded bars show crop yields (Mg ha$^-1$) in the experiment plots. The error bars show the 95% confidence intervals. The solid horizontal lines show mean yields for Iowa and dashed lines show mean yields for Boone County. Corn, soybean, and alfalfa yields in the experiment were averaged over four years, oat grain yields in the experiment were averaged over 2017, 2019, and 2020 because in 2018 oat was harvested for hay. Boone County and Iowa hay yields were averaged over 2017 and 2018 because 2019 and 2020 yields were not available at this writing."  />
<p class="caption">(\#fig:crop-bar)Mean crop yields by rotation from 2017 to 2020. The color-coded bars show crop yields (Mg ha$^-1$) in the experiment plots. The error bars show the 95% confidence intervals. The solid horizontal lines show mean yields for Iowa and dashed lines show mean yields for Boone County. Corn, soybean, and alfalfa yields in the experiment were averaged over four years, oat grain yields in the experiment were averaged over 2017, 2019, and 2020 because in 2018 oat was harvested for hay. Boone County and Iowa hay yields were averaged over 2017 and 2018 because 2019 and 2020 yields were not available at this writing.</p>
</div>


