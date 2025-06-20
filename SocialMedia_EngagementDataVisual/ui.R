library(shiny)
library(bslib)
library(plotly)
library(ggplot2)
library(gapminder)
ui


ui <- navbarPage(
  title = "Final Info",
  theme = shinythemes::shinytheme("cosmo"),
  tabPanel("Introduction",
           br(),
           tags$img(src = 'Info_final_Image.png', height = 400, width = 400),
           mainPanel(
             h2("Diversity in the Makeup Industry (How Can The Industry Improve?)"),
  
),
tabPanel("Interactive Box Plot",
         fluidPage(
           titlePanel("Intro"),
           sidebarLayout(
             sidebarPanel(
               selectInput(
                 inputId = "location",  
                 label = "Select the Location",
                 choices = unique(best_time$location),
                 selected = c("location", "avg_impressions"),
                 multiple = TRUE
      )
    ),
    mainPanel(
      plotlyOutput("distPlot"),
      p("This plot shows the best times to post on different platforms, grouped by location.")
    )
  )
)
)
)
