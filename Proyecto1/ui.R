library(shiny)
library(DT)
library(lubridate)

df <- read.csv('Limitaciones.csv', sep = ';')

shinyUI(fluidPage(
  
  
  titlePanel('Inputs'),
  sidebarLayout(
    sidebarPanel(
      
      sliderInput(
        'bins',
        'Number of bins:',
        min = 1,
        max = 50,
        value = 30
        ),
      
      selectInput(
        'planta',
        'Seleccione Planta',
        choices = factor(df$Planta)
        ),
      
      dateRangeInput(
        'date_range',
        'Seleccione Rango de Fechas',
        min = '2000-01-01',
        max = today(),
        start = today()-30,
        end = today(),
        language = 'es',
        weekstart = 1,
        separator = 'a'
      )
      
    ),
    
    mainPanel(
      DT::dataTableOutput('tabla1')
    )
  )
  
))
