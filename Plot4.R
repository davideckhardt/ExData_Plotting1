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
mycolors <- c("black", "red", "blue")

par(mfrow = c(2, 2)) 

plot(dateTime, powerData$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(dateTime, powerData$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dateTime, powerData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col=mycolors[1], ylim=c(0,25))
lines(dateTime, powerData$Sub_metering_2, type="l", col=mycolors[2])
lines(dateTime, powerData$Sub_metering_3, type="l", col=mycolors[3])
legend("topright", bty="o", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=mycolors, cex = 0.5)

plot(dateTime, powerData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file = "Plot4.png",width = 480, height = 480)
dev.off()

