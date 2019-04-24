# Source the etl for data
library(readr)
library(ggplot2)
library(tidyr)
library(ggpubr)
library(dplyr)
library(plyr)

SPdata <- read.csv("./data/SUPERMARKETcluster.csv")


#SPdata$klusterModel.cluster.o. <- as.character(SPdata$klusterModel.cluster.o.)
SPdata$klusterModel.cluster.o. <- as.factor(SPdata$klusterModel.cluster.o.)




SPagg <- count(SPdata, c("status", "expense", "klusterModel.cluster.o."))

t <- ggplot(SPagg, aes(x="", y=freq))+
  geom_col(aes(fill=status)) +
  facet_grid(klusterModel.cluster.o.~as.factor(expense))+
  labs(title="", 
       x="", y="")+
  theme(axis.text.x=element_blank(),
        axis.text.y=element_text(size=5),
        legend.position = "none")


SPdata <- SPdata[,-24]
SPdata <- SPdata[,-1]



