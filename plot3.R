## Examine power consumption over 2 days in February 2007
## plot3.png

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

## Convert factor fields "Sub_metering_1" and "Sub_metering_2" to numeric fields
plot_data <- within(plot_data, Sub_metering_1 <- as.numeric(Sub_metering_1))
plot_data <- within(plot_data, Sub_metering_2 <- as.numeric(Sub_metering_2))

## Subset plot_data to select only required fields
plot3_vars <- c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot3_data <- plot_data[plot3_vars]

## Construct PNG 
plot3.png <- plot(plot3_data$DateTime,plot3_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(plot3_data,lines(DateTime,Sub_metering_1))
with(plot3_data,lines(DateTime,Sub_metering_2,col="red"))
with(plot3_data,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()

