##plot2.png - Global active power (kilowatts) vs. Date/Time

## Read .txt file using read.csv()
power_data <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date field (factor) to Date class using as.Date()
power_data <- within(power_data, Date <- as.Date(Date, format = "%d/%m/%Y"))

## Convert Global_active_power to numeric using as.numeric()
power_data <- within(power_data, Global_active_power <- as.numeric(Global_active_power))

## Subset data frame to get required dates (2007-02-01 and 2007-02-02)
plot_data <- power_data[which(power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02"), ]

## Merge Date and Time fields into new field "DateTime"
plot_data$DateTime <- paste(plot_data$Date, plot_data$Time)

## Convert class using POSIXlt()
plot_data$DateTime <- as.POSIXlt(plot_data$DateTime)

## Construct line graph of Global active power vs. DateTime
plot2.png <- plot(plot_data$DateTime, plot_data$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

## Save as PNG
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

