#Plot the stats that you want by Team
library(tidyverse)
library(magrittr)
library(stringr)

#DB <- read.csv(file = 'DATABASE_example.csv', stringsAsFactors = F)
# team <- 'Chelsea'
# Stat <- 'Goals_Scored'
# name_stat <- 'Goals Scored'
# date_inf <- as.Date('2013-06-01')
# date_sup <- as.Date('2017-06-01')

Time_series <- function(DATA, team,  Stat, name_stat, date_inf, date_sup){
  
  #Setting
  theme_set(theme_minimal())
  nice_palette <- c('#00A1CB', '#E54028', '#61AE24', '#616161')
  
  #Subset Data
  DATA$Date %<>%  as.Date
  DATA <- subset(DATA, Team==team & Date >= date_inf & Date <= date_sup)
  DATA$Date %<>%  as.Date
  
  #Add the Label for the Teams in the plot
  DATA$Label <- abbreviate(DATA$Opponent, minlength = 4, use.classes = F,
                           dot = FALSE, strict = FALSE,
                           method = c("left.kept", "both.sides"),
                           named = TRUE)
  
  plot <- ggplot(data = DATA, aes_string(y = Stat, group = 'League',
                                          x ="Date"))  + 
    geom_smooth(colour = '#616161', alpha = .08,size =.2, method ='loess',
                span =.99, level = .5, linetype = 2) +
    geom_line( show.legend = F, colour = 'gray')  +
    geom_point(aes(colour = H_A)) +
    geom_text(aes(label = Label, colour = H_A), show.legend = F,
              nudge_y = .3, nudge_x = -.3 ,check_overlap =  T ) +
    scale_color_manual(values = nice_palette) +
    labs( y = name_stat, x= '', colour = "")
    
  print(plot) 
  
  
}




