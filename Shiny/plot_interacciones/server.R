
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
  
  output$grafica_base_r <- renderPlot({
    plot(mtcars$wt, mtcars$mpg, xlab='wt', ylab='Millas por Galón')
  })
  
  output$Grafica_ggplot <- renderPlot({
    diamonds %>%
      ggplot(aes(x=carat, y=price, color=color))+
      geom_point()+
      xlab('Precio')+
      ylab('Kilates')+
      ggtitle('Precio de Diamantes por Kilate')
  })
  
  
  
  output$plot_click_option <- renderPlot({
    plot(mtcars$wt, mtcars$mpg, xlab='wt', ylab='Millas por Galón',pch = 19)
    f <- brushedPoints(mtcars, input$mouse_brush,xvar='wt',yvar='mpg')
    points(f$wt, f$mpg, col = 'green', pch = 19)
  })
  
  output$click_data <- renderPrint({
    list(
      click_xy = c(input$clk$x, input$clk$y),
      double_click_xy = c(input$dclk$x, input$dclk$y),
      hover_xy = c(input$mouse_hover$x, input$mouse_hover$y),
      brush_xy = c(input$mouse_brush$xmin, input$mouse_brush$ymin, 
                   input$mouse_brush$xmax, input$mouse_brush$ymax)
    )
    
  })
  
  
  output$mtcars_tbl <- renderTable({
    #df <- nearPoints(mtcars, input$mouse_hover, xvar='wt', yvar='mpg')
    df <- brushedPoints(mtcars, input$mouse_brush,xvar='wt',yvar='mpg')
    df
  })
  
  
  
})
