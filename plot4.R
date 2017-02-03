## Code for Question 4
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

# Reading data and merging the tables

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)
NEI_SCC <- merge(NEI, SCC, by = "SCC")
NEI_SCCdp <- tbl_df(NEI_SCC)

# Creating coal column
NEI_SCCdp <- mutate(NEI_SCCdp, coal = grepl("coal", NEI_SCCdp$Short.Name, ignore.case=TRUE))

# Renaming columns
EmissionsCoalPerYear <- summarize(group_by(filter(NEI_SCCdp, coal==TRUE),year),sum(Emissions))
colnames(EmissionsCoalPerYear) <- c("Year", "Emissions")

# Converting year to string
EmissionsCoalPerYear$Year <- as.character(EmissionsCoalPerYear$Year)

# Converting emissions in kilotons
EmissionsCoalPerYear$EmissionsInKilotons = EmissionsCoalPerYear$Emissions/1000

# Plotting the png file
library(ggplot2)
png("plot4.png")
g <- ggplot(EmissionsCoalPerYear, aes(Year, EmissionsInKilotons))
g+geom_bar(stat = "identity") + labs(title = "United States - Emissions from coal combustion-related sources",
        x = "Years", y = "Emissions (PM 2.5) in Kilotons")
dev.off()