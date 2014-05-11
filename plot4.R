## Title: plot4.r
## Description: Creates plot 4, and then saves plot 4 to a png

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

## Create Plot #4
par(mfcol = c(2,2)) 
with(powerT, {
        plot(x=datetime,y=Global_active_power,type="l",ylab="Global Active Power",xlab="")
        
        plot(x=datetime,y=Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
        points(x=datetime,y=Sub_metering_2, type="l",col="red")
        points(x=datetime,y=Sub_metering_3, type="l",col="blue")
        legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        plot(x=datetime,y=Voltage,type="l")
        
        plot(x=datetime,y=Global_reactive_power,type="l") 
})

## Save PNG for Plot #4
png(file="plot4.png")
par(mfcol = c(2,2)) 
with(powerT, {
        plot(x=datetime,y=Global_active_power,type="l",ylab="Global Active Power",xlab="")
        
        plot(x=datetime,y=Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
        points(x=datetime,y=Sub_metering_2, type="l",col="red")
        points(x=datetime,y=Sub_metering_3, type="l",col="blue")
        legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        plot(x=datetime,y=Voltage,type="l")
        
        plot(x=datetime,y=Global_reactive_power,type="l") 
})
dev.off()