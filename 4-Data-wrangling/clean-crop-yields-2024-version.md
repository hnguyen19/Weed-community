---
title: "Clean crop yields"
date: '2024-04-16'
output: 
  bookdown::html_document2:
    toc: false
    fig_caption: yes
    keep_md: true
    self_contained: true
    number_sections: false
---



### Update to the previous version

This script is a more streamlined version of `clean-crop-yields-17-20.R`. Data was loaded directly from the shared Box folder and curated extensively in R instead of copying and pasting desirable rows and columns. That practice resulted in an error that the standardized crop yields, to industry level moisture, at the experiment site was compared to the 0% moisture published by USDA NASS. This error is corrected here and will reflect in `Crop-yields.Rmd`.

### Raw data
