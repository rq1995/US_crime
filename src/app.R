library(shiny)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(htmltools)
library(RColorBrewer)
library(colourpicker)
library(plotly)

# import previously cleaned data
crime <- read_csv("https://raw.githubusercontent.com/rq1995/US_crime/master/data/ucr_crime_1975_2015.csv")


#create lists to use for input selection
department<-unique(crime$department_name)
department_short <- head(department)
year<-unique(crime$year)

# UI for application 
ui <- fluidPage(
  
  # Application title
  titlePanel("Crime Data Analysis in US"),
  
  # Input and layout
  sidebarLayout(
    sidebarPanel(
      p("This app can help people to discover the best city from crime rate and population aspects, before they invest, travel, or select a location to live."),
      br(),
      selectizeInput('regioninput','Region (multiple selections allowed)',choices=department,multiple=TRUE,selected=department_short),
      p('Add new region from dropdown box and strightly delete'),
      br(),
      sliderInput('Yearinput','Year',min=1975,max = 2015,step = 1,value = c(1975,2015)),
      br(),
      radioButtons('crimetypeinput', 'Select crime type',
                 choices = c("Total Violent"="violent_crime", 
                             "Homicide"="homs_sum", 
                             "Rape"="rape_sum", 
                             "Robbery"="rob_sum",
                             "Aggravated Assault"="agg_ass_sum"),
                 selected = "violent_crime")
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Crime Rate of selecte region"),
      plotlyOutput('densityplot',width="100%",height=300),
      br(),
      h4("The trend of population in selecte region"),
      plotlyOutput('lineplot',width="100%",height=300)
    )
  )
)

# Define server 
server <- function(input, output,session) {
  
  output$densityplot <- renderPlotly({
    filtered <-
      crime %>%
      filter(department_name %in% input$regioninput,
             year >= as.numeric(input$Yearinput[1]) & year <= as.numeric(input$Yearinput[2]))
    if (input$crimetypeinput=="violent_crime") {
      ggplot(filtered, aes(year, violent_per_100k,colour=department_name)) +
        geom_line()+
        geom_point(aes(alpha=0.2))+guides(colour = FALSE)
    }else if(input$crimetypeinput=="homs_sum") {
      ggplot(filtered, aes(year,homs_per_100k,colour=department_name)) +
        geom_line()+geom_point(aes(alpha=0.2))+guides(colour = FALSE,alpha=FALSE)
    }else if (input$crimetypeinput=="rape_sum") {
      ggplot(filtered, aes(year,rape_per_100k,colour=department_name)) +
        geom_line()+geom_point(aes(alpha=0.2))+guides(colour = FALSE)
    }else if (input$crimetypeinput=="rob_sum") {
      ggplot(filtered, aes(year,rob_per_100k,colour=department_name)) +
        geom_line()+geom_point(aes(alpha=0.2))+guides(colour = FALSE)
    }else if (input$crimetypeinput=="agg_ass_sum") {
      ggplot(filtered, aes(year,agg_ass_per_100k,colour=department_name)) +
        geom_line()+geom_point(aes(alpha=0.2))+guides(colour = FALSE)
    }
})

  
  output$lineplot <- renderPlotly({
    
    filtered <-
      crime %>%
      filter(department_name %in% input$regioninput,
             year >= as.numeric(input$Yearinput[1]) & year <= as.numeric(input$Yearinput[2]))
      ggplot(filtered,aes(x = year, y =total_pop)) +
      geom_line()+
      facet_wrap(~ department_name)+
      theme_bw() 
  })
}

# Run the application 
shinyApp(ui = ui, server = server)