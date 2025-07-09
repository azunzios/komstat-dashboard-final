# Modular Shiny App for Non-Parametric Statistical Tests
# Main app entry point

# Load required libraries
library(shiny)
library(shinyjs)
library(bslib)

# Optional packages for file formats - will be installed on demand if needed
required_packages <- c("readxl", "writexl", "haven")
for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        message("Package '", pkg, "' is not installed.")
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
    # Enable bslib Material UI theme with enhanced Material Design tokens
    theme = bs_theme(
        version = 5,
        base_font = font_google("Roboto", local = FALSE),
        heading_font = font_google("Roboto", wght = c(300, 400, 500), local = FALSE),
        code_font = font_google("Roboto Mono", local = FALSE),
        # Material Design color system
        bg = "#fafafa", # Material surface
        fg = "#212121", # Material on-surface
        primary = "#1976d2", # Material blue 700
        secondary = "#424242", # Material grey 800
        success = "#388e3c", # Material green 700
        info = "#0288d1", # Material light blue 700
        warning = "#f57c00", # Material orange 700
        danger = "#d32f2f", # Material red 700
        # Enhanced card styling with Material Design elevation
        card_border_width = 0,
        card_border_radius = "0.5rem", # 8dp
        card_shadow = "0 2px 1px -1px rgba(0,0,0,.2), 0 1px 1px 0 rgba(0,0,0,.14), 0 1px 3px 0 rgba(0,0,0,.12)"
    ),

    # Enable shinyjs
    useShinyjs(),

    # App title and custom CSS for depth
    tags$head(
        tags$title("Analisis Emisi Gas Rumah Kaca Global"),
        tags$style(HTML("
            /* Material Design Typography Scale */
            body {
                font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                font-weight: 400;
                line-height: 1.5;
                letter-spacing: 0.00938em;
            }

            h1, .h1 { font-size: 2.125rem; font-weight: 300; line-height: 1.235; letter-spacing: -0.00833em; }
            h2, .h2 { font-size: 1.5rem; font-weight: 400; line-height: 1.334; letter-spacing: 0em; }
            h3, .h3 { font-size: 1.25rem; font-weight: 400; line-height: 1.6; letter-spacing: 0.0075em; }
            h4, .h4 { font-size: 1.125rem; font-weight: 400; line-height: 1.5; letter-spacing: 0.00714em; }

            /* Material UI App Bar */
            .navbar, .app-bar {
                background: linear-gradient(135deg, #1976d2 0%, #1565c0 100%);
                color: white;
                padding: 16px 24px;
                margin-bottom: 24px;
                box-shadow: 0 2px 4px -1px rgba(0,0,0,.2), 0 4px 5px 0 rgba(0,0,0,.14), 0 1px 10px 0 rgba(0,0,0,.12);
                border-radius: 0;
            }

            /* Enhanced Material UI buttons */
            .btn {
                height: 36px;
                min-width: 64px;
                padding: 6px 16px;
                border-radius: 4px;
                font-size: 0.875rem;
                font-weight: 500;
                line-height: 1.75;
                letter-spacing: 0.02857em;
                text-transform: uppercase;
                border: none;
                cursor: pointer;
                outline: none;
                position: relative;
                overflow: hidden;
                transition: background-color 250ms cubic-bezier(0.4, 0, 0.2, 1) 0ms,
                           box-shadow 250ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
            }

            .btn:hover {
                box-shadow: 0 2px 4px -1px rgba(0,0,0,.2), 0 4px 5px 0 rgba(0,0,0,.14), 0 1px 10px 0 rgba(0,0,0,.12);
            }

            .btn:active {
                box-shadow: 0 5px 5px -3px rgba(0,0,0,.2), 0 8px 10px 1px rgba(0,0,0,.14), 0 3px 14px 2px rgba(0,0,0,.12);
            }

            .btn-primary {
                background-color: #1976d2;
                color: #fff;
                box-shadow: 0 3px 1px -2px rgba(0,0,0,.2), 0 2px 2px 0 rgba(0,0,0,.14), 0 1px 5px 0 rgba(0,0,0,.12);
            }

            .btn-primary:hover {
                background-color: #1565c0;
            }

            /* Material UI Form Controls */
            .form-control, .form-select {
                height: 56px;
                padding: 16px 12px 8px;
                border: 1px solid rgba(0, 0, 0, 0.23);
                border-radius: 4px;
                background: transparent;
                font-size: 1rem;
                line-height: 1.5;
                transition: border-color 200ms cubic-bezier(0.0, 0, 0.2, 1) 0ms,
                           box-shadow 200ms cubic-bezier(0.0, 0, 0.2, 1) 0ms;
            }

            .form-control:focus, .form-select:focus {
                border-color: #1976d2;
                border-width: 2px;
                box-shadow: none;
                outline: none;
            }

            .form-control:hover:not(:focus), .form-select:hover:not(:focus) {
                border-color: rgba(0, 0, 0, 0.87);
            }

            /* Form Labels */
            .control-label {
                font-size: 0.75rem;
                font-weight: 400;
                line-height: 1.66;
                letter-spacing: 0.03333em;
                color: rgba(0, 0, 0, 0.6);
                margin-bottom: 8px;
                display: block;
            }

            /* File input styling with depth and consistent sizing */
            .file-input-container .form-control-file {
                height: 56px;
                padding: 16px 12px;
                border: 1px solid rgba(0, 0, 0, 0.23);
                border-radius: 4px;
                background: transparent;
                font-size: 1rem;
                line-height: 1.5;
                transition: border-color 200ms cubic-bezier(0.0, 0, 0.2, 1) 0ms,
                           box-shadow 200ms cubic-bezier(0.0, 0, 0.2, 1) 0ms;
                display: flex;
                align-items: center;
            }

            .file-input-container .form-control-file:focus {
                border-color: #1976d2;
                border-width: 2px;
                box-shadow: none;
                outline: none;
            }

            .file-input-container .form-control-file:hover:not(:focus) {
                border-color: rgba(0, 0, 0, 0.87);
            }

            /* Ensure file input components have consistent heights */
            .file-input-container .input-group .form-control,
            .file-input-container .input-group .btn {
                height: 48px !important;
                border-radius: 4px;
                font-size: 0.875rem;
            }

            /* File input browse button styling */
            .file-input-container .btn-outline-secondary {
                background-color: #f5f5f5;
                border-color: rgba(0, 0, 0, 0.23);
                color: rgba(0, 0, 0, 0.87);
                height: 48px;
                padding: 12px 16px;
                transition: all 200ms cubic-bezier(0.0, 0, 0.2, 1) 0ms;
            }

            .file-input-container .btn-outline-secondary:hover {
                background-color: #eeeeee;
                border-color: rgba(0, 0, 0, 0.87);
                color: rgba(0, 0, 0, 0.87);
            }

            /* File input text field styling */
            .file-input-container .form-control {
                height: 48px !important;
                padding: 12px 16px;
                background-color: #fafafa;
                border-color: rgba(0, 0, 0, 0.23);
                color: rgba(0, 0, 0, 0.6);
                font-size: 0.875rem;
            }

            /* Button text truncation fix */
            .btn-sm {
                font-size: 0.8125rem !important;
                padding: 8px 12px !important;
                min-height: 36px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                line-height: 1.2;
            }

            /* Ensure download button text is fully visible */
            @media (max-width: 768px) {
                .btn-sm {
                    font-size: 0.75rem !important;
                    padding: 6px 8px !important;
                }
            }

            /* Radio button and checkbox enhancements */
            .form-check-input {
                box-shadow: 0 1px 2px rgba(0,0,0,0.1);
                border: 2px solid #dee2e6;
                transition: all 0.2s ease;
            }

            .form-check-input:checked {
                background-color: #2196F3;
                border-color: #2196F3;
                box-shadow: 0 2px 4px rgba(33, 150, 243, 0.3);
            }

            /* Enhanced card depth */
            .card {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            .card:hover {
                box-shadow: 0 4px 8px rgba(0,0,0,0.15), 0 8px 16px rgba(0,0,0,0.1) !important;
                transform: translateY(-1px);
            }

            /* Textarea depth */
            textarea.form-control {
                background: linear-gradient(to bottom, #ffffff 0%, #fafafa 100%);
                resize: vertical;
            }

            textarea.form-control:focus {
                background: #ffffff;
            }

            /* Select dropdown depth */
            select.form-select {
                background-image: linear-gradient(45deg, transparent 50%, #6c757d 50%),
                                 linear-gradient(135deg, #6c757d 50%, transparent 50%);
                background-position: calc(100% - 20px) calc(1em + 2px), calc(100% - 15px) calc(1em + 2px);
                background-size: 5px 5px, 5px 5px;
                background-repeat: no-repeat;
            }

            /* Material UI Snackbar/Notification System */
            .shiny-notification {
                background-color: #323232;
                color: #fff;
                border-radius: 4px;
                padding: 14px 16px;
                margin: 8px;
                box-shadow: 0 3px 5px -1px rgba(0,0,0,.2), 0 6px 10px 0 rgba(0,0,0,.14), 0 1px 18px 0 rgba(0,0,0,.12);
                font-size: 0.875rem;
                line-height: 1.43;
                letter-spacing: 0.01071em;
                min-width: 288px;
                max-width: 568px;
            }

            .shiny-notification-error {
                background-color: #d32f2f;
            }

            .shiny-notification-warning {
                background-color: #f57c00;
            }

            .shiny-notification-message {
                background-color: #1976d2;
            }

            /* Material UI Progress Indicators */
            .progress {
                height: 4px;
                border-radius: 2px;
                background-color: rgba(25, 118, 210, 0.12);
                overflow: hidden;
            }

            .progress-bar {
                background-color: #1976d2;
                height: 100%;
                transition: width 250ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
            }

            /* Loading Spinner */
            .loading-spinner {
                border: 3px solid rgba(25, 118, 210, 0.3);
                border-top: 3px solid #1976d2;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                animation: spin 1s linear infinite;
                display: inline-block;
                margin-right: 8px;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            /* Enhanced Accessibility */
            .sr-only {
                position: absolute;
                width: 1px;
                height: 1px;
                padding: 0;
                margin: -1px;
                overflow: hidden;
                clip: rect(0, 0, 0, 0);
                white-space: nowrap;
                border: 0;
            }

            /* Focus management */
            .btn:focus,
            .form-control:focus,
            .form-select:focus,
            .form-check-input:focus {
                outline: 2px solid #1976d2;
                outline-offset: 2px;
            }

            /* Material UI Helper Text */
            .form-text {
                font-size: 0.75rem;
                line-height: 1.66;
                letter-spacing: 0.03333em;
                color: rgba(0, 0, 0, 0.6);
                margin-top: 3px;
            }

            .form-text.text-danger {
                color: #d32f2f;
            }

            /* Material UI Dividers */
            hr {
                border: none;
                height: 1px;
                background-color: rgba(0, 0, 0, 0.12);
                margin: 24px 0;
            }

            /* Better Mobile Responsiveness */
            @media (max-width: 576px) {
                .container-fluid { padding: 8px; }
                .card-body { padding: 16px; }
                .app-bar { padding: 12px 16px; margin-bottom: 16px; }
                .app-bar h1 { font-size: 1.125rem; }
                .btn { min-width: 48px; height: 32px; padding: 4px 12px; font-size: 0.8125rem; }
                .form-control, .form-select { height: 48px; padding: 12px 8px 4px; }
            }

            /* Print Styles */
            @media print {
                .app-bar, .sidebar { display: none; }
                .main-content { width: 100%; padding: 0; }
                .card { box-shadow: none; border: 1px solid rgba(0, 0, 0, 0.12); }
            }
        "))
    ),

    # Material UI App Bar instead of titlePanel
    div(
        class = "app-bar",
        h1("Analisis Emisi Gas Rumah Kaca Global")
    ),


    # Material UI Container Layout
    div(
        class = "container-fluid",
        div(
            class = "row",
            # Input panel (sidebar)
            div(
                class = "col-md-4 sidebar",
                input_panel_ui("input_panel")
            ),

            # Results panel (main area)
            div(
                class = "col-md-8 main-content",
                results_panel_ui("results_panel")
            )
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
