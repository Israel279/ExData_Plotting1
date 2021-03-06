library(data.table)

#“Individual household electric power consumption Data Set” 
IHE <- read.table("E:/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#Give Date theDate format
IHE$Date <- as.Date(IHE$Date, "%d/%m/%Y")
#Subsetting the date between 2007-02-01 and 2007-02-02
IHE <- subset(IHE, IHE$Date>=as.Date("2007-02-01") & IHE$Date<=as.Date("2007-02-02"))
#Give the numeric format to the column Global Active Power
IHE$Global_active_power <- as.numeric(IHE$Global_active_power)
#Join the Date and the Time columns
IHE$Date_Time <- paste(IHE$Date, IHE$Time)
#Remove incomplete cases
IHE <- IHE[complete.cases(IHE),]
#Give the Date_Time column the calendar dates and times format as.POSIXct(strptime("2011-03-27 01:30:00", "%Y-%m-%d %H:%M:%S"))
IHE$Date_Time <- as.POSIXct(IHE$Date_Time)
#Give the format numeric to the columns Sub_metering_1, Sub_metering_2 and Sub_metering_3
IHE$Sub_metering_1 <- as.numeric(IHE$Sub_metering_1)
IHE$Sub_metering_2 <- as.numeric(IHE$Sub_metering_2)
IHE$Sub_metering_3 <- as.numeric(IHE$Sub_metering_3)

####################
# 4th Plot
####################

#Create 4 graphics in a 2x2 matrix
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(IHE, {
  plot(Global_active_power~Date_Time, type="l",xlab=" ", ylab="Global Active Power (kilowatts)")
  plot(Voltage~Date_Time, type="l",xlab=" ", ylab="Voltage (volt)")
  plot(Sub_metering_1~Date_Time, type="l",xlab=" ", ylab="Global Active Power (kilowatts)")
  lines(Sub_metering_2~Date_Time,col='Red')
  lines(Sub_metering_3~Date_Time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Date_Time, type="l",xlab=" ", ylab="Global Rective Power (kilowatts)")
})
#Create de PNG copy to the working directory
dev.copy(png, file = "Plot4.png")
#Close the PNG device
dev.off()
