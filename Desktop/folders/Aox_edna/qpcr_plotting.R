#######
# This Script takes imported qPCR data and helps to plot in a better looking manner for 
# publication.  Need Unknowns and Standards, and plot against each other in an Lm, 
# then plot with equation/R^2 on graph
# Jameson Hinkle
# 4/8/15
#######

rawdata <-read.csv("masstest_21116.csv", sep = ",", header = T)
qpcr <- read.csv("masstest_21116.csv", sep = ",", header = T)
# standard curve data
qpcr$SQ <- log(qpcr$SQ)
# log transform as in bio-rad software
d <- qpcr[ qpcr$Content=="Std",]
t <- qpcr[ qpcr$Content== "Unknown" ,]#use this with tank standard curve contained
r <- qpcr[ qpcr$Content == "Real" ,]
# grab only standards
p <- ggplot(d, aes(x = SQ, y = Cq)) + geom_point() + stat_smooth(method = lm)
# run lm on standards only
p + geom_point( aes(x=SQ,y=Cq), data=qpcr[ qpcr$Content=="Unkn",],color="red") + geom_point(aes(x=SQ, y=Cq), data = qpcr[qpcr$Content=="Real" ,], color = "yellow") + labs(title = "Standard Curve of CoxII qPCR for Atlantic Sturgeon") + theme_bw()
  
# add unknowns in different color and title

# set up equation and R^2 for plotting on graph
m <- lm(d$Cq ~ d$SQ)
a <- signif(coef(m)[1], digits = 4)
b <- signif(coef(m)[2], digits = 4)
R2 <- 0.99
textlab <- paste("y = ",b,"x + ",a , ", R^2 = ", R2, sep="")
print(textlab)

# add equation and R^2 to graph
p <- p + geom_point( aes(x=SQ,y=Cq),data=qpcr[ qpcr$Content=="Unkn",],color="red") + geom_point(aes(x=SQ, y=Cq), data = qpcr[qpcr$Content=="Real" ,], color = "yellow") + geom_text(aes(x = 21, y = 38, label = textlab), color="black", size=5, parse = FALSE) + theme_bw() + labs(title = "Atlantic Sturgeon Biomass Estimates, Fall 2015")

# select for sites that have real positive results

real <- rawdata [ rawdata$Content == "Unkn" ,]

data <- subset(real, Cq <= 35.05482, select = c(Well, Content,Cq, SQ)) #may have to adjust based on new biomass curve

plot <- ggplot(data, aes(x = factor(Well), y = SQ, fill = factor(Well))) + geom_bar(stat = "identity")

p_date <- data.frame(Well = data$Well, Content = data$Content, Cq = data$Cq, SQ = data$SQ, date = as.Date(c("2015-10-27", "2015-9-15", "2015-9-29", "2015-9-29")))

plot <- ggplot(p_date, aes(x = factor(date), y = SQ, fill = factor(Well))) + geom_bar(stat = "identity") + theme_bw()
# plots biomass by "well", which will be site, will need timing built into data frame for this
# then do x = factor(time), y = SQ, fill = factor(Well).  Well will = location
# Look at page 42 in "applied population genetics" for bargraph info, going to need 
# month and location data to make this work.

###confidence interval

t.test(qpcr$SQ)

# take exp() for inverse log to get back to actual biomass
exp(15.63590)

exp(18.87899)


