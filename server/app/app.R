# Modular Shiny App for Non-Parametric Statistical Tests
# Main app entry point

# Load required libraries
library(shiny)
library(shinyjs)

# Optional packages for file formats - will be installed on demand if needed
required_packages <- c("readxl", "writexl", "haven")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message("Package '", pkg, "' is not installed but will be installed on demand if needed.")
  }
}

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
    titlePanel(tags$h1("Uji Nonparametrik Dua Sampel", style = "font-weight: bold;")),

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
