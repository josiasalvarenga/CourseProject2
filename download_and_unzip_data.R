## Extracting and downloading source data

if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/summarySCC_PM25.zip")

## Unzipping summarySCC_PM25.zip to /data directory

unzip(zipfile = "./data/summarySCC_PM25.zip", exdir = "./data")