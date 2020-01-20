# download zip file from website
setwd("C:/temp")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")

# unzip and read table, add title row, update data types, remove ? marks (specific rows obtained per view in Notepad)
powerdata <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header = TRUE, sep=";", skip=66637, nrows=2879, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

# per project notes, convert to Date/Time class
datetime <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# prep device output
png("plot2.png", width=480, height=480)

# line graph
plot(datetime, powerdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowats)")

dev.off()
