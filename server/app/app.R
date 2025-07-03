# Modular Shiny App for Non-Parametric Statistical Tests
# Main app entry point

# Load required libraries
library(shiny)
library(shinyjs)

# Source utility functions
source("utils/stat_tests.R")
source("utils/csv_utils.R")
source("utils/plot_utils.R")
source("utils/ui_helpers.R")
source("utils/notification_helpers.R")
source("utils/emission_utils.R")

# Source Shiny modules
source("modules/input_panel_module.R")
source("modules/results_panel_module.R")

# Define UI
ui <- fluidPage(
    # Enable shinyjs
    useShinyjs(),

    # App title
    titlePanel("Uji Non Parametrik - Sign, Wilcoxon, Run, & Mann Whitney U"),

    # Main layout
    fluidRow(
        # Input panel (left column)
        column(
            4,
            input_panel_ui("input_panel")
        ),

        # Results panel (right column)
        column(
            8,
            results_panel_ui("results_panel")
        )
    )
)

# Define server logic
server <- function(input, output, session) {
    # Initialize input panel module
    input_panel_values <- input_panel_server("input_panel", session)

    # Initialize results panel module
    results_panel_server(
        "results_panel",
        input_data = input_panel_values$data,
        test_type = input_panel_values$test_type,
        alpha = input_panel_values$alpha,
        run_trigger = input_panel_values$run_test_trigger
    )
}

# Run the application
shinyApp(ui = ui, server = server)
