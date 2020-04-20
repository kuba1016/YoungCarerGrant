server <- function(input, output) {
  
  output$plot_1_1 <-  renderPlot({
    
    by_location %>% 
      filter(!is.na(total_applications_received)) %>% 
      arrange(total_applications_received) %>% 
      mutate(location = factor(location,levels = location)) %>% 
      ggplot() +
      aes(location, total_applications_received) +
      geom_col(fill = "black") +
      coord_flip() +
      theme_minimal()
    
    
  })
    
 

  
}