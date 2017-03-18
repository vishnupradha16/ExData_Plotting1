## plot4.png

## Read .txt file using read.csv()
power_data <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date field (factor) to Date class using as.Date()
power_data <- within(power_data, Date <- as.Date(Date, format = "%d/%m/%Y"))

## Subset data frame to get required dates (2007-02-01 and 2007-02-02)
plot_data <- power_data[which(power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02"), ]

## Merge Date and Time fields into new field "DateTime"
plot_data$DateTime <- paste(plot_data$Date, plot_data$Time)

## Convert class using POSIXlt()
plot_data$DateTime <- as.POSIXlt(plot_data$DateTime)

## Convert factor fields to numeric fields
plot_data <- within(plot_data, Sub_metering_1 <- as.numeric(Sub_metering_1))
plot_data <- within(plot_data, Sub_metering_2 <- as.numeric(Sub_metering_2))
plot_data <- within(plot_data, Global_reactive_power <- as.numeric(Global_reactive_power))
plot_data <- within(plot_data, Global_intensity <- as.numeric(Global_intensity))
plot_data <- within(plot_data, Global_active_power <- as.numeric(Global_active_power))
plot_data <- within(plot_data, Voltage <- as.numeric(Voltage))

## Specify multi plot dimensions 2x2
par(mfrow=c(2,2))

## Construct PNG plots similar to plot3.R
plot(plot_data$DateTime,plot_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
##Plot 2
plot(plot_data$DateTime,plot_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
##Plot 3
plot(plot_data$DateTime,plot_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(plot_data$DateTime,plot_data$Sub_metering_2,col="red")
lines(plot_data$DateTime,plot_data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
#Plot 4
plot(plot_data$DateTime,plot_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
