# unzip the file 
# the code below assumes that the file is in the directory 
# Code to download and unzip data 
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "PowerConsumption.Zip"
download.file(fileurl,filename)
unzip(filename, overwrite = TRUE)


# read the data 
plotdata <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")

#change the Date variable into date format 
plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")

# filter data for feb
plotdatafeb <- subset(plotdata,Date == "2007-02-01"|Date == "2007-02-02")

# set the graphical device
png("plot1.png",width=480,height = 480)

#Define the bins
bins <- seq(0,6,by=.3)

# histogram with custom settings for labels and axis
hist(as.numeric(plotdatafeb$Global_active_power)/1000,col="red",breaks = bins,xlab="Global Active Power(kilowatts)",xaxt='n')

#axis(side = 2, at = seq(0,1200,by = 200),labels = seq(0,1200,by=200))

axis(side = 1, at=seq(0,6,by=2),labels = seq(0,6,by=2))

# close the graphical device
dev.off()