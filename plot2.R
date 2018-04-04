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

## open png device to record plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## Create plot of adjDateTime by Global_active_power
with(epcDataFilteredCleaned, plot(adjDateTime,Global_active_power,type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

## Turn off png device
dev.off()

