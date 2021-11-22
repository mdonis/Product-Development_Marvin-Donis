
library(shiny)
library(DT)

shinyUI(fluidPage(
  
  
  titlePanel("Tablas en DT"),
  tabsetPanel(
    tabPanel('Tablas DT',
             h1('Vista Básica'),
             DT::dataTableOutput('tabla1'),
             h1('Filtros'),
             DT::dataTableOutput('tabla2')
             ),
    tabPanel('click en tablas',
             ### Selección por fila
             fluidRow(
               column(6,
                      h2('Single Select Row'),
                      DT::dataTableOutput('tabla3'),
                      verbatimTextOutput('output1')
                      ),
               column(6,
                      h2('Multiple Select Row'),
                      DT::dataTableOutput('tabla4'),
                      verbatimTextOutput('output2')
                      )
             ),
             
             fluidRow(
               column(6,
                      h2('Single Select Column'),
                      DT::dataTableOutput('tabla5'),
                      verbatimTextOutput('output3')
               ),
               column(6,
                      h2('Multiple Select Column'),
                      DT::dataTableOutput('tabla6'),
                      verbatimTextOutput('output4')
               )
             ),
             
             fluidRow(
               column(6,
                      h2('Single Select Cell'),
                      DT::dataTableOutput('tabla7'),
                      verbatimTextOutput('output5')
               ),
               column(6,
                      h2('Multiple Select Cell'),
                      DT::dataTableOutput('tabla8'),
                      verbatimTextOutput('output6')
               )
             ),
             
             fluidRow(
               column(6,
                      h2('Single Select Column+Row'),
                      DT::dataTableOutput('tabla9'),
                      verbatimTextOutput('output7')
               ),
               column(6,
                      h2('Multiple Select Column+Row'),
                      DT::dataTableOutput('tabla10'),
                      verbatimTextOutput('output8')
               )
             )
             
             
             )
  )
  
))
