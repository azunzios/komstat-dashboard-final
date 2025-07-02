# Plot Utilities
# Functions untuk membuat plot dan visualisasi

#' Create main plot based on test type
#' @param results Test results list
#' @return Plot object
create_main_plot <- function(results) {
    if (results$testType == "sign") {
        plot_sign_test(results)
    } else if (results$testType == "wilcoxon") {
        plot_wilcoxon_test(results)
    } else if (results$testType == "run") {
        plot_run_test(results)
    } else if (results$testType == "mannwhitney") {
        plot_mannwhitney_test(results)
    }
}

#' Create difference plot based on test type
#' @param results Test results list
#' @return Plot object
create_difference_plot <- function(results) {
    if (results$testType == "mannwhitney") {
        plot_mannwhitney_histogram(results)
    } else {
        plot_differences(results)
    }
}

#' Plot Sign Test results
#' @param results Sign test results
plot_sign_test <- function(results) {
    barplot(c(results$positiveSign, results$negativeSign),
        names.arg = c("Positif", "Negatif"),
        col = c("lightgreen", "lightcoral"),
        main = "Distribusi Tanda - Uji Sign",
        ylab = "Jumlah"
    )
}

#' Plot Wilcoxon Test results
#' @param results Wilcoxon test results
plot_wilcoxon_test <- function(results) {
    barplot(c(results$sumPositiveRanks, results$sumNegativeRanks),
        names.arg = c("Positive Ranks", "Negative Ranks"),
        col = c("lightgreen", "lightcoral"),
        main = "Distribusi Rank - Uji Wilcoxon",
        ylab = "Sum of Ranks"
    )
}

#' Plot Run Test results
#' @param results Run test results
plot_run_test <- function(results) {
    # Plot sequence of signs
    binary_seq <- results$binarySequence
    y_vals <- ifelse(binary_seq == "+", 1, -1)
    plot(seq_along(y_vals), y_vals,
        type = "b", pch = 16,
        main = paste("Sequence Plot - Uji Run (", results$testStatistic, "runs )"),
        ylab = "Tanda (+1 / -1)",
        xlab = "Urutan Data",
        col = ifelse(y_vals == 1, "green", "red"),
        ylim = c(-1.5, 1.5)
    )
    abline(h = 0, col = "gray", lty = 2)
    grid()
}

#' Plot Mann-Whitney U Test results
#' @param results Mann-Whitney test results
plot_mannwhitney_test <- function(results) {
    # Boxplot comparison
    data_combined <- data.frame(
        values = c(results$sample1, results$sample2),
        group = factor(c(
            rep("Sampel 1", length(results$sample1)),
            rep("Sampel 2", length(results$sample2))
        ))
    )
    boxplot(values ~ group,
        data = data_combined,
        col = c("lightblue", "lightgreen"),
        main = "Perbandingan Distribusi - Mann Whitney U",
        ylab = "Nilai",
        xlab = "Kelompok"
    )
}

#' Plot histogram comparison for Mann-Whitney U
#' @param results Mann-Whitney test results
plot_mannwhitney_histogram <- function(results) {
    # Histogram comparison for Mann Whitney U
    par(mfrow = c(1, 2))
    hist(results$sample1,
        main = paste("Sampel 1 (n=", results$sampleSize1, ")"),
        xlab = "Nilai", col = "lightblue"
    )
    hist(results$sample2,
        main = paste("Sampel 2 (n=", results$sampleSize2, ")"),
        xlab = "Nilai", col = "lightgreen"
    )
    par(mfrow = c(1, 1))
}

#' Plot differences for paired tests
#' @param results Test results
plot_differences <- function(results) {
    # Difference plot for paired tests (sign, wilcoxon, run)
    dif <- results$differences
    plot(seq_along(dif), dif,
        type = "b",
        main = "Plot Perbedaan Data",
        ylab = "Selisih (Sampel1 - Sampel2)",
        xlab = "Index Data",
        col = ifelse(dif > 0, "green", ifelse(dif < 0, "red", "gray")),
        pch = 16
    )
    abline(h = 0, col = "gray", lty = 2)
    grid()
}

#' Render test summary results
#' @param results Test results list
render_test_summary <- function(results) {
    cat("=== HASIL UJI", toupper(results$testType), "===\n\n")

    if (results$testType == "sign") {
        cat("Ukuran sampel:", results$sampleSize, "\n")
        cat("Statistik uji:", results$testStatistic, "\n")
        cat("P-value:", results$pValue, "\n")
        cat("Tanda positif:", results$positiveSign, "\n")
        cat("Tanda negatif:", results$negativeSign, "\n")
        cat("Alpha:", results$alpha, "\n")
    } else if (results$testType == "wilcoxon") {
        cat("Ukuran sampel:", results$sampleSize, "\n")
        cat("Statistik uji:", results$testStatistic, "\n")
        cat("P-value:", results$pValue, "\n")
        cat("Z-score:", results$zScore, "\n")
        cat("Effect size:", results$effectSize, "\n")
        cat("Alpha:", results$alpha, "\n")
    } else if (results$testType == "run") {
        cat("Ukuran sampel:", results$sampleSize, "\n")
        cat("Ukuran efektif (non-zero):", results$effectiveN, "\n")
        cat("Jumlah runs:", results$testStatistic, "\n")
        cat("Expected runs:", results$expectedRuns, "\n")
        if (is.finite(results$zScore)) {
            cat("Z-score:", results$zScore, "\n")
        } else {
            cat("Z-score: Extreme case (all signs same)\n")
        }
        cat("P-value:", results$pValue, "\n")
        cat("Tanda positif:", results$positiveCount, "\n")
        cat("Tanda negatif:", results$negativeCount, "\n")
        if (is.finite(results$effectSize)) {
            cat("Effect size:", results$effectSize, "\n")
        } else {
            cat("Effect size: Maximum (1.0)\n")
        }
        cat("Alpha:", results$alpha, "\n")
    } else if (results$testType == "mannwhitney") {
        cat("Ukuran sampel 1:", results$sampleSize1, "\n")
        cat("Ukuran sampel 2:", results$sampleSize2, "\n")
        cat("Statistik U:", results$testStatistic, "\n")
        cat("U1 (sampel 1):", results$U1, "\n")
        cat("U2 (sampel 2):", results$U2, "\n")
        cat("Z-score:", results$zScore, "\n")
        cat("P-value:", results$pValue, "\n")
        cat("Median sampel 1:", results$median1, "\n")
        cat("Median sampel 2:", results$median2, "\n")
        cat("Effect size:", results$effectSize, "\n")
        cat("Alpha:", results$alpha, "\n")
    }

    cat("\nKesimpulan:", results$conclusion, "\n")
    cat("Interpretasi:", results$interpretation, "\n")
}
