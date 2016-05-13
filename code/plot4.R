## load dependent libraries
library(data.table)
library(dplyr)

## unzip and load data using fread (data.table) and then filter the data for the required days

## download the file from the repository and unzip
if (!file.exists("./data/household_power_consumption.txt"))
{
        temp <- tempfile()
        download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", temp) 
        unzip(temp, exdir = "./data/")
}
## Load the file and filter the required data
newFile <- fread("./data/household_power_consumption.txt", na.strings = "?")
newFile[, DateNew := as.Date(Date, format = "%d/%m/%Y")]
subsetted <- filter(newFile, DateNew >= as.Date("2007-02-01 00:00:00"), DateNew <= as.Date("2007-02-02 00:00:00"))
subsetted[, DT := as.POSIXct(paste(subsetted$Date, subsetted$Time), format = "%d/%m/%Y %H:%M:%S")]

## Plot 4
png(filename = "./figure/plot4.png", width = 480, height = 480,units = "px", pointsize = 12, bg = "white", res = NA)
par(mfrow = c(2,2))
plot(subsetted$DT, subsetted$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(subsetted$DT, subsetted$Global_active_power, type = "l")
plot(subsetted$DT, subsetted$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(subsetted$DT, subsetted$Voltage)
plot(subsetted$DT, subsetted$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(subsetted$DT, subsetted$Sub_metering_1)
lines(subsetted$DT, subsetted$Sub_metering_2, col = "red")
lines(subsetted$DT, subsetted$Sub_metering_3, col = "blue")
legend("topright",lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subsetted$DT, subsetted$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(subsetted$DT, subsetted$Global_reactive_power)
dev.off()