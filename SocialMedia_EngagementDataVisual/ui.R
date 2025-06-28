library(shiny)
library(bslib)
library(plotly)
library(ggplot2)
library(gapminder)

ui <- fluidPage(
  sliderInput("n", "Sample size", min = 10, max = 100, value = 23),
  plotOutput(outputId = "hist")
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    hist(rnorm(input$n))
  })
}

shinyApp(ui = ui, server = server)
