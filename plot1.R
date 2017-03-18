##plot1.png - Global active power (kilowatts)

## Read .txt file using read.csv()
power_data <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date field (factor) to Date class using as.Date()
power_data <- within(power_data, Date <- as.Date(Date, format = "%d/%m/%Y"))

## Convert Global_active_power to numeric using as.numeric()
power_data <- within(power_data, Global_active_power <- as.numeric(Global_active_power))

## Subset data frame to get required dates (2007-02-01 and 2007-02-02)
plot_data <- power_data[which(power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02"), ]

## Construct histogram (plot1.png)
plot1.png <- hist(plot_data$Global_active_power, col = "red", main = "Global Active Report", xlab = "Global active power (kilowatts)", ylab = "Frequency")

## Save as PNG 
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()