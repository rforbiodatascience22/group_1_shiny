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
             numericInput(ns("dna_length"),
                          label = "Random DNA length",
                          value = 3000,
                          min = 3,
                          max = 10**6,
                          step = 1),
             actionButton(ns("generate_dna"),
                          label = "Generate random DNA")
      )
    ),
    verbatimTextOutput(ns("peptide"))
  )
}

#' dna_expression Server Functions
#'
#' @noRd
mod_dna_expression_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    dna <- reactiveVal()
    codon_table <- biocentral::codon_table

    output$DNA <- renderUI({
      textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    observeEvent(input$generate_dna, {
      dna(
        biocentral::createdna(input$dna_length)
      )
    })

    observeEvent(input$DNA,{
      output$peptide <- renderText({
        # Ensure input is not NULL and is longer than 2 characters
        if(is.null(input$DNA)){
          NULL
        } else if(nchar(input$DNA) < 3){
          NULL
        } else{
          input$DNA %>%
            toupper() %>%
            biocentral::dna_to_rna() %>%
            biocentral::codon_start() %>%
            biocentral::codon2amino()
        }
      })
    })
  })
}

## To be copied in the UI
# mod_dna_expression_ui("dna_expression_1")

## To be copied in the server
# mod_dna_expression_server("dna_expression_1")
