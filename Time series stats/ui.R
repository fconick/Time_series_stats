
library(shiny)

DB <- readRDS(file = './Data/DATABASE.RDS')
DB$Date %<>% as.Date 
# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
  
  # Application title
  includeCSS("styles.css"),

  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel( width = 3,
      
      selectInput("League_G", label = h4("League:"), 
                             choices = unique(DB$League_G), selected = 1),
                 
      dateRangeInput("daterange", "Date range :", 
                     start = "2016-01-29",
                     end = Sys.Date()),
      
  
      h6(tableOutput("SummaryLeague"), align = "right"),
      
      
     
      uiOutput("secondSelection"), 
                 
      selectInput("Stat", label = h4('Statistic:'), 
                             choices = c('Goals Difference'="Dif", 
                                         'Goals Scored'='Goals_Scored',
                                         'Goals Received'='Goals_Received'),
                             selected = 1)
                 
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      headerPanel(h2("Time series for Soccer Teams", align = "center")),
       plotOutput("distPlot")
       
    )
  )
))
