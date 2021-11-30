
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
  
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
  selected2 <- reactiveVal(rep(FALSE, nrow(mtcars)))
  
  observeEvent(input$mouse_brush, {
    brushed <- brushedPoints(mtcars, input$mouse_brush, allRows = TRUE)$selected_
    selected(brushed | selected())
  })
  
  observeEvent(input$clk, {
    clicked <- nearPoints(mtcars, input$clk, allRows = TRUE)$selected_
    selected(clicked | selected())
  })
  
  observeEvent(input$mouse_hover, {
    hovered <- nearPoints(mtcars, input$mouse_hover, allRows = TRUE)$selected_
    selected2(hovered)
  })
  
  observeEvent(input$dclk, {
    double_clicked <- nearPoints(mtcars, input$dclk, allRows = TRUE)$selected_
    delete_color_index <- which(double_clicked)
    actual_vector <- selected()
    actual_vector[delete_color_index] <- FALSE
    selected(actual_vector)
  })
  
  output$plot_click_option <- renderPlot({
    mtcars$Seleccionado <- selected()
    mtcars$Cursor <- selected2()
    scale_custom <- list(
      scale_color_manual(values = c("TRUE" = "green", "FALSE" = "white")),
      scale_fill_manual(values = c("TRUE" = "gray", "FALSE" = 'white'))
    )
    
    ggplot(mtcars, aes(wt, mpg)) + 
      geom_point(aes(colour = Seleccionado,fill = Cursor), size = 4, shape=22) +
      scale_custom
  })
  
  
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

    if(any(selected())==TRUE){
      mtcars[selected(),]
    } else{
      mtcars
    }
  })
  
})
