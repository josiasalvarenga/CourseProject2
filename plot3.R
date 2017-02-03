## Code for Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in emissions
## from 1999–2008 for Baltimore City? Which have seen increases in emissions from
## 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Reading and preparing data using dplyr

NEI <- readRDS("./data/summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Creating table with emissions per type and year in Baltimore
BaltimoreEmissionsPerTypeAndYear = summarize(group_by(filter(NEIdp, fips=="24510"),
        type, year), sum(Emissions))

# Renaming columns
colnames(BaltimoreEmissionsPerTypeAndYear) <- c("Type", "Year", "Emissions")

# Converting year to string
BaltimoreEmissionsPerTypeAndYear$Year <- as.character(BaltimoreEmissionsPerTypeAndYear$Year)

# Plotting the png file
library(ggplot2)
png("plot3.png")
qplot(Year, data = BaltimoreEmissionsPerTypeAndYear, geom = "bar",
        weight = Emissions, facets = .~Type, fill = Year,
        xlab = "", ylab = "Emissions (PM 2.5) in Tons",
        main = "Baltimore - Emissions (PM 2.5) per type and year")
dev.off()