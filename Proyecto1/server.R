
library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  
  output$tabla1 <- DT::renderDataTable({
    df <- read.csv('Limitaciones.csv', sep = ';')
    df$Fecha <- as.Date(df$Fecha , format = "%d/%m/%y")
    df %>%
      filter(Planta == input$planta) %>%
      filter(Fecha >= input$date_range[1] & Fecha <= input$date_range[2]) %>%
      DT::datatable(
        rownames = FALSE, 
        filter = 'top',
        ##extensions = 'Buttons',
        options = list(
          pageLength = 10,
          lengthMenu = c(5,10,15)
          ##dom = 'Bfrtip',
          ##buttons = c('csv')
          )
        )
    
  })
  
  
  
})
