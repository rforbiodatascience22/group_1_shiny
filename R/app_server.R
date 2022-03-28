#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @importFrom magrittr %>%
app_server <- function(input, output, session) {
  # Your application server logic
  mod_plotting_server("plotting_1")
  mod_dna_expression_server("dna_expression_1")

  #Plotting module server logic
  output$abundance <- renderPlot({
    if(input$peptide == ""){
      NULL
    } else{
      input$peptide %>%
        biocentralapp:::seq_count() +
        ggplot2::theme(legend.position = "none")
    }
  })
}
