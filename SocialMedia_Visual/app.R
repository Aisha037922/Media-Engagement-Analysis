library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui = fluidPage(
  selectInput("variable", "Variable:",
              c("Cylinders" = "cyl",
                "Transmission" = "am",
                "Gears" = "gear")),
  tableOutput("data")
)

server = function(input, output) {
  output$data <- renderTable({
    mtcars[, c("mpg", input$variable), drop = FALSE]
  }, rownames = TRUE)
}


shinyApp(
  ui = fluidPage(
    selectInput("location", "Choose a country:",
                list(`East Coast` = list("NY", "NJ", "CT"),
                     `West Coast` = list("WA", "OR", "CA"),
                     `Midwest` = list("MN", "WI", "IA"))
    ),
    textOutput("result")
  )
  )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      p <- ggplot(best_time, aes(x=platform, y=timestamp, fill = location)) +
        geom_boxplot() +
        theme_minimal() +
        labs(title = "Box Plot of the Best time to post based 
       on Average Engagement rate and Location", x="Platform", y="Timestamp")
      ggplotly(p)
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
