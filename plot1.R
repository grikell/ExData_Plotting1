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

# Process Time Interval (as.Date is faster that strptime) and fields of interest
x$Date=as.Date(x$Date,"%d/%m/%Y")
sel<-x[x$Date>="2007-02-01" & x$Date<="2007-02-02","Global_active_power"]

# Generate plot (to png)
# I prefer to generate directly the png file (e.g. no display) in order to avoid any difference
# e.g. background, etc
png(filename="plot1.png")
hist(sel,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
