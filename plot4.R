#download data if not already downloaded
source("./download_data.R")

#change to new dir
setwd("/home/alex/ExData_Plotting1/data")

#read dataset
df <- read.table("/home/alex/ExData_Plotting1/data/household_power_consumption.txt",sep = ";", header = TRUE)

#Add DateTime col generated with with strptime and paste
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
print(class(df$DateTime))

#subset df for specified dates
df <- df[as.Date(df$Date, format = "%d/%m/%Y")>=as.Date("2007-02-01", format = "%Y-%m-%d") & as.Date(df$Date, , format = "%d/%m/%Y") <= as.Date("2007-02-02", format = "%Y-%m-%d"),]

#convert the POSIXlt objects to POSIXct, which is numeric internally
df$DateTime <- as.POSIXct(df$DateTime)
print(class(df$DateTime))

#start graphic Device with Dimensions 2x2 and pixel units
png(filename = "/home/alex/ExData_Plotting1/plot4.png", height = 480 , width = 480, units = "px")
par(mfrow = c(2,2))

#Top left
#subset global active power for specified dates
# Calculate indices for first, middle, and last elements
first <- df$DateTime[1] # First DateTime value
middle <- df$DateTime[nrow(df)/2] # Middle DateTime value
last <- df$DateTime[nrow(df)] # Last DateTime value
days <- c("Thu", "Fri", "Sat")
#make plot
with(df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n"))
axis(1, at = c(first, middle, last), labels = days)

#Top Right
plot(x = df$DateTime, y = df$Voltage, type = "l", ylab = "Voltage", xlab ="DateTime", xaxt = "n")
axis(1, at = c(first, middle, last), labels = days)

#Bottom left
#make plot
with(df, plot(DateTime, Sub_metering_1, type = "l", col= "black", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
lines(df$DateTime, df$Sub_metering_2, col= "red")
lines(df$DateTime, df$Sub_metering_3, col= "blue")
#add modified ticks axis
axis(1, at = c(first, middle, last), labels = c("Thu", "Fri", "Sat"))
#add legend
legend(cex = 0.8,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), x = "topright", lwd = 1)

##Bottom right
with(df, plot(x= DateTime, y = Global_reactive_power, type ="l", xlab = "DateTime", ylab = "Global_reactive_power", xaxt = "n"))
axis(1, at = c(first, middle, last), labels = c("Thu", "Fri", "Sat"))

#close Graphics Device
dev.off()