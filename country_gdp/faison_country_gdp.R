
library(tidyverse)
library(shiny)
library(shinydashboard)

#read in data as a csv from "https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv" 
data<-read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv", header=T, stringsAsFactors = T)


country_data<-data %>%
  filter(country=="Jordan" | country=="Afghanistan")

#build dashboard

header <- dashboardHeader()
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Life Expectancy", tabName="life"),
    menuItem("Gross Domestic Product",tabName='gdp')
  ))
body <- dashboardBody(
  tabItems(
    tabItem(tabName="life",
            fluidRow(
              box(
                selectInput(input='life_select', label='Select country',choices=unique(country_data$country), selected = 'life_country'))
            ),
            fluidRow(
              box(width=12,
                  plotOutput('life_graph')
              ))),
    tabItem(tabName="gdp",
            fluidRow(
              box(
                selectInput(input='gdp_select',label='Select country', choices=unique(country_data$country), selected = 'gdp_country'))),
            fluidRow(
              box(width=12,
                  plotOutput('gdp_graph')),

            ))))


ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  output$life_graph<-renderPlot({
    ggplot(filter(country_data, country==input$life_select), aes(x=year,y=lifeExp))+
      geom_col() 
  })
  
  output$gdp_graph<-renderPlot({
    ggplot(filter(country_data, country==input$gdp_select), aes(x=year,y=gdpPercap))+
      geom_col() 
  })
  
}

shinyApp(ui, server)