library(shiny)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(htmltools)
library(RColorBrewer)
library(colourpicker)

# import previously cleaned data
crime <- read_csv("https://raw.githubusercontent.com/rq1995/US_crime/master/data/ucr_crime_1975_2015.csv")


#create lists to use for input selection
department<-unique(crime$department_name)
department_short <- head(department)
year<-unique(crime$year)

# UI for application 
ui <- fluidPage(
  
  # Application title
  titlePanel("Crime data for US APP"),
  
  # Input
  sidebarLayout(
    sidebarPanel(
      selectizeInput('regioninput','Region',choices=department,multiple=TRUE,selected=department_short),
      sliderInput('Yearinput','Year',min=1975,max = 2015,step = 1,value = c(1975,2015)),
      radioButtons('crimetypeinput', 'Select type',
                 choices = c("violent_crime", "homs_sum", "rape_sum", "rob_sum","agg_ass_sum"),
                 selected = "violent_crime"),
      colourInput("colourInput1","colour",value="black")
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4(textOutput('text')),
      plotOutput('densityplot'),
      br(),
      ggvisOutput("plot1"),
      br(),
      tableOutput('result')
    )
  )
)

# Define server 
server <- function(input, output,session) {
  
  output$text<-renderText({
    filtered <-
      crime %>%
      filter(department_name== input$regioninput,
             year >= as.numeric(input$Yearinput[1]) & year <= as.numeric(input$Yearinput[2])
      )
    paste0("There are ",input$crimetypeinput, " crime record")
  })
  output$densityplot <- renderPlot({
    filtered <-
      crime %>%
      filter(department_name %in% input$regioninput,
             year >= as.numeric(input$Yearinput[1]) & year <= as.numeric(input$Yearinput[2]))
    if (input$crimetypeinput=="violent_crime") {
      ggplot(filtered, aes(year, violent_per_100k,colour=department_name)) +
        geom_line()+geom_point()+guides(colour = FALSE)
       # geom_path(colour=input$colourInput1)
    }else if(input$crimetypeinput=="homs_sum") {
      ggplot(filtered, aes(year,homs_per_100k,colour=department_name)) +
        geom_line()+geom_point()+guides(colour = FALSE)
    }else if (input$crimetypeinput=="rape_sum") {
      ggplot(filtered, aes(year,rape_per_100k,colour=department_name)) +
        geom_line()+geom_point()+guides(colour = FALSE)
    }else if (input$crimetypeinput=="rob_sum") {
      ggplot(filtered, aes(year,rob_per_100k,colour=department_name)) +
        geom_line()+geom_point()+guides(colour = FALSE)
    }else if (input$crimetypeinput=="agg_ass_sum") {
      ggplot(filtered, aes(year,agg_ass_per_100k,colour=department_name)) +
        geom_line()+geom_point()+guides(colour = FALSE)
    }
})
  output$result<-renderTable({
    filtered <-
      crime %>%
      filter(department_name %in% input$regioninput,
             year >= as.numeric(input$Yearinput[1]) & year <= as.numeric(input$Yearinput[2]))%>%
      group_by(department_name)%>%
      summarise(mean=mean(total_pop))%>%
      select(department_name,mean)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)