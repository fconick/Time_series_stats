

Summary_DB <- function(DB){
  
  DB %<>% summarise(
    `Home Team wins` = ((sum(Dif>0 & H_A == 'Home')/ sum(H_A == 'Home')) %>% round(2) * 100) %>% paste0('%'),
    Draws = (mean(Dif == 0) %>% round(2) * 100) %>% paste0('%') ,  
    `Away Team wins` = ((sum(Dif>0 & H_A == 'Away')/ sum(H_A == 'Away')) %>% round(2) * 100) %>% paste0('%'),
    Avg.Goals.per.match = mean(Goals_Scored + Goals_Received) %>% round(2)
    ) %>% t() %>% data.frame 
  
  cbind(`.`=rownames(DB), DB)
}