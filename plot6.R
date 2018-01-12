##
## Author: Chen Ye
## 


## download files to local and load into R
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url, destfile = "./exdata-data-NEI_data.zip", method = "curl")
#unzip(exdata-data-NEI_data.zip)


##
## Load "summarySCC_PM25.rds" and "Source_Classification_Code.rds" to R workspace
##
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##
## Filter "Vehicle" from "Source_Classification_Code.rds" to get SCC number
##
VehicleIndex <-  c(grep("vehicle", ignore.case=T, SCC$SCC.Level.Two))
SCCNumber <- as.character(SCC$SCC[VehicleIndex] )


##
## Filter "Vehicle" related observation data from "summarySCC_PM25.rds" and get sum of Baltimore emissions each year
##
VehicleEmissions <- NEI[NEI$SCC %in% SCCNumber, ]

library(dplyr)
BalVehicleSum <- VehicleEmissions %>% filter(fips == "24510" | fips == "06037") %>% group_by(fips, year) %>% summarise_at(c("Emissions"), sum)


##
## Draw plot nad dump to PNG file
##
g <- ggplot(BalVehicleSum, aes(year, Emissions))
finalout <- g + geom_point() + facet_grid(.~fips)  
ggsave(finalout, file="./plot6.png")


##
## Cleanup
##
rm(NEI, SCC, VehicleIndex, SCCNumber, VehicleEmissions, BalVehicleSum, g, finalout)