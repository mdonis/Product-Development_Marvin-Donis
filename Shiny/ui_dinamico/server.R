
library(shiny)

shinyServer(function(input, output, session) {
  
  observeEvent(input$min1, {
    updateSliderInput(session, 'slider1', min = input$min1)
  })
  
  observeEvent(input$max1, {
    updateSliderInput(session, 'slider1', max = input$max1)
  })
  
  observeEvent(input$reset, {
    updateSliderInput(session, 's1', value = 10)
    updateSliderInput(session, 's2', value = 10)
    updateSliderInput(session, 's3', value = 10)
    updateSliderInput(session, 's4', value = 10)
    updateSliderInput(session, 's5', value = 10)
  })
  
  observeEvent(input$n, {
    if(is.na(input$n)){
      nombre = 'Correr'
    } else if (input$n==1){
      nombre <- paste('Correr', input$n,'Vez',sep = ' ')
    } else {
    nombre <- paste('Correr', input$n,'Veces',sep = ' ')
    }
    
    updateActionButton(session, 'correr', label = nombre)
  })
  
  observeEvent(input$nvalue,{
    updateNumericInput(session, 'nvalue',value = input$nvalue+1)
  })
  
  observeEvent(input$celcius,{
    f<-round(input$celcius*(9/5)+32)
    updateNumericInput(session,'farenheit',value=f)
  })
  
  observeEvent(input$farenheit,{
    c<-round((input$farenheit-32)*(5/9))
    updateNumericInput(session,'celcius',value=c)
  })
  
  
  observeEvent(input$dist,{
    updateTabsetPanel(session,'params',selected = input$dist)
  })
  
  sample_dist <- reactive({
    switch(input$dist,
           'Normal' = rnorm(n = input$n_random, mean= input$media, sd = input$sd),
           'Uniforme'= runif(input$n_random, input$unif_min, input$unif_max),
           'Exponencial' = rexp(input$n_random, input$razon)
           )
  })
  
  output$plot_dist <- renderPlot({
    hist(sample_dist())
  })
  
})










