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
## Filter "Coal Combustion" from "Source_Classification_Code.rds" to get SCC number
##
CombustionIndexes <- c(grep("combust", SCC$SCC.Level.One , ignore.case = T))
CoalCombIndexes <- c(grep("coal", ignore.case = T, SCC$SCC.Level.Three[CombustionIndexes]))
SCCNumber <- as.character(SCC$SCC[CoalCombIndexes])


##
## Filter "Coal Combustion" related Emission Data from "summarySCC_PM25.rds"
##
CoalCombEmissions <- NEI[NEI$SCC %in% SCCNumber, ]

library(dplyr)
CoalCombSum <- CoalCombEmissions %>% group_by(year) %>% summarise_at(c("Emissions"), sum)


##
## Draw plot nad dump to PNG file
##
g <- ggplot(CoalCombSum, aes(year, Emissions))
finalout <- g + geom_point() 
ggsave(finalout, file="./plot4.png")


##
## Cleanup
##
rm(NEI, SCC, CombustionIndexes, CoalCombIndexes, SCCNumber, CoalCombEmissions, CoalCombSum, g, finalout)


