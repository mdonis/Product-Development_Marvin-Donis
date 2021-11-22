
library(shiny)

shinyUI(fluidPage(
  titlePanel("UI Dinamico"),
  tabsetPanel(
    tabPanel("Ejemplo 1",
             numericInput('min1','Limite Inferior',value=5),
             numericInput('max1','Limite Superior',value=10),
             sliderInput('slider1','Seleccione Valor',
                         min=0,max=15,value=5)
             ),
    tabPanel("Ejemplo 2", 
             sliderInput('s1','Selecciones Valor',min=5,max=15,value=10),
             sliderInput('s2','Selecciones Valor',min=5,max=15,value=10),
             sliderInput('s3','Selecciones Valor',min=5,max=15,value=10),
             sliderInput('s4','Selecciones Valor',min=5,max=15,value=10),
             actionButton('reset','Reiniciar')
             ),
    tabPanel("Ejemplo 3", 
             numericInput('n','Corridas',value=10),
             actionButton('correr','Correr')
             ),
    tabPanel("Ejemplo 4", 
             numericInput('nvalue','Valor',value=0)
             ),
    tabPanel("Ejemplo 5", 
             numericInput('celcius','Temperatura en Celcius',value=NA),
             numericInput('farenheit','Temperatura en Farenheit',value=NA)
             ),
    tabPanel("Ejemplo 6", 
             br(),#espacio
             selectInput('dist','Seleccione Distribución',
                         choices = c('Normal','Uniforme','Exponencial')),
             numericInput('n_random','Cuántos Números Aleatorios',value = 100,min=0),
             
             hr(),#linea horizontal
             tabsetPanel(id = 'params',
                         type = 'hidden',
                         tabPanel('Normal',
                                  h1('Distribución Normal'),
                                  numericInput('media','media',value=0),
                                  numericInput('sd','sd',value=1)
                                  ),
                         tabPanel('Uniforme',
                                  h1('Distribución Uniforme'),
                                  numericInput('unif_min','minimo',value=0),
                                  numericInput('unif_max','máximo',value=1)
                                  ),
                         tabPanel('Exponencial',
                                  h1('Distribución Exponencial'),
                                  numericInput('razon','razón',value=1,min=0)
                                  )
                         ),
             plotOutput('plot_dist')
             )
    )
))
