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
png("plot3.png",width=480,height = 480)

# from the plot example on the assigmnent it seems like we are reducing outliers from sub metering 2
# calculating mean and 3 sd around mean (only uisng +ve values here because metering cant be -ve)
v2 <- mean(as.numeric(plotdatafeb$Sub_metering_2)) + 3 * sd(as.numeric(plotdatafeb$Sub_metering_2))

#subset metering 2 
v2val <- subset(plotdatafeb, as.numeric(plotdatafeb$Sub_metering_2)<v2)

# add plots
plot(as.numeric(plotdatafeb$Sub_metering_1)~plotdatafeb$DateTime,type='l',col="black",ylab = "Energy sub metering",xlab="",yaxt='n')
lines(as.numeric(plotdatafeb$Sub_metering_3)~plotdatafeb$DateTime,type='l',col="blue")
lines(as.numeric(v2val$Sub_metering_2)~v2val$DateTime,type='l',col="red")
axis(2,at=seq(0,30,by=10), labels = seq(0,30,by=10))

legend(x="topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col =c("black","blue","red"), lty=1)
# close the device
dev.off()