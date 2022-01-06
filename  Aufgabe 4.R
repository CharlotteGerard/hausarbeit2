install.packages("ggplot2")
library(ggplot2)

### Graph 1

## select countries
countries <- subset(alcohol_consumption, 
                    Entity %in% c("China", "Germany", "Netherlands", 
                                  "United States"))

# rename 4th column
alcPerCap <- unlist(countries[,4])

## plot

ggplot(countries, aes(Year, alcPerCap, color = Entity)) +
  geom_line(size = 1) +
  labs(x="Jahr", y="Alkoholkonsum in Liter pro Kopf", 
       title = "Konsum von purem Alkohol in Liter pro Kopf 
       für ausgewählte Staaten") +
  theme_bw() +
  scale_color_manual(labels = c("China", "Deutschland", "Niederlande", "Vereinigte Staaten"),
                     name = "Land",
                     values = c("red", "gold", "#FF9B00", "blue")) +
  theme(element_line(size = 1))

### Graph 2

# filter year 2018 -> no error, but says "arguments must have same length" 
countries_2018 <- subset(alcohol_consumption, Year == 2018)
countries_2018

#rename alc intake per capita in liter
alcPerCap_2018 <- unlist(countries_2018[ ,4])

top20 <- top_n(countries_2018, 20, alcPerCap_2018) # top_n is DYPLR package !!! 



# reordering within plot -> not working. Error: Error in tapply(X = X, INDEX = x, FUN = FUN, ...) : 
# arguments must have same length
ggplot(top20, aes(x = reorder(Code, -countries_2018$`Total alcohol consumption per capita (liters of pure alcohol, projected estimates, 15+ years of age)`), countries_2018$`Total alcohol consumption per capita (liters of pure alcohol, projected estimates, 15+ years of age)`)) +
  geom_bar()

## Option: try plot without re-ordering 
ggplot(countries_2018, aes(Code, alcPerCap_2018)) +
  geom_bar()


ggplot(top20, aes(Code, `Total alcohol consumption per capita (liters of pure alcohol, projected estimates, 15+ years of age)`)) +
  geom_bar() + 
  coord_flip() +
  theme_bw()
