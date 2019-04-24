library(shiny)
library(shinydashboard)
library(readr)
library(ggplot2)
library(tidyr)
library(ggpubr)
library(plotly)
library(rsconnect)
library(DT)

# Define UI for application that draws a histogram
shinyUI(navbarPage("SUPERMARKET", id="nav",

                   
                   
                   #-------- BODY  
                   tabPanel("Customer Insight",
                            fluidRow( #ROW 1
                              tabBox(id="plottab1", title=h3(strong("Customers distribution by age and monthly expense")),
                                     tabPanel("All customers", plotOutput("category1", width=650, height=500)),
                                     tabPanel("by Customers type", plotOutput("category2", width=650, height=500))
                              ),
                              box(title = h3("Customer's quadrant"), 
                                  "This visualization is based on a questionnaire to 100 customers about what aspect do they consider important in choosing a supermarket to shop at.",
                                  br(),
                                  "The majority of our customers are below 30 years old with 100-300k monthly expense for grocery shopping in supermarket.",
                                  br(),
                                  br(),
                                  h4(strong(em("What are our customer types?"))),
                                  "By using Cluster Analysis, our customers are divided into 3 types:",
                                  br(),
                                  br(), #warnain sesuai warna di grafik ea
      h4(strong("Perfectionist (PFC) - 11%")),
      "Everything is important for them. They're looking for supermarket that resembles Ed Sheeran'ss song, Perfect. Complete and varied products, nice layout, affordable price, delivery service, clean, safe, etc. Good news for our marketing budget, they don't care about discount & celebrity events. Bad news, there are only 11 people in this category.",
      br(),
      br(),
      h4(strong("Entertainment Lovers (ENT) - 49%")),
      "Comes for doorprize and celebrity's event. Most of them are youngsters (<=30 years old). Nevertheless, they still consider other aspects important",
      br(),
      br(),
      h4(strong("I-dont-care Type (IDC) - 40%")),
      "All they care is about completeness and variation. Housewives and freelancers are the most in this category. Location is very important to them. They don't consider discount and delivery service important. The 'shop-and-go' busy people."
 
      )
    ),
    
    fluidRow(
      box(height=100)),
    
    fluidRow( #ROW2
      box(title = "Kids and Expense", height=550,
          "When you're single, you buy things only for yourself. But when you already have children, you have to buy more things for them also! About 42 % of our customers are moms & dads who spend >300k/month for grocery. The graph shows your shopping expense increases if you have children.",
          br(),
          br(),
          h4(strong("Proposed strategy:")),
          h5(strong("Improving all operational aspect")),
          "Although lot of our customers are I-don't-care type, why don't strive to provide best service? The Perfectionists are just 11% but mouth-to-mouth advertisement is powerful. If we doesn't satisfy this 11%, they can influence the others. Most of them are millennial (< 35 years old) & they tend to share experience in social media. Once their disappointment of our service goes viral, it's the end for us.",
          br(),
          br(),
          h5(strong("Since celebrity is somehow favored...")),
          "We could try endorsing celebrity to boost customer's spending If they spent certain amount, they have chance to meet & greet or photo together with the celebrity. Look for celeb who are loved by both men and women, married or not (like Nicholas Saputra), He's Indonesian most machoman who can also attract the singles!"
          ),
      box(title = "", height=550,
          plotlyOutput("t")
      )
    ),
    
    fluidRow(
      box(height=50, background="black", h6("2019 (c) Soraya Rizka. Check my other visualization ", a("here", href="https://sorayarizka.carrd.co/")))
    )
  ), #END tabPanel Customer Insight

  tabPanel("Cluster Analysis",
    fluidRow(title="",
          box(
             h2("Cluster Analysis"),
             "Cluster analysis is used to categorize data which have the similar behavior.",
            br(),
            "Hence, we can put each of our respondent into clusters and analyze what makes them similar.",
            br(),
            br(),
            "All of this analysis are made using Rstudio and steps taken are:",
            br(),
            br(),
            "1.	Look for ideal number of clusters",
            br(),
            "2.	Inspect k-means score to discover underlying patterns",
            br(),
            "3.	Check the cluster overlapping using venn diagram",
            br(),
            "4.	Assign each respondent to every clusters"
            
             ),
          
          box(h2("Step by Step"),
            h4("1.	Look for ideal number of clusters "),
            "After doing analysis with fviz_nbclust(), we found that the ideal number of cluster for our Supermarket Customer data is 3",
             br(),
             br(),
             code("fviz_nbclust(getdata, kmeans, method = ''silhouette'')+"),
             br(),
             img(src = 'silhouette.png', height=200),
             br(),
             br(),
            h4("2.	Inspect k-means score to discover underlying patterns"),
             "Insert to kmeans() formula using 3 cluster and get this result, and then give scoring to each.",
             br(),
             code("set.seed(123)"),
             br(),
             code("klusterModel <- kmeans(getdata, 3, iter.max=25)"),
             br(),
             code("summary(klusterModel)"),
             br(),
             code("t(klusterModel$centers)"),
             br(),
             br(),
             img(src = 'kmeans_result.png', height=300), img(src = 'kmeans_scoring.png', height=300),
             br(),
             br(),
            h4("3.	Check the cluster overlapping using venn diagram"),
             "Making the cluster venn diagram using this clusplot",
             br(),
             code("clusplot(getdata, klusterModel$cluster, main='Clusters of Supermarket Customers',"),
             br(),
             code("color=T, shade=T, labels=2, lines=0)"),
             br(),
            br(),
            "Only few of our respondent is overlapping in 2 cluster. That means, this model is good",
             br(),
             img(src = 'clusters.png', height=300),
             br(),
             br(),
            h4("4.	Assign each respondent to their clusters"),
             "Who gets which cluster? We would like to assign which cluster he/se belongs to the for each respondent",
             br(),
             code("o=order(klusterModel$cluster)"),
             br(),
             code("nama <- data.frame(superdata$cust_name[o], klusterModel$cluster[o])"),
             br(),
             code("table(nama$klusterModel.cluster.o.)"),
             br(),
             br(),
             img(src = 'names.png', height=200)
             )
    )
          ,
    fluidRow(
      box(height=50, background="black", h6("2019 (c) Soraya Rizka. Check my other visualization ", a("here", href="https://sorayarizka.carrd.co/", alight="right")))
    )
  ), #END tabPanel Cluster Analysis

  tabPanel("Raw data",
    fluidRow(
      box(title=h4("About the Data"), "The survey was distributed to 100 of our customers.",
          br(),
          "A set of questions are set to identify the importance of 13 aspect in a supermarket:",
          br(),
          strong("- product completenes"),
          br(),
          strong("- product variation"),
          br(),
          strong("- supermarket layout"),
          br(),
          strong("- facility"),
          br(),
          strong("- staff friendliness"),
          br(),
          strong("- delivery service"),
          br(),
          strong("- cleanliness"),
          br(),
          strong("- safety"),
          br(),
          strong("- price"),
          br(),
          strong("- location"),
          br(),
          strong("- parking availability"),
          br(),
          strong("- discount"),
          br(),
          strong("- celebrity events"),
          br(),
          "Scoring ranges from 1 (not important) to 5 (very important).",
          br(),
          br(),
          "Some demographic questions such as gender, children/no children, age, highest education, occupation, and monthly expense for grocery shopping are also required.",
          br(),
          br(),
          "Dataset by Big Data Analysis and Social Simulation Laboratory, SBM ITB",
          br(),
          a("Get the GitHub code", href="https://github.com/soraya-rk/supermarket"),
          br(),
          br(),
          br()
      ),
      
      box(title="",
            dataTableOutput("mytable"), style="overflow-y:scroll;", width=100),
         
      
      fluidRow(
        box(height=50, background="black", h6("2019 (c) Soraya Rizka. Check my other visualization ", a("here", href="https://sorayarizka.carrd.co/", alight="right")))
      )
      
)
  ) #END tabPanel Raw data


#ShinyUI END
))
