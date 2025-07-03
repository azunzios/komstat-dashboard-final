# Debug runner for Shiny application with detailed error reporting
cat("====== DEBUG RUNNER START ======\n")
cat("Current working directory:", getwd(), "\n")
cat("R version:", R.version.string, "\n")
cat("Time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")

# Check if required libraries are available
required_packages <- c("shiny", "shinyjs")

# Function to check and install missing packages
check_and_install <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Package", pkg, "is not installed. Attempting to install...\n")
      install.packages(pkg)
      
      if (!requireNamespace(pkg, quietly = TRUE)) {
        cat("ERROR: Failed to install package:", pkg, "\n")
        return(FALSE)
      }
    }
    cat("Package", pkg, "is available.\n")
  }
  return(TRUE)
}

# Check packages
if (!check_and_install(required_packages)) {
  cat("Critical packages missing. Cannot continue.\n")
  quit(status = 1)
}

# Load shiny
library(shiny)

# Check if app directory exists
if (!dir.exists("app")) {
  cat("ERROR: App directory not found at:", file.path(getwd(), "app"), "\n")
  cat("Available directories in current location:\n")
  print(list.dirs(recursive = FALSE))
  quit(status = 1)
}

# Check for debug app file
debug_app_path <- file.path("app", "app.debug.R")
if (!file.exists(debug_app_path)) {
  cat("ERROR: Debug app file not found at:", debug_app_path, "\n")
  cat("Files in app directory:\n")
  print(list.files("app"))
  quit(status = 1)
}

# Try to run the app with extensive error trapping
tryCatch({
  cat("Running debug version of the app...\n")
  
  # Capture console output to a file
  log_file <- "shiny_debug_log.txt"
  cat("Logging output to:", log_file, "\n")
  
  # Create a sink to capture console output
  sink(log_file, append = FALSE, split = TRUE)
  
  # Run the app with the debug script
  shiny::runApp(
    appDir = "app",
    port = 3838,
    host = "127.0.0.1",
    launch.browser = TRUE,
    display.mode = "normal"
  )
  
  # Close the sink
  sink()
  
}, error = function(e) {
  cat("CRITICAL ERROR running the app:\n")
  cat(conditionMessage(e), "\n")
  cat("Call stack:\n")
  print(sys.calls())
  cat("Session info:\n")
  print(sessionInfo())
  
  # Create error log file
  error_log <- "shiny_error_log.txt"
  cat("Writing detailed error log to:", error_log, "\n")
  
  # Write error details to file
  con <- file(error_log, "w")
  writeLines(c(
    "ERROR LOG",
    paste("Time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
    paste("Error:", conditionMessage(e)),
    "\nCall stack:",
    capture.output(print(sys.calls())),
    "\nSession info:",
    capture.output(print(sessionInfo()))
  ), con)
  close(con)
  
  cat("Error log written to:", error_log, "\n")
}, finally = {
  cat("====== DEBUG RUNNER END ======\n")
})
