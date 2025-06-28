library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Social Media Engament Analysis Visualization"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
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
