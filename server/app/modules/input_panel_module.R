# Input Panel Module
# Shiny module untuk panel input data

# Module UI function
input_panel_ui <- function(id) {
    ns <- NS(id)

    wellPanel(
        h4("Input Data"),

        # Test selection
        create_test_selection(ns("test_type"), "sign"),
        hr(),

        # File upload section
        create_file_upload_section(
            ns("file_csv"),
            ns("clear_file"),
            ns("download_template"),
            ns("file_status")
        ),

        # Manual input section
        create_manual_input_section(
            ns("use_manual"),
            ns("sample1"),
            ns("sample2"),
            ns("load_template"),
            ns("test_type")
        ),

        # Alpha input
        numericInput(ns("alpha"), "Tingkat Signifikansi (α):",
            value = 0.05, min = 0.01, max = 0.1, step = 0.01
        ),
        br(),

        # Run test button
        actionButton(ns("run_test"), "🚀 Jalankan Uji",
            class = "btn btn-primary btn-block btn-lg"
        ),
        br(), br(),

        # Data info display
        conditionalPanel(
            condition = paste0("output['", ns("data_info"), "'] != ''"),
            div(
                h6("📊 Data yang akan diproses:"),
                verbatimTextOutput(ns("data_info")),
                style = get_info_box_style("data-info-box")
            )
        )
    )
}

# Module server function
input_panel_server <- function(id, parent_session) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns

        # Reactive values for module state
        values <- reactiveValues(
            current_data = NULL,
            file_cleared = FALSE,
            force_manual = FALSE
        )

        # File status output
        output$file_status <- renderText({
            if (!is.null(input$file_csv) && !values$file_cleared && !values$force_manual) {
                input$file_csv$name
            } else {
                ""
            }
        })

        # Clear file functionality
        observeEvent(input$clear_file, {
            reset("file_csv")
            values$file_cleared <- TRUE
            values$force_manual <- FALSE
            show_file_cleared_notification()
        })

        # Use manual mode
        observeEvent(input$use_manual, {
            reset("file_csv")
            values$file_cleared <- TRUE
            values$force_manual <- TRUE
            show_manual_mode_notification()
        })

        # Load template data
        observeEvent(input$load_template, {
            if (input$test_type == "mannwhitney") {
                # Template untuk Mann Whitney U (dua kelompok independen)
                updateTextInput(session, "sample1", value = "78,82,85,79,88,76,84,87,81,89")
                updateTextInput(session, "sample2", value = "72,75,80,74,83,70,77,82,76,85")
            } else {
                # Template untuk uji berpasangan (Sign, Wilcoxon, Run)
                updateTextInput(session, "sample1", value = "78,82,85,79,88,76,84,87,81,89")
                updateTextInput(session, "sample2", value = "75,79,82,76,85,73,81,84,78,86")
            }
            values$force_manual <- TRUE
        })

        # Download template handler
        output$download_template <- downloadHandler(
            filename = function() {
                paste0("template-uji-nonparametrik-", Sys.Date(), ".csv")
            },
            content = function(file) {
                template_lines <- generate_csv_template()
                writeLines(template_lines, file)
            }
        )

        # Get data reactive
        get_data <- reactive({
            # Check if using CSV or manual input
            use_csv <- !is.null(input$file_csv) &&
                !is.null(input$file_csv$datapath) &&
                !values$file_cleared &&
                !values$force_manual

            # Priority 1: CSV file
            if (use_csv) {
                tryCatch(
                    {
                        csv_result <- read_csv_robust(input$file_csv$datapath)
                        show_csv_success_notification(csv_result$n)
                        return(list(
                            sample1 = csv_result$sample1,
                            sample2 = csv_result$sample2,
                            source = "CSV"
                        ))
                    },
                    error = function(e) {
                        show_error_notification(paste("Error CSV:", e$message))
                        return(NULL)
                    }
                )
            }

            # Priority 2: Manual input
            sample1_text <- input$sample1
            sample2_text <- input$sample2

            if (!is.null(sample1_text) && !is.null(sample2_text) &&
                nchar(trimws(sample1_text)) > 0 && nchar(trimws(sample2_text)) > 0) {
                tryCatch(
                    {
                        result <- parse_manual_samples(sample1_text, sample2_text)
                        return(result)
                    },
                    error = function(e) {
                        show_error_notification(paste("Error input manual:", e$message))
                        return(NULL)
                    }
                )
            }

            return(NULL)
        })

        # Update current data
        observe({
            data <- get_data()
            values$current_data <- data
        })

        # Reset file_cleared when new file uploaded
        observe({
            if (!is.null(input$file_csv)) {
                values$file_cleared <- FALSE
                values$force_manual <- FALSE
            }
        })

        # Data info output
        output$data_info <- renderText({
            if (!is.null(values$current_data)) {
                source_icon <- ifelse(values$current_data$source == "CSV", "📁", "✏️")
                paste(
                    source_icon, "Sumber:", values$current_data$source, "\n",
                    "📊 Jumlah data:", length(values$current_data$sample1), "pasang\n",
                    "🔢 Sampel 1:", paste(head(values$current_data$sample1, 5), collapse = ", "),
                    ifelse(length(values$current_data$sample1) > 5, "...", ""), "\n",
                    "🔢 Sampel 2:", paste(head(values$current_data$sample2, 5), collapse = ", "),
                    ifelse(length(values$current_data$sample2) > 5, "...", "")
                )
            } else {
                ""
            }
        })

        # Return reactive values and inputs for parent
        return(list(
            data = get_data,
            test_type = reactive(input$test_type),
            alpha = reactive(input$alpha),
            run_test_trigger = reactive(input$run_test)
        ))
    })
}
