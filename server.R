library(shiny)
library(readr)
library(ggplot2)
library(tidyr)
library(ggpubr)
library(plotly)
library(rsconnect)
library(DT)
library(plyr)
source("charts super.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  output$t <- renderPlotly({
    ggplotly(t,originalData = F)
  })
  #output$selected_images <- renderImage({"./image/diagram.png"})
  
  output$category1 <- renderPlot({
    ggplot(SPdata, aes(x=age, y=expense, col=klusterModel.cluster.o., size=2))+
      geom_jitter(aes(alpha=0.5))+
      labs(x="Customer's age", y="Monthly expense")+
      theme(legend.position = "bottom",
            axis.text.x = element_text(hjust = 2, size=5),
            axis.text.y = element_text(angle = 90, hjust = 5, size=7))+
      scale_alpha(guide = 'none')+
      scale_size(guide = 'none')
  })
  
  output$category2 <- renderPlot({
    ggplot(SPdata, aes(x=age, y=expense, col=klusterModel.cluster.o., size=2))+
      geom_jitter(aes(alpha=0.5))+
      facet_wrap(~as.factor(klusterModel.cluster.o.), ncol=4)+
      labs(x="Customer's age", y="Monthly expense")+
      theme(legend.position = "none",
            axis.text.x = element_text(hjust = 2, size=5),
            axis.text.y = element_text(angle = 90, hjust = 5, size=7))+
      scale_alpha(guide = 'none')+
      scale_size(guide = 'none')
  })
  
  output$mytable = renderDataTable({
    SPdata
})
 
#shinyServer END
  })
