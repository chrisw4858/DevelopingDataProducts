
# Purpose

In discussion of global warming, people often reflect on changes they have observed but human observation of global warming in general is notoriously unreliable.  The intent of behind this page is to allow one to search for trends in temperature in a data set from a single town ranging across nearly forty years.  Can an overall upward trend be seen? If one adjusts the time windows, can one find periods where there is a decreasing trend?

+ Select a temperature measurement of interest
+ Select a time window (with the suggestion to use a large window)
+ Use the 'View Temperature Chart' to view the chart of daily temperatures
+ Use the 'View Temperature Trends' to see results of modelling the selected temperature range
+ The overall trend over time can be viewed in the right-most chart on the 'View Temperature Trends' tab

**Please note that it takes a significant time to fit the model and update the model charts.**

# Background

I grew up in the English Midlands and at one time participated in an amateur climatological station that provided data to the UK Met Office.  The weather station is now sadly closed, but a friend provided a set of weather data from the station covering a period of more than forty years.  The Developing Data Products project was a perfect opportunity to finally explore that data set.

## Data - Observations

The main portion of the data consists of various temperature observations.  All temperatures are measured in degrees celsius, and all observations were taken at 9am GMT.  There are two forms of meaurement: Max and Min, which show the highest and lowest temperatures over the previous 24 hours; and Spot temperatures for which the observation was taken at 9am GMT (+/- 15 minutes).  The spot temperatures thermometers were placed at different depths below ground level and thus lag (and are less sensitive to) daily fluctuation.

Rainfall, wind and snowfall data was also included but is not presented.

## Messy Data

It turns out that there are many gaps in the data set, consisting of entire months with missing observations to periods of several years.

The original data set was split into three files all of (apparently the same format).  Inspection showed that for one of the files column names did not match actual observations.  Data columns were 'moved' to correct for the discrepancy.


## Modelling

Initial intent was to simply model the average yearly temperature.  However with the large blocks of missing data a different approach was taken that did not necessitate imputing missing values.

Overall, temperature variation would be expected to follow a year long cyclical pattern.  

Temperature variation is modelled using a Generalized Additive approach using a combination of year-long cyclical pattern with an additional smoothing term dependent on overall passage of time. 

The approach is based on that described in "Generalized Linear Models: an introduction with R" by Simon Wood.

