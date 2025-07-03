# Modular Shiny App for Non-Parametric Statistical Tests - Debug Version
# Main app entry point with enhanced error handling and logging

# Error handling wrapper function
debug_source <- function(file_path) {
  cat("Attempting to source:", file_path, "\n")
  
  if (!file.exists(file_path)) {
    cat("ERROR: File not found:", file_path, "\n")
    return(FALSE)
  }
  
  tryCatch({
    source(file_path)
    cat("Successfully sourced:", file_path, "\n")
    return(TRUE)
  }, error = function(e) {
    cat("ERROR sourcing", file_path, ":", conditionMessage(e), "\n")
    return(FALSE)
  })
}

# Check for required packages
check_packages <- function(package_list) {
  for (pkg in package_list) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Missing required package:", pkg, "\n")
      cat("Attempting to install...\n")
      install.packages(pkg)
      
      if (!requireNamespace(pkg, quietly = TRUE)) {
        cat("Failed to install package:", pkg, "\n")
        return(FALSE)
      }
    }
    cat("Package loaded:", pkg, "\n")
  }
  return(TRUE)
}

# Start debugging process
cat("Starting app.debug.R\n")
cat("Working directory:", getwd(), "\n")
cat("Files in current directory:\n")
print(list.files())

# Check required packages
required_packages <- c("shiny", "shinyjs")
if (!check_packages(required_packages)) {
  stop("Missing required packages. Cannot continue.")
}

# Load required libraries
cat("Loading required libraries\n")
library(shiny)
library(shinyjs)

# Source utility functions
cat("Sourcing utility files\n")
utils_dir <- "utils"
modules_dir <- "modules"

utils_files <- list.files(utils_dir, pattern = "\\.R$", full.names = TRUE)
modules_files <- list.files(modules_dir, pattern = "\\.R$", full.names = TRUE)

cat("Utility files found:", paste(utils_files, collapse = ", "), "\n")
cat("Module files found:", paste(modules_files, collapse = ", "), "\n")

for (file in utils_files) {
  if (!debug_source(file)) {
    stop("Failed to source utility file:", file)
  }
}

# Source Shiny modules
cat("Sourcing module files\n")
for (file in modules_files) {
  if (!debug_source(file)) {
    stop("Failed to source module file:", file)
  }
}

# Define UI
cat("Defining UI\n")
ui <- tryCatch({
  fluidPage(
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
}, error = function(e) {
  cat("ERROR defining UI:", conditionMessage(e), "\n")
  stop(e)
})

# Define server logic
cat("Defining server logic\n")
server <- tryCatch({
  function(input, output, session) {
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
}, error = function(e) {
  cat("ERROR defining server:", conditionMessage(e), "\n")
  stop(e)
})

# Run the application
cat("Starting Shiny application\n")
tryCatch({
  shinyApp(ui = ui, server = server)
}, error = function(e) {
  cat("ERROR launching application:", conditionMessage(e), "\n")
  stop(e)
})
