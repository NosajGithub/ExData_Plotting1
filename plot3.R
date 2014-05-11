## Title: plot3.r
## Description: Creates plot 3, and then saves plot 3 to a png

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

## Create Plot #3
par(mfcol = c(1,1)) 
with(powerT, {
        plot(x=datetime,y=Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
        points(x=datetime,y=Sub_metering_2, type="l",col="red")
        points(x=datetime,y=Sub_metering_3, type="l",col="blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
})

## Save PNG for Plot #3
png(file="plot3.png")
with(powerT, {
        plot(x=datetime,y=Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
        points(x=datetime,y=Sub_metering_2, type="l",col="red")
        points(x=datetime,y=Sub_metering_3, type="l",col="blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
})
dev.off()