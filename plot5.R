## Code for Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Reading data and preparing data

NEI <- readRDS("./data/summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Creating table with emissions from motor vehicle per year in Baltimore
BaltimoreVehicleEmissionsPerYear = summarize(group_by(filter(NEIdp, fips=="24510",
        type=="ON-ROAD"), year), sum(Emissions))

# Renaming columns
colnames(BaltimoreVehicleEmissionsPerYear) <- c("Year", "Emissions")

# Plotting the png file
png("plot5.png")
g <- ggplot(BaltimoreVehicleEmissionsPerYear, aes(Year, Emissions)) +
        scale_x_continuous(breaks = c(1999,2002,2005,2008))
g+geom_point(size=4, color="darkblue") +geom_line(size=1.5, color = "darkblue") +
        labs(title = "Baltimore - Emissions from Motor Vehicle", x = "Years",
        y = "Emissions (PM 2.5) in Tons")
dev.off()