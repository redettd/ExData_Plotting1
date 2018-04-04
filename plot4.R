## Read in data from file
epcData<-read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

## format date
epcData$Date<-as.Date(epcData$Date, format="%d/%m/%Y")

##############
## clean data
##############

## Use dplyr package
library(dplyr)

## Keep only those rows with dates between 2007-02-01 and 2007-02-02
epcDataFiltered<-filter(epcData, Date <= "2007-02-02" & Date >= "2007-02-01")

## Convert Global_active_power from factor to character
epcDataFiltered$Global_active_power<-as.character(epcDataFiltered$Global_active_power)

## Remove missing data from variable Global_active_power assigned to new data set named epcDataFilteredCleaned
epcDataFilteredCleaned<-filter(epcDataFiltered, Global_active_power!="?")

## Convert variable Time from factor to character
epcDataFilteredCleaned$Time<-as.character(epcDataFilteredCleaned$Time)

## Remove missing data from variable Time
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Time!="?")

## Combine the date and time into a new variable named dateTime
dateTime<-paste(epcDataFilteredCleaned$Date,epcDataFilteredCleaned$Time,sep = " ")

## Adjust dateTime format assign new value to variable adjDateTime
adjDateTime<-strptime(dateTime,format = "%Y-%m-%d %H:%M:%S")

## Convert variable Voltage from factor to character
epcDataFilteredCleaned$Voltage<-as.character(epcDataFilteredCleaned$Voltage)

## Remove missing data from variable Voltage
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Voltage!="?")

## Convert variable Sub_metering_1 from factor to character
epcDataFilteredCleaned$Sub_metering_1<-as.character(epcDataFilteredCleaned$Sub_metering_1)

## Remove missing data from variable Sub_metering_1
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Sub_metering_1!="?")

## Convert variable Sub_metering_2 from factor to character
epcDataFilteredCleaned$Sub_metering_2<-as.character(epcDataFilteredCleaned$Sub_metering_2)

## Remove missing data from variable Sub_metering_2
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Sub_metering_2!="?")

## Convert variable Sub_metering_3 from factor to character
epcDataFilteredCleaned$Sub_metering_3<-as.character(epcDataFilteredCleaned$Sub_metering_3)

## Remove missing data from variable Sub_metering_3
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Sub_metering_3!="?")

## Convert variable Global_reactive_power from factor to character
epcDataFilteredCleaned$Global_reactive_power<-as.character(epcDataFilteredCleaned$Global_reactive_power)

## Remove missing data from variable Global_reactive_power
epcDataFilteredCleaned<-filter(epcDataFilteredCleaned, Global_reactive_power!="?")

## open png device to record plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## Adjusts output window to allow for four plots arranged 2 by 2.
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

## Creates the afforementioned four plots
with(epcDataFilteredCleaned, {
        plot(adjDateTime,Global_active_power,type = "l", xlab = "", ylab = "Global Active Power")
        plot(adjDateTime,Voltage,type = "l", xlab = "datetime", ylab = "Voltage")
        plot(adjDateTime,as.numeric(Sub_metering_1) ,type = "l", xlab = "", ylab = "Energy sub metering")
        lines(adjDateTime,as.numeric(Sub_metering_2) , col="red")
        lines(adjDateTime,as.numeric(Sub_metering_3) , col="blue")
        legend("topright", lty=c(1,1,1), bty = "n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(adjDateTime,Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

## Turn off png device
dev.off()