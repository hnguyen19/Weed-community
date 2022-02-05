## The codes are ordered chronologically. 

library(patchwork)
library(emmeans)

###~~~~~~~~~~ File name: Population-sex-biom-dens.Rmd ~~~~~~~~###
### Effects of crop ID, corn weed management, population aboveground mass, population density, and their interaction (when applicable) on community diversity, evenness, and richness. 

### Figure 2 was made with a customized function based on emmeans::plot() 

arrow_plot <- function(data,title_p, x_label){
  plot(data, comparisons = TRUE) + 
    theme_bw() + 
    theme(text=element_text(size=14))+
    coord_flip() +
    xlab(x_label) +
    ylab("") +
    ggtitle(title_p)
}

