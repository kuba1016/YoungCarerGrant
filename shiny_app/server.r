server <- function(input, output) {
  
  output$plot_1_1 <-  renderPlot({
    var = sym(input$tab1_nav)
    by_location %>% 
      filter(!is.na(!!var)) %>% 
      arrange(!!var) %>% 
      mutate(location = factor(location,levels = location)) %>% 
      ggplot() +
      aes_string("location", input$tab1_nav) +
      geom_col(fill = "black") +
      coord_flip() +
      theme_minimal()
    
    
  })
    
 

  
}