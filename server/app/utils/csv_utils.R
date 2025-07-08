# Data Import Utilities
# Functions untuk membaca dan memproses file data (CSV, Excel, SPSS)

#' Check if required packages are installed and load them
#' @param packages Character vector of package names
#' @return TRUE if all packages are loaded successfully, FALSE otherwise
check_and_load_packages <- function(packages) {
  not_installed <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]
  
  if (length(not_installed) > 0) {
    message("Installing missing packages: ", paste(not_installed, collapse = ", "))
    for (pkg in not_installed) {
      install.packages(pkg, quiet = TRUE)
    }
  }
  
  for (pkg in packages) {
    library(pkg, character.only = TRUE, quietly = TRUE)
  }
  
  return(TRUE)
}

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
                has_header = has_header,
                source = "CSV"
            ))
        },
        error = function(e) {
            stop(e$message)
        }
    )
}

#' Read Excel file with robust error handling
#' @param file_path Path to Excel file
#' @return List containing sample1, sample2, n
read_excel_robust <- function(file_path) {
    # Ensure readxl package is loaded
    if (!check_and_load_packages("readxl")) {
        stop("Gagal memuat package readxl yang diperlukan")
    }
    
    tryCatch(
        {
            # Read the Excel file
            data <- readxl::read_excel(file_path)
            
            # Convert to data frame if it's not already
            data <- as.data.frame(data)
            
            if (nrow(data) < 5) {
                stop("Minimal 5 baris data diperlukan")
            }
            
            # Find first two numeric columns
            numeric_cols <- c()
            for (col_name in names(data)) {
                if (is.numeric(data[[col_name]])) {
                    numeric_cols <- c(numeric_cols, col_name)
                    if (length(numeric_cols) == 2) break
                }
            }
            
            if (length(numeric_cols) < 2) {
                stop("File Excel harus memiliki minimal 2 kolom numerik")
            }
            
            # Extract data from the first two numeric columns
            sample1 <- data[[numeric_cols[1]]]
            sample2 <- data[[numeric_cols[2]]]
            
            # Remove any NA values, keeping paired observations
            valid_rows <- !is.na(sample1) & !is.na(sample2)
            sample1 <- sample1[valid_rows]
            sample2 <- sample2[valid_rows]
            
            if (length(sample1) < 5 || length(sample2) < 5) {
                stop("Minimal 5 pasang data numerik valid diperlukan")
            }
            
            return(list(
                sample1 = sample1,
                sample2 = sample2,
                n = length(sample1),
                source = "Excel"
            ))
        },
        error = function(e) {
            stop(paste("Error membaca file Excel:", e$message))
        }
    )
}

#' Read SPSS file with robust error handling
#' @param file_path Path to SPSS file
#' @return List containing sample1, sample2, n
read_spss_robust <- function(file_path) {
    # Ensure haven package is loaded
    if (!check_and_load_packages("haven")) {
        stop("Gagal memuat package haven yang diperlukan")
    }
    
    tryCatch(
        {
            # Read the SPSS file
            data <- haven::read_sav(file_path)
            
            # Convert to data frame
            data <- as.data.frame(data)
            
            if (nrow(data) < 5) {
                stop("Minimal 5 baris data diperlukan")
            }
            
            # Find first two numeric columns
            numeric_cols <- c()
            for (col_name in names(data)) {
                if (is.numeric(data[[col_name]])) {
                    numeric_cols <- c(numeric_cols, col_name)
                    if (length(numeric_cols) == 2) break
                }
            }
            
            if (length(numeric_cols) < 2) {
                stop("File SPSS harus memiliki minimal 2 kolom numerik")
            }
            
            # Extract data from the first two numeric columns
            sample1 <- data[[numeric_cols[1]]]
            sample2 <- data[[numeric_cols[2]]]
            
            # Remove any NA values, keeping paired observations
            valid_rows <- !is.na(sample1) & !is.na(sample2)
            sample1 <- sample1[valid_rows]
            sample2 <- sample2[valid_rows]
            
            if (length(sample1) < 5 || length(sample2) < 5) {
                stop("Minimal 5 pasang data numerik valid diperlukan")
            }
            
            return(list(
                sample1 = sample1,
                sample2 = sample2,
                n = length(sample1),
                source = "SPSS"
            ))
        },
        error = function(e) {
            stop(paste("Error membaca file SPSS:", e$message))
        }
    )
}

#' Read data file based on file extension
#' @param file_path Path to data file
#' @return List containing sample1, sample2, n and other info
read_data_file <- function(file_path) {
    # Get file extension (lowercase)
    file_ext <- tolower(tools::file_ext(file_path))
    
    # Call appropriate reader based on file extension
    if (file_ext == "csv") {
        return(read_csv_robust(file_path))
    } else if (file_ext %in% c("xls", "xlsx")) {
        return(read_excel_robust(file_path))
    } else if (file_ext == "sav") {
        return(read_spss_robust(file_path))
    } else {
        stop(paste("Format file tidak didukung:", file_ext))
    }
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

#' Generate template content for different file formats
#' @param format File format ("csv", "excel", "spss")
#' @return Character vector of template lines (for CSV) or path to temporary file (for Excel/SPSS)
generate_template <- function(format = "csv") {
    if (format == "csv") {
        return(c(
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
        ))
    } else if (format == "excel") {
        # Ensure readxl package is loaded
        if (!check_and_load_packages(c("readxl", "writexl"))) {
            stop("Gagal memuat packages readxl dan writexl yang diperlukan")
        }
        
        # Create a data frame with the template data
        template_df <- data.frame(
            Sebelum = c(78, 82, 85, 79, 88, 76, 84, 87, 81, 89),
            Sesudah = c(75, 79, 82, 76, 85, 73, 81, 84, 78, 86)
        )
        
        # Create a temporary file
        temp_file <- tempfile(fileext = ".xlsx")
        
        # Write the data frame to the temporary file
        writexl::write_xlsx(template_df, temp_file)
        
        return(temp_file)
    } else if (format == "spss") {
        # Ensure haven package is loaded
        if (!check_and_load_packages("haven")) {
            stop("Gagal memuat package haven yang diperlukan")
        }
        
        # Create a data frame with the template data
        template_df <- data.frame(
            Sebelum = c(78, 82, 85, 79, 88, 76, 84, 87, 81, 89),
            Sesudah = c(75, 79, 82, 76, 85, 73, 81, 84, 78, 86)
        )
        
        # Create a temporary file
        temp_file <- tempfile(fileext = ".sav")
        
        # Write the data frame to the temporary file
        haven::write_sav(template_df, temp_file)
        
        return(temp_file)
    } else {
        stop("Format template tidak didukung")
    }
}

#' Generate CSV template content (backwards compatibility)
#' @return Character vector of CSV template lines
generate_csv_template <- function() {
    generate_template("csv")
}
