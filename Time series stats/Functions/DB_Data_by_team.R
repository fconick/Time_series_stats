#------------------------------------------------------------------------------
#                           Plot function
#------------------------------------------------------------------------------

# library(tidyverse)
# 
# Data <- read.csv(file = '~/Results_Scraper/ALL LEAGUES/All_leagues.csv')
# general_vars <- c('Id', 'League', 'Date', 'Stage', 'Substage', 'League_G')
# Home_vars <- c('Home', 'G_Home')
# Away_vars <- c('Away', 'G_Away')
# Rename <- c( 'Goals')

Data_by_team <- function(Data, Home_vars, Away_vars, Rename){
  
  #rename column names of the data
  Team_vars_replace <- c('Team', paste(Rename, 'Scored', sep ='_'))
  Opponent_vars_replace <- c('Opponent', paste(Rename, 'Received', sep ='_'))
  
  #1 .- Home teams data
  
  #Organize the Home Data
  Data_home <- Data
  Data_home$H_A <- 'Home'
  
  
  #Rename columns
  for( i in 1: length(Home_vars_replace)){
    colnames(Data_home)[colnames(Data_home)==Home_vars[i]] <- Team_vars_replace[i]
    colnames(Data_home)[colnames(Data_home)==Away_vars[i]] <- Opponent_vars_replace[i]
  }
  
  #2.- Away teams data
  
  #Organize the Home Data
  Data_away <- Data
  Data_away$H_A <- 'Away'
  
  #Rename columns
  for( i in 1: length(Home_vars_replace)){
    colnames(Data_away)[colnames(Data_away)==Away_vars[i]] <- Team_vars_replace[i]
    colnames(Data_away)[colnames(Data_away)==Home_vars[i]] <- Opponent_vars_replace[i]
  }
    
  #3.- Join the data
  All_data <- rbind(Data_home, Data_away)
  
}