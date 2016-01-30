
plotTempDates <- function( dateRange, dataType2, dataset) {
  idx <- dataset$date >= dateRange[1] &  dataset$date <= dateRange[2]
  title <- paste("Daily observations from", dateRange[1], "to", dateRange[2])
  plot(x=dataset$date[idx], y=dataset$MaximumAirTemperature[idx], type="l",
       xlab="Date", ylab = dataType2, main=title)
}

plotGamDate <- function(dateRange, dataType2, dataset) {
  yVar <- dataType2
  f <- paste(yVar, 
             '~',
             's(dayOfYear, bs = "cc")',
             '+',
             's(as.numeric(date), bs = "cr")'
  )
  idx <- dataset$date >= dateRange[1] &  dataset$date <= dateRange[2]
  model <- gamm( as.formula(f), 
                 data = dataset[idx,], method = "REML", 
                 correlation = corAR1(form = ~ 1 | Year), 
                 knots = list(dayOfYear = c(0, 366)))

  #  plot(model$gam, pages = 1, scale=0)
  par(mfrow=c(1,2))
  title <- paste("Annual Cycle:", dataType2)
  plot(model$gam, pages = 0, scale=0, select=1, xlab="Day of Year", 
       main=title)
  title <- paste("Overall Trend:", dateRange[1], "to", dateRange[2])
  plot(model$gam, pages = 0, scale=0, select=2, xlab="Date (days since 1970-01-01)",
       main=title)
  par(mfrow=c(1,1))
}
