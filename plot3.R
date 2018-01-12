##
## Author: Chen Ye
## 

## download files to local and load into R
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url, destfile = "./exdata-data-NEI_data.zip", method = "curl")
#unzip(exdata-data-NEI_data.zip)
#NEI <- readRDS("./summarySCC_PM25.rds")


##
## Load "summarySCC_PM25.rds" and "Source_Classification_Code.rds" to R workspace
##
NEI <- readRDS("./summarySCC_PM25.rds")


##
## Filter "Baltimore City"; 
##

bc <- NEI[NEI$fips == "24510", ]

### Used to merge different types into a dataframe however it couldn't be used for ggplot to draw graphs
#splitype <- split(bc, bc$type)
#emsnonp <- with(splitype$NONPOINT, tapply(Emissions, year, sum, na.rm=T))
#emsp <- with(splitype$POINT , tapply(Emissions, year, sum, na.rm=T))
#emsnonr <- with(splitype$`NON-ROAD` , tapply(Emissions, year, sum, na.rm=T))
#emsor <- with(splitype$`ON-ROAD` , tapply(Emissions, year, sum, na.rm=T))
#mtx <- cbind(emsnonp, emsp, emsnonr, emsor)
# rownames(mtx1) <- as.character(unique(bc$year))
# colnames(mtx1) <- as.character(c("NONPOINT", "POINT", "NON-ROAD", "ON-ROAD"))
# mtx1
#     NONPOINT     POINT  NON-ROAD   ON-ROAD
#1999 2107.625  296.7950 522.94000 346.82000
#2002 1509.500  569.2600 240.84692 134.30882
#2005 1509.500 1202.4900 248.93369 130.43038
#2008 1373.207  344.9752  55.82356  88.27546


##
## sort by type and year, get sum of Emissions for each
##

bcplot <- bc %>% group_by(type, year) %>% arrange(year) %>% summarise_at(c("Emissions"), sum)


##
## Draw plot nad dump to PNG file
##

g <- ggplot(bcplot, aes(year, Emissions))
finalout <- g + geom_point() + facet_grid( . ~ type)
ggsave(finalout, file="./plot3.png")


##
## Cleanup
##
#rm(url, NEI, bc, bcplot, g)
rm(NEI, bc, bcplot, g, finalout)