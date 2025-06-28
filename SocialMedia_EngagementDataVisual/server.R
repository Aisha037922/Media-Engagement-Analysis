library(shiny)
library(ggplot2)
library(plotly)


serve <- function(input, output, session){
  output&hist <- renderPlot({
    hist(rnorm(input$n))
  })
}

shinyApp(ui = ui, server = server)