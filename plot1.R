## Title: plot1.r
## Description: Creates plot 1, and then saves plot 1 to a png

## Download data from link
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp, exdir = "./")
unlink(temp)

## Read in data for February 1st and 2nd, 2007
power <- read.table("./household_power_consumption.txt", sep=";", na.strings = "?", header=TRUE, 
                    colClasses = (c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")))

## Create a date and time variable
power$datetime <- strptime(paste(power$Time,power$Date),"%H:%M:%S %d/%m/%Y")

## Limit data to two days, then remove full dataset (powerT as the power table has been 't'rimmed)
powerT <- power[power$datetime >= strptime("02/01/07","%m/%d/%y") 
                & power$datetime < strptime("02/03/07","%m/%d/%y"),]
rm(power)

## Create Plot #1
par(mfcol = c(1,1)) 
hist(powerT$Global_active_power, main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)")

## Save PNG for Plot #1
png(file="plot1.png")
hist(powerT$Global_active_power, main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)")
dev.off()
