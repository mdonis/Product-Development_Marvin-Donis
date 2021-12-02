
library(shiny)
library(dplyr)

shinyServer(function(input, output, session) {
  
  data <- reactiveValues(df=read.csv('Limitaciones.csv', sep = ';'), filt = read.csv('Limitaciones.csv', sep = ';'))
  maximo <- reactiveValues(n=0)
  minimo <- reactiveValues(n=100)
  
  observeEvent(input$planta, {
    v1 <- (maximo$n-minimo$n)*0.25+minimo$n
    v2 <- maximo$n - (maximo$n-minimo$n)*0.25
    updateSliderInput(session, 'slider1', 
                      min = minimo$n, 
                      max = maximo$n,
                      value = c(v1,v2)
                      )
  })
  
  #observeEvent(input$planta, {
  #  updateSliderInput(session, 'slider1', max = max(data$df$Energia))
  #})
  
  output$tabla1 <- DT::renderDataTable({
    data$df$Fecha <- as.Date(data$df$Fecha , format = "%d/%m/%y")
    data$df
    
    data$df <- data$df %>%
      filter(Planta == input$planta) %>%
      filter(Fecha >= input$date_range[1] & Fecha <= input$date_range[2]) %>%
      filter(Energia >= input$slider1[1] & Energia <= input$slider1[2])  
    print(data$df)
    
    minimo$n <- min(data$df$Energia, na.rm = TRUE)
    maximo$n <- max(data$df$Energia, na.rm = TRUE)

    data$df %>%
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
