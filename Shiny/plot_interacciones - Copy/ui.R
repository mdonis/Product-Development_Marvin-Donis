
library(shiny)

shinyUI(fluidPage(
  
  
  titlePanel("Interacciones del Usuario con Gráficas"),
  tabsetPanel(
    tabPanel('Gráficas de Shiny',
             h1('Gráficas en Shiny'),
             plotOutput('grafica_base_r'),
             plotOutput('Grafica_ggplot')
             ),
    tabPanel('Interacciones con Plots',
             h1('Interacción'),
             plotOutput('plot_click_option',
                        click = 'clk',
                        dblclick = 'dclk',
                        hover = 'mouse_hover',
                        brush = 'mouse_brush'),
             verbatimTextOutput('click_data'),
             tableOutput('mtcars_tbl')
             )
  )
  
  
))
