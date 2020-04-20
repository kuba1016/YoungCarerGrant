ui <- fluidPage(
  
  navbarPage( title = "Young Carer Grant",
            tabPanel("Main",
                     fluidRow(
                       column(3,
                              "Navigation",
                              selectInput("tab1_nav",
                                "What to plot?",
                                choices = by_location %>% select(-location) %>% colnames()
                                          )
                              ),
                       column(6,
                              "Plot",
                              plotOutput("plot_1_1")
                              )
                     )
                     
                     
            ),
            tabPanel("Maps",
                     fluidRow(
                       column(4,
                              "Navigation"
                       ),
                       column(8,
                              "Plot"
                       )
                     )
            ),
            tabPanel("about",
                     fluidPage(
                       
                     )
            )
  )
  
  

)
