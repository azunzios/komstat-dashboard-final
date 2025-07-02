# CSV Utilities
# Functions untuk membaca dan memproses file CSV

#' Read CSV file with robust error handling
#' @param file_path Path to CSV file
#' @return List containing sample1, sample2, n, separator, has_header
read_csv_robust <- function(file_path) {
    tryCatch(
        {
            all_lines <- readLines(file_path, warn = FALSE, encoding = "UTF-8")
            all_lines <- all_lines[nzchar(all_lines)]

            if (length(all_lines) == 0) {
                stop("File CSV kosong")
            }

            first_line <- all_lines[1]
            separator <- ","
            if (length(grep(";", first_line)) > 0 && length(grep(",", first_line)) == 0) {
                separator <- ";"
            }

            valid_lines <- c()
            for (i in seq_along(all_lines)) {
                line <- trimws(all_lines[i])
                clean_line <- gsub(paste0("\\", separator), "", line)
                clean_line <- gsub("\\s", "", clean_line)

                if (nchar(clean_line) > 0) {
                    valid_lines <- c(valid_lines, line)
                }
            }

            if (length(valid_lines) < 2) {
                stop("File CSV harus memiliki minimal 2 baris data valid")
            }

            first_valid <- valid_lines[1]
            parts_first <- strsplit(first_valid, separator)[[1]]
            parts_first <- trimws(parts_first)

            has_header <- FALSE
            if (length(parts_first) >= 2) {
                test_nums <- suppressWarnings(as.numeric(parts_first[1:2]))
                if (any(is.na(test_nums))) {
                    has_header <- TRUE
                }
            }

            data_lines <- if (has_header) valid_lines[-1] else valid_lines

            if (length(data_lines) < 5) {
                stop("Minimal 5 baris data numerik diperlukan")
            }

            sample1 <- c()
            sample2 <- c()

            # Find numeric columns automatically
            numeric_cols <- c()
            first_data_line <- trimws(data_lines[1])
            parts <- strsplit(first_data_line, separator)[[1]]
            parts <- trimws(parts)
            
            # Identify which columns contain numeric data
            for (j in seq_along(parts)) {
                test_val <- suppressWarnings(as.numeric(parts[j]))
                if (!is.na(test_val)) {
                    numeric_cols <- c(numeric_cols, j)
                }
            }
            
            if (length(numeric_cols) < 2) {
                stop("CSV harus memiliki minimal 2 kolom numerik")
            }
            
            # Use first two numeric columns
            col1_idx <- numeric_cols[1]
            col2_idx <- numeric_cols[2]

            for (i in seq_along(data_lines)) {
                line <- trimws(data_lines[i])
                parts <- strsplit(line, separator)[[1]]
                parts <- trimws(parts)

                if (length(parts) >= max(col1_idx, col2_idx)) {
                    val1 <- suppressWarnings(as.numeric(parts[col1_idx]))
                    val2 <- suppressWarnings(as.numeric(parts[col2_idx]))

                    if (!is.na(val1) && !is.na(val2)) {
                        sample1 <- c(sample1, val1)
                        sample2 <- c(sample2, val2)
                    }
                }
            }

            if (length(sample1) < 5 || length(sample2) < 5) {
                stop("Minimal 5 pasang data numerik valid diperlukan")
            }

            if (length(sample1) != length(sample2)) {
                stop("Jumlah data valid di kedua kolom tidak sama")
            }

            return(list(
                sample1 = sample1,
                sample2 = sample2,
                n = length(sample1),
                separator = separator,
                has_header = has_header
            ))
        },
        error = function(e) {
            stop(e$message)
        }
    )
}

#' Parse manual input samples
#' @param sample1_text Comma-separated text for sample 1
#' @param sample2_text Comma-separated text for sample 2
#' @return List containing sample1, sample2, source
parse_manual_samples <- function(sample1_text, sample2_text) {
    tryCatch(
        {
            sample1 <- as.numeric(strsplit(trimws(sample1_text), ",")[[1]])
            sample2 <- as.numeric(strsplit(trimws(sample2_text), ",")[[1]])

            if (any(is.na(sample1)) || any(is.na(sample2))) {
                stop("Data harus berupa angka")
            }

            if (length(sample1) != length(sample2)) {
                stop("Jumlah data harus sama")
            }

            if (length(sample1) < 5) {
                stop("Minimal 5 pasang data")
            }

            return(list(
                sample1 = sample1,
                sample2 = sample2,
                source = "Manual"
            ))
        },
        error = function(e) {
            stop(e$message)
        }
    )
}

#' Generate CSV template content
#' @return Character vector of CSV template lines
generate_csv_template <- function() {
    c(
        "Sebelum,Sesudah",
        "78,75",
        "82,79",
        "85,82",
        "79,76",
        "88,85",
        "76,73",
        "84,81",
        "87,84",
        "81,78",
        "89,86"
    )
}
