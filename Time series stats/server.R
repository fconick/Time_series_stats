#Load library
library(shiny)

#Load data
DB <- readRDS(file = './Data/DATABASE.RDS')
DB$Date %<>% as.Date 


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  #Run Functions
  source('Functions/Time_series.R')
  source('Functions/Summary_DB.R')
  
  # 1.-Reactive subset according to user choices
  DB1 <- reactive({
    filter(DB, Date >= input$daterange[1] , Date <= input$daterange[2],
           League_G ==  input$League_G)
  })

  # 2.- Reactive selection for TEAMS
  output$secondSelection <- renderUI({
    selectInput("Team", h4("Team:"), 
                choices = DB1()$Team %>%
                  unique %>% sort)
  })
   
  # 3.-  Create the plot using the functions loaded
  output$distPlot <- renderPlot({
     Time_series(DB1(), input$Team, input$Stat, '', input$daterange[1], input$daterange[2])
  })

   
  # 4.- League summary for the period selected
  output$SummaryLeague <- renderTable({
    Summary_DB(DB1())
  })
  
    
})
