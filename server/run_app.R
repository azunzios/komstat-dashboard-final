# Load required libraries
library(shiny)

# Check for and install required packages if missing
required_packages <- c("shiny", "shinyjs")
missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if (length(missing_packages) > 0) {
    cat("Installing missing packages:", paste(missing_packages, collapse = ", "), "\n")
    install.packages(missing_packages)
}

# Enhanced error handling with debug information
tryCatch({
    cat("Starting Shiny application...\n")
    
    # Check if app directory exists
    if (!dir.exists("app")) {
        stop("App directory not found. Current working directory: ", getwd())
    }
    
    # List files in app directory for debugging
    cat("Files in app directory:\n")
    print(list.files("app", recursive = TRUE))
    
    # Run the app with enhanced debugging
    shiny::runApp(
        appDir = "app",
        port = 3838,
        host = "127.0.0.1",
        launch.browser = FALSE,  # Set to TRUE for interactive debugging
        display.mode = "normal"
    )
}, error = function(e) {
    cat("ERROR: Application failed to start\n")
    cat("Error message:", conditionMessage(e), "\n")
    cat("Working directory:", getwd(), "\n")
    cat("R version:", R.version.string, "\n")
    cat("Loaded packages:\n")
    print(sessionInfo())
})