#download data
if(! file.exists("/home/alex/ExData_Plotting1/data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "/home/alex/ExData_Plotting1/data.zip")
  zipped.file <- "/home/alex/ExData_Plotting1/data.zip"
  unzip(zipfile = "/home/alex/ExData_Plotting1/data.zip", exdir = "/home/alex/ExData_Plotting1/data")
}
