ui <- fluidPage(
  
  navbarPage( title = "Young Carer Grant",
            tabPanel("Main",
                     fluidRow(
                       column(4,
                              "Navigation",
                              selectInput("tab1_nav",
                                "What to plot?",
                                choices = list("total_applications_received",
                                               "total_applications_processed",
                                               "of_which_authorised")
                                          )
                              ),
                       column(8,
                              "Plot",
                              textOutput("title_plot_1"),
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
