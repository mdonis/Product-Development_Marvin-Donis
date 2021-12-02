library(shiny)
library(DT)
library(lubridate)

df <- read.csv('Limitaciones.csv', sep = ';')

shinyUI(fluidPage(
  
  
  titlePanel('Inputs'),
  sidebarLayout(
    sidebarPanel(
      
      sliderInput(
        'slider1',
        'Seleccione Nivel de Energía',
        min = -27965,
        max = 340326,
        value = c(1000,250000)
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
        start = today()-1000,
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
