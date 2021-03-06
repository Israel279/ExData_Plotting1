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

####################
# 3th Plot
####################

#Give the format numeric to the columns Sub_metering_1, Sub_metering_2 and Sub_metering_3
IHE$Sub_metering_1 <- as.numeric(IHE$Sub_metering_1)
IHE$Sub_metering_2 <- as.numeric(IHE$Sub_metering_2)
IHE$Sub_metering_3 <- as.numeric(IHE$Sub_metering_3)

#Create the plot 
with(IHE, {
  plot(Sub_metering_1~Date_Time, xlab=" ", ylab="Global Active Power (kilowatts)", type="l")
  lines(Sub_metering_2~Date_Time, col='Red')
  lines(Sub_metering_3~Date_Time, col='Blue') })
#Onthe top right corner write the 3 name of cthe Sub metering columns with the different colors 
legend("topright", lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
#Create de PNG copy to the working directory
dev.copy(png, file = "Sub_metering.png")
#Close the PNG device
dev.off()


