# UI Helper Functions
# Functions untuk membuat komponen UI yang dapat digunakan kembali

#' Create info box with icon and content
#' @param icon Icon character (emoji)
#' @param title Title text
#' @param content Content text (HTML allowed)
#' @param style_class CSS style class
#' @return Div element
create_info_box <- function(icon, title, content, style_class = "info-box") {
    div(
        style = get_info_box_style(style_class),
        HTML(paste0("<strong>", icon, " ", title, ":</strong><br/>", content))
    )
}

#' Get info box CSS style
#' @param style_class Style class name
#' @return CSS style string
get_info_box_style <- function(style_class) {
    switch(style_class,
        "info-box" = "background-color: #d4edda; padding: 8px; border: 1px solid #c3e6cb; border-radius: 4px;",
        "warning-box" = "background-color: #fff3cd; padding: 8px; border-radius: 4px; border-left: 4px solid #ffc107; margin: 5px 0;",
        "note-box" = "background-color: #d1ecf1; padding: 8px; border-radius: 4px; border-left: 4px solid #17a2b8; margin: 5px 0;",
        "data-info-box" = "background-color: #f8f9fa; padding: 10px; border-radius: 5px; font-size: 12px; border-left: 4px solid #007bff;"
    )
}

#' Create test selection radio buttons
#' @param input_id Input ID
#' @param selected Default selection
#' @return Radio button group
create_test_selection <- function(input_id, selected = "sign") {
    radioButtons(input_id, "Pilih Jenis Uji:",
        choices = list(
            "Uji Sign" = "sign",
            "Uji Wilcoxon" = "wilcoxon",
            "Uji Run" = "run",
            "Uji Mann Whitney U" = "mannwhitney"
        ),
        selected = selected
    )
}

#' Create file upload section
#' @param file_input_id File input ID
#' @param clear_button_id Clear button ID
#' @param download_button_id Download button ID
#' @param file_status_output_id File status output ID (namespaced)
#' @return Div containing file upload UI
create_file_upload_section <- function(file_input_id, clear_button_id, download_button_id, file_status_output_id) {
    div(
        h5("📁 Upload File CSV:"),
        fileInput(file_input_id, NULL, accept = ".csv"),

        # Buttons for file management
        fluidRow(
            column(
                6,
                downloadButton(download_button_id, "Download Template",
                    class = "btn btn-success btn-sm"
                )
            ),
            column(
                6,
                actionButton(clear_button_id, "🗑️ Clear File",
                    class = "btn btn-warning btn-sm"
                )
            )
        ),

        # File status
        conditionalPanel(
            condition = paste0("output['", file_status_output_id, "'] != ''"),
            create_info_box("📄", "File aktif", textOutput(file_status_output_id, inline = TRUE))
        ),
        helpText("Format: 2 kolom data numerik, minimal 5 baris"),
        br()
    )
}

#' Create manual input section
#' @param use_manual_id Use manual button ID
#' @param sample1_id Sample 1 input ID
#' @param sample2_id Sample 2 input ID
#' @param load_template_id Load template button ID
#' @param test_type_input_id Test type input ID (namespaced)
#' @return Div containing manual input UI
create_manual_input_section <- function(use_manual_id, sample1_id, sample2_id, load_template_id, test_type_input_id) {
    div(
        h5("✏️ Atau Input Manual:"),

        # Manual mode button
        actionButton(use_manual_id, "🔄 Gunakan Input Manual",
            class = "btn btn-info btn-sm",
            style = "margin-bottom: 10px;"
        ),

        # Sample input fields
        textInput(sample1_id, "Sampel 1 (pisahkan dengan koma):",
            value = "", placeholder = "78,82,85,79,88"
        ),
        textInput(sample2_id, "Sampel 2 (pisahkan dengan koma):",
            value = "", placeholder = "75,79,82,76,85"
        ),

        # Conditional notes for different test types
        conditionalPanel(
            condition = paste0("input['", test_type_input_id, "'] == 'mannwhitney'"),
            create_info_box(
                "📝", "Catatan Mann Whitney U",
                "Sampel 1 dan Sampel 2 adalah dua kelompok <em>independen</em> (bukan berpasangan).<br/>
        Uji ini membandingkan distribusi/median kedua kelompok.",
                "warning-box"
            )
        ),
        conditionalPanel(
            condition = paste0("input['", test_type_input_id, "'] == 'run'"),
            create_info_box(
                "📝", "Catatan Run Test",
                "Uji Run menguji randomness urutan perbedaan (Sampel1 - Sampel2).<br/>
        H0: Urutan perbedaan bersifat random.",
                "note-box"
            )
        ),
        actionButton(load_template_id, "📋 Gunakan Template",
            class = "btn btn-secondary btn-sm"
        ),
        br(), br()
    )
}

#' Create placeholder content for results area
#' @return Div containing placeholder content
create_results_placeholder <- function() {
    div(
        style = "text-align: center; margin-top: 100px;",
        h4("⏳ Siap untuk Analisis", style = "color: #666;"),
        p("Upload file CSV atau masukkan data manual, lalu klik 'Jalankan Uji'.", style = "color: #999;"),
        div(
            style = "margin-top: 30px;",
            span("💡 Tips: ", style = "font-weight: bold; color: #007bff;"),
            "Gunakan tombol 'Clear File' untuk beralih dari CSV ke input manual"
        )
    )
}
