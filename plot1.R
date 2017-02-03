## Code for Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Reading and preparing data using dplyr

NEI <- readRDS("./data/summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Creating table with emissions per year
EmissionsPerYear = summarize(group_by(NEIdp, year), sum(Emissions))

# Renaming columns
colnames(EmissionsPerYear) <- c("Year", "Emissions")

# Adding new column with emissions in megatons
EmissionsPerYear$EmissionsInMegatons = EmissionsPerYear$Emissions / 1000000

# Plotting the png file
png("plot1.png")
barplot(EmissionsPerYear$EmissionsInMegatons, names.arg=EmissionsPerYear$Year,
        col="darkblue", xlab="Years", ylab="Emissions (PM 2.5) in Megatons",
        main =  "United States - Emissions (PM 2.5) per year")
dev.off()