## Code for Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
## plot answering this question.

# Reading and preparing data using dplyr

NEI <- readRDS("./data/summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Creating table with emissions per year in Baltimore
BaltimoreEmissionsPerYear = summarize(group_by(filter(NEIdp, fips=="24510"), year), sum(Emissions))

# Renaming columns
colnames(BaltimoreEmissionsPerYear) <- c("Year", "Emissions")

# Plotting the png file
png("plot2.png")
barplot(BaltimoreEmissionsPerYear$Emissions, names.arg=BaltimoreEmissionsPerYear$Year,
        col="darkblue", xlab="Years", ylab="Emissions (PM 2.5) in Tons",
        main =  "Baltimore - Emissions (PM 2.5) per year")
dev.off()