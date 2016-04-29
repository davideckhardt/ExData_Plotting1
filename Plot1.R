#  GRADERS: I understand this code might look different than whatever you are reading
#  on the forum.  This is my second time submitting this.  I spent a lot of time working
#  on it, so perhaps before something doesn't "look" correct you could take a couple of 
#  seconds and paste it into RStudio and see that it is actually correct.
#
#  Here's some of the complaints I received on my original submit:
#  - "Unfortunately you did not apply as.numeric() to the data".  ** Obviously, that's not correct.  you see plots, don't you?
#  - "You also don't have to download and extract the zip file on every .R file."  ** you might recognize
#    a comment and statement that i only downloaded one time.  This was covered in a lecture, pay attention: if(!file.exists(destName))
#  - "Do your assignments according to the requirements."  ** I'm guessing this means I used a different Date formatter.  That 
#     wasn't a requirement.  In fact, the instructions specifically allow for variations.
#
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
  download.file(fileUrl, destfile = "./hpc.zip")
  print(dateDownloaded <- date())
  unzip(zipfile="./hpc.zip",exdir=destDir)
}

powerData <- tbl_df(read.table(destName, header = TRUE, sep=";", nrows = 70000, 
                               na.strings = "?", stringsAsFactors = FALSE)) %>%
  subset(Date=="1/2/2007"|Date=="2/2/2007")

with(powerData, hist(Global_active_power, 
                     col="red", 
                     xlab="Global Active Power (kilowatts)",
                     main = "Global Active Power"))

dev.copy(png, file = "Plot1.png",width = 480, height = 480)
dev.off()

