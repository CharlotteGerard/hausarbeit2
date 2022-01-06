#### Aufgabe 3
## a) 

install.packages("purrr")
library(purrr)
co2data <- readRDS("co2data.Rds")

co2_only <- list()

for (i in 2005:2011) {
  co2_only <- c(co2_only, subset(co2data, year == i, select = CO2emission))
  }

mean_co2 <- map_dbl(co2_only, mean, na.rm = TRUE)
names(mean_co2) <- c(2005:2011)
mean_co2
