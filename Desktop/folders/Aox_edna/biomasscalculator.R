#####
# This script will help to indicate biomass present for Sturgeon individuals in 
# the study area.  It takes estimated biomass levesl from sites on sampling days
# takes those means, sums them, and divides by the number of Liters of water present
# in the study area.  This gives a biomass concentration of g/L which can be converted to
# whatever concentration necessary.
# Jameson Hinkle 4/28/15
#####

mass <- read.csv("Aoxbiomass_2015.csv", sep = ",", header = T)
B107 <- (mean(mass$B107)) * 1000
App.1.5 <- (mean(mass$App.1.5)) * 1000
Presquile <- (mean(mass$Presquile)) * 1000
B138 <- (mean(mass$B138)) * 1000
B150 <- (mean(mass$B150)) * 1000
total <- B107 + App.1.5 + Presquile + B138 + B150
CBP_vol <- 286187500000
biomass_conc <- total/CBP_vol
#fall 2015 = 0.0003764315 g/L, or 376.4315 ug/L

# answer is concentration in g/L

# error rates by site

error.B107 <- qt(0.975, df = length(mass$B107) - 1)*sd(mass$B107)/sqrt(length(mass$B107))
error.App.1.5 <- qt(0.975, df = length(mass$App.1.5) - 1)*sd(mass$App.1.5)/sqrt(length(mass$App.1.5))
error.Presquile <- qt(0.975, df = length(mass$Presquile) - 1)*sd(mass$Presquile)/sqrt(length(mass$Presquile))
error.B138 <- qt(0.975, df = length(mass$B138) - 1)*sd(mass$B138)/sqrt(length(mass$B138))
error.B150 <- qt(0.975, df = length(mass$B150) - 1)*sd(mass$B150)/sqrt(length(mass$B150))
