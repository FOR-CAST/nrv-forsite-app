#' regions UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_regions_ui <- function(id) {
  ns <- NS(id)
  tagList(
    wellPanel(
      style = "padding-bottom: 0rem;",

      fluidRow(
        column(
          width = 6,

          shinyWidgets::pickerInput(
            inputId = ns("regions_element"),
            label = "Select element:",
            choices = ELEMENT_NAMES,
            options = list(
              `live-search` = TRUE
              # style = "border-color: #999999;"
              # style = paste0(
              #   "background-color: white; ",
              #   "border-color: #999999; ",
              #   "font-family: 'Helvetica Neue' Helvetica; ",
              #   "font-weight: 200;"
              # )
            )
          )
        ),

        column(
          width = 6,

          shinyWidgets::pickerInput(
            inputId = ns("regions_region"),
            label = "Region:",
            choices = REGION_NAMES,
            options = list(
              `live-search` = TRUE
              # style = "border-color: #999999;"
              # style = paste0(
              #   "background-color: white; ",
              #   "border-color: #999999; ",
              #   "font-family: 'Helvetica Neue' Helvetica; ",
              #   "font-weight: 200;"
              # )
            )
          )
        )
      )
    ),

    br(),

    fluidRow(
      column(
        width = 4,

        plotOutput(outputId = ns("regions_map"), height = "375px")
      ),

      column(
        width = 8,

        ## TODO: tab panel for each NRV indicator group plot
        tabsetPanel(
          tabPanel("Indicator 1", uiOutput(ns("regions_indicator_1_png"))),
          tabPanel("Indicator 2", uiOutput(ns("regions_indicator_2_png"))),
          tabPanel("Indicator 3", uiOutput(ns("regions_indicator_3_png"))),
          tabPanel("Indicator 4", uiOutput(ns("regions_indicator_4_png")))
        )
      )
    )
  )
}

#' regions Server Functions
#'
#' @noRd
mod_regions_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Update the options under "Element Name" based upon the selection in the
    # "Element Type" list
    observe({
      req(input$regions_element_type)

      element_type <- tolower(input$regions_element_type)

      updateSelectInput(
        session = session,
        inputId = "regions_element",
        choices = ELEMENT_NAMES[[element_type]]
      )
    })

    # Render the inset map visual
    output$regions_map <- renderPlot({
      req(input$regions_region)

      map_region(region = input$regions_region)
    })

    # Get the path to each png file based on the selected region input
    ## TODO: populate with actual data
    NRV_INDICATOR_PNG <- data.frame(
      TYPE = "ecoprovinces",
      ID = REGIONS$ecoprovinces$ID,
      NAME = REGIONS$ecoprovinces$NAME
    ) |>
      dplyr::cross_join(data.frame(
        INDICATOR_NAME = c(
          "burnSummaries_cumul_burn_hst",
          "burnSummaries_cumul_burn_sim",
          "NRV_summary_lm",
          "NRV_summary_pm"
        ),
        INDICATOR_PNG = c(
          "placeholder1.png",
          "placeholder2.png",
          "placeholder3.png",
          "placeholder4.png"
        )
      ))

    ## TODO: rename these to match actual indicator names
    indicator_1_png <- reactive({
      req(input$regions_region)

      region_id <- stringr::str_extract(input$regions_region, "(?<=\\[).*(?=\\])")
      row <- dplyr::filter(
        NRV_INDICATOR_PNG,
        ID == region_id,
        INDICATOR_NAME == "burnSummaries_cumul_burn_hst"
      )
      # file.path("outputs", row$ID, "1991-2020", "NRV", row$INDICATOR_NAME, row$INDICATOR_PNG)
      file.path("img", row$INDICATOR_PNG)
    })

    output$regions_indicator_1_png <- renderUI({
      img(src = indicator_1_png(), width = "100%", height = "auto")
    })

    indicator_2_png <- reactive({
      req(input$regions_region)

      region_id <- stringr::str_extract(input$regions_region, "(?<=\\[).*(?=\\])")
      row <- dplyr::filter(
        NRV_INDICATOR_PNG,
        ID == region_id,
        INDICATOR_NAME == "burnSummaries_cumul_burn_sim"
      )
      # file.path("outputs", row$ID, "1991-2020", "NRV", row$INDICATOR_NAME, row$INDICATOR_PNG)
      file.path("img", row$INDICATOR_PNG)
    })

    output$regions_indicator_2_png <- renderUI({
      img(src = indicator_2_png(), width = "100%", height = "auto")
    })

    indicator_3_png <- reactive({
      req(input$regions_region)

      region_id <- stringr::str_extract(input$regions_region, "(?<=\\[).*(?=\\])")
      row <- dplyr::filter(NRV_INDICATOR_PNG, ID == region_id, INDICATOR_NAME == "NRV_summary_lm")
      # file.path("outputs", row$ID, "1991-2020", "NRV", row$INDICATOR_NAME, row$INDICATOR_PNG)
      file.path("img", row$INDICATOR_PNG)
    })

    output$regions_indicator_3_png <- renderUI({
      img(src = indicator_3_png(), width = "100%", height = "auto")
    })

    indicator_4_png <- reactive({
      req(input$regions_region)

      region_id <- stringr::str_extract(input$regions_region, "(?<=\\[).*(?=\\])")
      row <- dplyr::filter(NRV_INDICATOR_PNG, ID == region_id, INDICATOR_NAME == "NRV_summary_pm")
      # file.path("outputs", row$ID, "1991-2020", "NRV", row$INDICATOR_NAME, row$INDICATOR_PNG)
      file.path("img", row$INDICATOR_PNG)
    })

    output$regions_indicator_4_png <- renderUI({
      img(src = indicator_4_png(), width = "100%", height = "auto")
    })
  })
}
