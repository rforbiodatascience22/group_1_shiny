#' dna_expression UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_dna_expression_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 8, 
             uiOutput(ns("DNA"))
      ),
      column(width = 4, 
             numericInput(ns("random_dna_length"),
                          label = "Random DNA length",
                          value = 3000,
                          min = 3,
                          max = 10**6,
                          step = 1), 
             actionButton(ns("random_dna_button"),
                          label = "Generate random DNA")
      )
    ),
    verbatimTextOutput(ns("peptide_sequence"))
  )
}
    
#' dna_expression Server Functions
#'
#' @noRd 
mod_dna_expression_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_dna_expression_ui("dna_expression_1")
    
## To be copied in the server
# mod_dna_expression_server("dna_expression_1")
