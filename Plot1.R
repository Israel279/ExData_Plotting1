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
# 1st Plot
####################

#Create the histogram
hist(IHE$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
#Create de PNG copy to the working directory
dev.copy(png, file = "GlobalActivePowerHist.png")
#Close the PNG device
dev.off()
