
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
source("helpers.R")
library(shiny)
library(gdata)
library(lubridate)
library(mgcv) 
library(markdown)

weather1 <- read.xls("./data/Daily1959to1969.xls", stringsAsFactors=FALSE, na.strings=c("", "3276.8", "n/a"),
                     sheet = "sheet1", verbose=T, header=TRUE, encoding = "latin1")
weather2 <- read.xls("./data/Daily1970to1989.xls", stringsAsFactors=FALSE, na.strings=c("", "3276.8", "n/a"),
                     sheet = "sheet1",  verbose=T, header=TRUE, encoding = "latin1")
weather3 <- read.xls("./data/Daily1990to2000.xls", stringsAsFactors=FALSE, na.strings=c("", "3276.8", "n/a"),
                     sheet = "sheet1", verbose=T, header=TRUE, encoding = "latin1")

# It is assumed that each temperature (except the last) needs to be moved 
# 'across one column' for the second data set.  This appears to give good 
# results but does raise uncertainty for the following analysis.
weather2Adj <- weather2
weather2Adj[,4] <- weather2[,5]
weather2Adj[,5] <- weather2[,6]
weather2Adj[,6] <- weather2[,7]
weather2Adj[,7] <- weather2[,8]
weather2Adj[,8] <- weather2[,9]

weather <- rbind(weather1,weather2Adj,weather3)

colnames(weather) <- c("Day",                  "Month",                                      
                       "Year",                                        "MaximumAirTemperature",   
                       "MinimumAirTemperature",                       "GrassMininumTemperature",               
                       "ConcreteMininumTemperature",                  "SoilTemperature10cmSpot", 
                       "SoilTemperature30cmSpot",                     "SoilTemperature100cmSpot",
                       "Rain",                                        "WindMean",                  
                       "WindMax",                                     "SnowDepth")                                  

# Set rainfall to half minimum possible measure when observed as 'trace', and convert to numeric
weather$Rain[grepl('trace', weather$Rain)] <- 0.05
weather$Rain <- as.numeric(weather$Rain)

# Add a date column
weather$date <- as.Date(ISOdate(weather$Year, weather$Month, weather$Day))
weather$dayOfYear = yday(weather$date)

# Define the choice of temperatures to investigate
dataTypes = colnames(weather)[4:9]

# Define the default date range limits
dateLimits <- range(weather$date)


shinyServer(function(input, output) {

  # Create a (somewhat) dynamic widget for user to select temperature type
  output$temperatureSelector <- renderUI({
    selectInput("temperatureChoice", label = 'Select temperature observation type:', 
                choices = dataTypes, selected = dataTypes[1])
  })

  # Create a dynamic widget for user to select a date range
  output$dateRangeSelector <- renderUI({
          dateRangeInput('dateRange',
                         label = 'Select date range:',
                         start = dateLimits[1], end = dateLimits[2],
                         min = dateLimits[1], max = dateLimits[2],
                         separator = " - ", format = "dd/mm/yyyy",
                         startview = 'year', language = 'en', weekstart = 1
          )
  })
  
  # Chart the selected temperature observations
  output$temperatureChart <- renderPlot({
    plotTempDates(input$dateRange, input$temperatureChoice, weather)
  })
  
  # fit cyclical and trend components and plot results
  output$modelFitChart <- renderPlot({
    plotGamDate(input$dateRange, input$temperatureChoice, weather)
  })
  
})
