## Code for Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

# Reading data and preparing data

NEI <- readRDS("./data/summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Creating table with emissions from motor vehicle per year in Baltimore
BaltimoreVehicleEmissionsPerYear = summarize(group_by(filter(NEIdp, fips=="24510",
        type=="ON-ROAD"), year), sum(Emissions))
BaltimoreVehicleEmissionsPerYear = mutate(BaltimoreVehicleEmissionsPerYear,
        Place =  "Baltimore")

# Creating table with emissions from motor vehicle per year in Los Angeles
LAVehicleEmissionsPerYear = summarize(group_by(filter(NEIdp, fips=="06037",
        type=="ON-ROAD"), year), sum(Emissions))
LAVehicleEmissionsPerYear = mutate(LAVehicleEmissionsPerYear, Place =  "Los Angeles")

# RBinding tables
BaltimoreAndLA <- rbind(BaltimoreVehicleEmissionsPerYear, LAVehicleEmissionsPerYear)

# Renaming columns
colnames(BaltimoreAndLA) <- c("Year", "Emissions", "Place")

# Converting year to string
BaltimoreAndLA$Year <- as.character(BaltimoreAndLA$Year)

# Plotting the png file
png("plot6.png")
qplot(Year, data = BaltimoreAndLA, geom = "bar", weight = Emissions, facets = .~Place,
        fill = Year, main = "Baltimore and Los Angeles - Emissions from Motor Vehicle",
        xlab = "", ylab = "Emissions (PM 2.5) in Tons")
dev.off()