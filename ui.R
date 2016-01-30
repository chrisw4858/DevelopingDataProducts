
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring Temperature Trends of an English Midlands Town"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      uiOutput("temperatureSelector"),
      uiOutput("dateRangeSelector")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", includeMarkdown("summary.md")),
        tabPanel( "View Temperature Chart",
          plotOutput("temperatureChart")
        ),
        tabPanel( "View Fitted Model and Temperature Trends",
                  "Please be patient while the chart updates...it can take 40 seconds or more...sorry",
                  plotOutput("modelFitChart"),
                  "The model consists of a year-long cyclical portion (left), and overall trend with time (right)"
        )
      )
    )
  )
))

