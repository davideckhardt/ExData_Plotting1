rm(list = ls(all=TRUE))
library(dplyr)
library(lubridate)
#setwd("~/Training/Coursera/datasciencecoursera/ExploratoryDataAnalysis")

destDir <- "./Data"
destName <- paste0(destDir,"/household_power_consumption.txt")

# load the data file zip on first pass only
if(!file.exists(destName)){
  dir.create(destDir)
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = destName)
  print(dateDownloaded <- date())
  unzip(zipfile=destName,exdir=destDir)
}

powerData <- tbl_df(read.table(destName, header = TRUE, sep=";", nrows = 70000, 
                               na.strings = "?", stringsAsFactors = FALSE)) %>%
                                   subset(Date=="2/1/2007"|Date=="2/2/2007")

dateTime <- mdy_hms(paste(powerData$Date, powerData$Time))

with(powerData, plot(Global_active_power~dateTime, 
                     type = "l",
                     ylab="Global Active Power (kilowatts)",
                     xlab=""))

dev.copy(png, file = "Plot2.png",width = 480, height = 480)
dev.off()


