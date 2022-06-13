

ui <- fluidPage(titlePanel("Life Expectancy and GDP in Australia and Brazil"),
                # Add select input named "country" to choose between "Australia" and "Brazil"
                sidebarLayout(
                  sidebarPanel(
                    selectInput('country',
                                'Select Country',
                                selected = 'Australia',
                                choices = c("Australia", "Brazil"))),
                  # Add plot output 
                  mainPanel(
                    tabsetPanel(
                      tabPanel('Life Expectancy', plotOutput('plot_lifeExp')),
                      tabPanel('GDP', plotOutput('plot_gdp'))
                    )
                  )
                ))

server <- function(input, output, session){
  
  output$plot_lifeExp <- renderPlot({
    data_country <- subset(
      data_filtered, country == input$country
    )
    ggplot(data_country) +
      geom_col( 
        aes(x = year, y = lifeExp))
  }) 
  
  output$plot_gdp <- renderPlot({
    data_country <- subset(
      data_filtered, country == input$country
    )
    ggplot(data_country) +
      geom_col( 
        aes(x = year, y = gdpPercap))
  })
}

shinyApp(ui = ui, server = server)

  