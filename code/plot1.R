## load dependent libraries
library(data.table)
library(dplyr)

## unzip and load data using fread (data.table) and then filter the data for the required days

## download the file from the repository and unzip
temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", temp) 
unzip(temp, exdir = "./data/")

## Load the file and filter the required data
newFile <- fread("./data/household_power_consumption.txt", na.strings = "?")
newFile[, DateNew := as.Date(Date, format = "%d/%m/%Y")]
subsetted <- filter(newFile, DateNew >= as.Date("2007-02-01 00:00:00"), DateNew <= as.Date("2007-02-02 00:00:00"))
subsetted[, DT := as.POSIXct(paste(subsetted$Date, subsetted$Time), format = "%d/%m/%Y %H:%M:%S")]

## Plot 1 : histogram plot for the variable Global_active_power
png(filename = "./figure/plot1.png", width = 480, height = 480,units = "px", pointsize = 12, bg = "white", res = NA)
hist(subsetted$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()