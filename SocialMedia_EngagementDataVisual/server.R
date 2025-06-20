library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlot({

      best_time <- data %>%
        mutate(hour = hour(timestamp)) %>%
        group_by(timestamp, location, platform) %>%
        summarise(avg_impressions = mean(impressions, na.rm = TRUE), .groups = "drop") %>%
        arrange(avg_impressions, desc(platform))
      
      # graph - location, and post time and engagment_rate
      
      p <- ggplot(best_time, aes(x=platform, y=timestamp, fill = location)) +
        geom_boxplot() +
        theme_minimal() +
        labs(title = "Box Plot of the Best time to post based 
       on Average Engagement rate and Location", x="Platform", y="Timestamp")
      ggplotly(p)

    })

}
