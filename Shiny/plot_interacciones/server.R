
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
  
  # gráfica interactiva de colores
  selected <- reactiveVal(rep(FALSE, nrow(mtcars)))
  
  observeEvent(input$mouse_brush, {
    brushed <- brushedPoints(mtcars, input$mouse_brush, allRows = TRUE)$selected_
    selected(brushed | selected())
  })
  observeEvent(input$plot_reset, {
    selected(rep(FALSE, nrow(mtcars)))
  })
  
  output$plot_click_option <- renderPlot({
    mtcars$sel <- selected()
    ggplot(mtcars, aes(wt, mpg)) + 
      geom_point(aes(colour = sel)) +
      scale_colour_discrete(limits = c("TRUE", "FALSE"))
  }, res = 96)
  
  
  # datos de cursor y tabla
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
    a <- nearPoints(mtcars, input$clk, xvar='wt', yvar='mpg')
    b <- brushedPoints(mtcars, input$mouse_brush,xvar='wt',yvar='mpg')
    df <- rbind(a,b)
    df
  })
  
  
  
})
