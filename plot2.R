# unzip the file 
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

#add datetime variable
plotdatafeb$DateTime <- as.POSIXct(paste(plotdatafeb$Date, plotdatafeb$Time), format="%Y-%m-%d %H:%M:%S")

# set the graphical device
png("plot2.png",width=480,height = 480)

#plot the data
plot(as.numeric(plotdatafeb$Global_active_power)/1000~plotdatafeb$DateTime, type='l',ylab = "Global Active Power(kilowatts)",yaxt='n',xlab="")

# set the axis to desired values 
axis(side=2, at=seq(0,6,by=2), labels = seq(0,6,by=2))
# close the graphical device
dev.off()