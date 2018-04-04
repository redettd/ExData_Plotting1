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

## open png device to record plot
png(filename = "plot3.png", width = 480, height = 480, units = "px")

## Create plot of adjDateTime by Sub_metering_1
with(epcDataFilteredCleaned, plot(adjDateTime,as.numeric(Sub_metering_1) ,type = "l", xlab = "", ylab = "Energy sub metering"))

## Add to the plot adjDateTime by Sub_metering_2 (color red)
with(epcDataFilteredCleaned, lines(adjDateTime,as.numeric(Sub_metering_2) , col="red"))

## Add to the plot adjDateTime by Sub_metering_3 (color blue)
with(epcDataFilteredCleaned, lines(adjDateTime,as.numeric(Sub_metering_3) , col="blue"))

## Create legend for plot
legend("topright", lty=c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Turn off png device
dev.off()
