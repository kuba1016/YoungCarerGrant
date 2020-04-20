ui <- fluidPage(
  
  navbarPage( title = "Young Carer Grant",
            tabPanel("one",
                     fluidRow(
                       column(4,
                              "Navigation"
                              ),
                       column(8,
                              "Plot"
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
