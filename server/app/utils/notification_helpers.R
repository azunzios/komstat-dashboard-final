# Notification Helper Functions
# Functions untuk notifikasi yang konsisten

#' Show success notification
#' @param message Message text
show_success_notification <- function(message) {
    showNotification(paste("✅", message), type = "message")
}

#' Show error notification
#' @param message Message text
show_error_notification <- function(message) {
    showNotification(paste("❌", message), type = "error")
}

#' Show warning notification
#' @param message Message text
show_warning_notification <- function(message) {
    showNotification(paste("⚠️", message), type = "warning")
}

#' Show info notification
#' @param message Message text
show_info_notification <- function(message) {
    showNotification(paste("📁", message), type = "message")
}

#' Show CSV read success notification
#' @param n_pairs Number of data pairs
show_csv_success_notification <- function(n_pairs) {
    show_info_notification(paste("CSV berhasil dibaca:", n_pairs, "pasang data"))
}

#' Show manual mode notification
show_manual_mode_notification <- function() {
    show_info_notification("Mode input manual diaktifkan. File CSV diabaikan.")
}

#' Show file cleared notification
show_file_cleared_notification <- function() {
    show_info_notification("File CSV telah dihapus. Sekarang bisa menggunakan input manual.")
}

#' Show analysis complete notification
show_analysis_complete_notification <- function() {
    show_success_notification("Analisis berhasil!")
}

#' Show data required notification
show_data_required_notification <- function() {
    show_warning_notification("Harap masukkan data terlebih dahulu")
}
