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
x$dateTime<-strptime(paste(x$Date,x$Time),format="%d/%m/%Y %H:%M:%S")
sel<-x[x$dateTime>="2007-02-01 00:00:00" & x$dateTime<"2007-02-03 00:00:00",c("dateTime","Global_active_power")]
png(filename="plot2.png")
plot(sel,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
