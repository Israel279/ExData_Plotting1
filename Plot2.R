library(data.table)

#“Individual household electric power consumption Data Set” 
IHE <- read.table("E:/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#Give Date theDate format
IHE$Date <- as.Date(IHE$Date, "%d/%m/%Y")
#Subsetting the date between 2007-02-01 and 2007-02-02
IHE <- subset(IHE, IHE$Date>=as.Date("2007-02-01") & IHE$Date<=as.Date("2007-02-02"))
#Give the numeric format to the column Global Active Power
IHE$Global_active_power <- as.numeric(IHE$Global_active_power)

####################
# 2nd Plot
####################

#Join the Date and the Time columns
IHE$Date_Time <- paste(IHE$Date, IHE$Time)
#Remove incomplete cases
IHE <- IHE[complete.cases(IHE),]
#Give the Date_Time column the calendar dates and times format as.POSIXct(strptime("2011-03-27 01:30:00", "%Y-%m-%d %H:%M:%S"))
IHE$Date_Time <- as.POSIXct(IHE$Date_Time)
#Create the plot of the Global Active Power 
plot(IHE$Global_active_power~IHE$Date_Time, xlab=" ", ylab="Global Active Power (kilowatts)", type="l")
#Create de PNG copy to the working directory
dev.copy(png, file = "GlobalActivePowerPlot.png")
#Close the PNG device
dev.off()
