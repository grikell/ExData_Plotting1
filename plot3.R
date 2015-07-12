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
# Unzip (read.csv could also read zipfiles, but in this way code is simpler as the <txt> file may exist)
	unzip(zipFile)
}

#Read input data
print("Reading input Data")

x<-read.csv2(file="household_power_consumption.txt",na.strings="?",dec=".",stringsAsFactors=F)

#Convert time intervals into a POSIXlt
x$dateTime<-strptime(paste(x$Date,x$Time),format="%d/%m/%Y %H:%M:%S")

#Select time & fields
sel<-x[x$dateTime>="2007-02-01 00:00:00" & x$dateTime<"2007-02-03 00:00:00",
	c("dateTime","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

#Generate plot  (to png), adding first graph and then the other two
# I prefer to generate directly the png file (e.g. no display) in order to avoid any difference
# e.g. background, etc

png(filename="plot3.png")
plot(sel$dateTime,sel$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
points(sel$dateTime,sel$Sub_metering_2,type="l",col="red")
points(sel$dateTime,sel$Sub_metering_3,type="l",col="blue")

#Add legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
