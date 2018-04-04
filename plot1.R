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

## Remove missing data from variable Global_active_power assigned to new variable named epcDataFilteredCleaned
epcDataFilteredCleaned<-epcDataFiltered$Global_active_power[epcDataFiltered$Global_active_power!="?"]

## Convert variable epcDataFilteredCleaned to a numeric variable
histData<-as.numeric(epcDataFilteredCleaned)

## open png device to record histogram 
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## create histogram
hist(histData, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Turn off png device
dev.off()

