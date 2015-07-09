# URL of zipfile containing data from experiment
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Input Data 
inputFile <- "household_power_consumption.txt"
zipFile <- "household_power_consumption.zip"

#
# Start processing
#

#Download input data (if needed)
if (!file.exists(inputFile)) {

	if (!file.exists(zipFile)) {
# File does not exist .. Download from source
		print("Downloading file from source")
		download.file(url=URL,destfile=zipFile,method="curl",quiet=TRUE)
	}
# Unzip 
	unzip(zipFile)
}

#Read input data
print("Reading input Data")

x<-read.csv2(file="household_power_consumption.txt",na.strings="?",dec=".",stringsAsFactors=F)
x$datetime<-strptime(paste(x$Date,x$Time),format="%d/%m/%Y %H:%M:%S")
sel<-x[x$datetime>="2007-02-01 00:00:00" & x$datetime<"2007-02-03 00:00:00",]

png(filename="plot4.png")
par(mfrow=c(2,2))

plot(sel$Global_active_power,type="l",col="black",xlab="",ylab="Global Active Power")


plot(sel$datetime,sel$Voltage,type="l",col="black",ylab="Voltage",xlab="datetime")

plot(sel$datetime,sel$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
points(sel$datetime,sel$Sub_metering_2,type="l",col="red")
points(sel$datetime,sel$Sub_metering_3,type="l",col="blue")

plot(sel$datetime,sel$Global_reactive_power,type="l",col="black",ylab="Global_reactive_power",xlab="datetime")

dev.off()
