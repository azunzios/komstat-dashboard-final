# Statistical Test Functions
# Functions untuk uji statistik non-parametrik

#' Perform Sign Test
#' @param sample1 First sample (numeric vector)
#' @param sample2 Second sample (numeric vector)
#' @param alpha Significance level (default: 0.05)
#' @return List containing test results
perform_sign_test <- function(sample1, sample2, alpha = 0.05) {
    differences <- sample1 - sample2
    differences <- differences[differences != 0]
    n <- length(differences)
    positive_signs <- sum(differences > 0)
    negative_signs <- sum(differences < 0)
    test_stat <- min(positive_signs, negative_signs)
    p_value <- 2 * pbinom(test_stat, n, 0.5)
    critical_value <- qbinom(alpha / 2, n, 0.5)
    conclusion <- ifelse(p_value < alpha, "Menolak H0", "Gagal menolak H0")
    interpretation <- ifelse(p_value < alpha,
        paste("Terdapat perbedaan signifikan antara kedua sampel pada α =", alpha),
        paste("Tidak ada perbedaan signifikan antara kedua sampel pada α =", alpha)
    )

    return(list(
        testStatistic = test_stat,
        pValue = round(p_value, 4),
        criticalValue = critical_value,
        positiveSign = positive_signs,
        negativeSign = negative_signs,
        zeroSign = length(sample1) - n,
        sampleSize = length(sample1),
        effectiveN = n,
        conclusion = conclusion,
        interpretation = interpretation,
        differences = sample1 - sample2,
        alpha = alpha,
        testType = "sign"
    ))
}

#' Perform Wilcoxon Signed-Rank Test
#' @param sample1 First sample (numeric vector)
#' @param sample2 Second sample (numeric vector)
#' @param alpha Significance level (default: 0.05)
#' @return List containing test results
perform_wilcoxon_test <- function(sample1, sample2, alpha = 0.05) {
    differences <- sample1 - sample2
    original_n <- length(differences)
    differences <- differences[differences != 0]
    n <- length(differences)
    abs_diff <- abs(differences)
    ranks <- rank(abs_diff)
    positive_ranks <- ranks[differences > 0]
    negative_ranks <- ranks[differences < 0]
    sum_positive <- sum(positive_ranks)
    sum_negative <- sum(negative_ranks)
    test_stat <- min(sum_positive, sum_negative)
    expected <- n * (n + 1) / 4
    variance <- n * (n + 1) * (2 * n + 1) / 24
    z_score <- (test_stat - expected) / sqrt(variance)
    p_value <- 2 * pnorm(abs(z_score), lower.tail = FALSE)
    effect_size <- abs(z_score) / sqrt(n)
    critical_value <- qnorm(alpha / 2) * sqrt(variance) + expected
    mean_diff <- mean(sample1 - sample2)
    median_diff <- median(sample1 - sample2)
    conclusion <- ifelse(p_value < alpha, "Menolak H0", "Gagal menolak H0")
    interpretation <- ifelse(p_value < alpha,
        paste("Terdapat perbedaan signifikan antara kedua sampel pada α =", alpha),
        paste("Tidak ada perbedaan signifikan antara kedua sampel pada α =", alpha)
    )

    return(list(
        testStatistic = test_stat,
        pValue = round(p_value, 4),
        zScore = round(z_score, 2),
        sumPositiveRanks = sum_positive,
        sumNegativeRanks = sum_negative,
        sampleSize = original_n,
        effectiveN = n,
        effectSize = round(effect_size, 3),
        criticalValue = round(critical_value, 0),
        conclusion = conclusion,
        interpretation = interpretation,
        differences = sample1 - sample2,
        meanDifference = round(mean_diff, 3),
        medianDifference = round(median_diff, 3),
        alpha = alpha,
        testType = "wilcoxon"
    ))
}

#' Perform Run Test
#' @param sample1 First sample (numeric vector)
#' @param sample2 Second sample (numeric vector)
#' @param alpha Significance level (default: 0.05)
#' @return List containing test results
perform_run_test <- function(sample1, sample2, alpha = 0.05) {
    differences <- sample1 - sample2
    n <- length(differences)

    # Convert differences to binary sequence (+ and -)
    binary_seq <- ifelse(differences > 0, "+", ifelse(differences < 0, "-", "0"))

    # Remove zeros (tied values)
    binary_seq <- binary_seq[binary_seq != "0"]
    effective_n <- length(binary_seq)

    if (effective_n < 2) {
        stop("Tidak cukup data untuk uji run (minimal 2 observasi non-zero)")
    }

    # Count runs
    runs <- 1
    for (i in 2:effective_n) {
        if (binary_seq[i] != binary_seq[i - 1]) {
            runs <- runs + 1
        }
    }

    # Count positive and negative signs
    n_pos <- sum(binary_seq == "+")
    n_neg <- sum(binary_seq == "-")

    # Handle extreme cases (all same sign)
    if (n_pos == 0 || n_neg == 0) {
        # When all differences have the same sign, pattern is clearly non-random
        z_score <- Inf # Infinite z-score indicates extreme non-randomness
        p_value <- 0.0001 # Very small p-value (practically 0)
        effect_size <- 1.0 # Maximum effect size
        expected_runs <- 1 # Only one run is expected when all signs are same
        variance_runs <- 0 # No variance when all signs are same

        conclusion <- "Menolak H0"
        interpretation <- paste("Semua perbedaan memiliki tanda yang sama - pola sangat non-random pada α =", alpha)
    } else {
        # Normal calculation when both positive and negative signs exist
        expected_runs <- (2 * n_pos * n_neg) / effective_n + 1
        variance_runs <- (2 * n_pos * n_neg * (2 * n_pos * n_neg - effective_n)) /
            (effective_n^2 * (effective_n - 1))

        # Calculate z-score
        z_score <- (runs - expected_runs) / sqrt(variance_runs)

        # Calculate p-value (two-tailed)
        p_value <- 2 * pnorm(abs(z_score), lower.tail = FALSE)

        # Effect size (similar to correlation)
        effect_size <- abs(z_score) / sqrt(effective_n)

        conclusion <- ifelse(p_value < alpha, "Menolak H0", "Gagal menolak H0")
        interpretation <- ifelse(p_value < alpha,
            paste("Urutan data menunjukkan pola non-random pada α =", alpha),
            paste("Urutan data konsisten dengan pola random pada α =", alpha)
        )
    }

    return(list(
        testStatistic = runs,
        expectedRuns = round(expected_runs, 2),
        variance = round(variance_runs, 3),
        zScore = round(z_score, 2),
        pValue = round(p_value, 4),
        positiveCount = n_pos,
        negativeCount = n_neg,
        sampleSize = n,
        effectiveN = effective_n,
        effectSize = round(effect_size, 3),
        conclusion = conclusion,
        interpretation = interpretation,
        differences = differences,
        binarySequence = binary_seq,
        alpha = alpha,
        testType = "run"
    ))
}

#' Perform Mann-Whitney U Test
#' @param sample1 First sample (numeric vector)
#' @param sample2 Second sample (numeric vector)
#' @param alpha Significance level (default: 0.05)
#' @return List containing test results
perform_mannwhitney_test <- function(sample1, sample2, alpha = 0.05) {
    n1 <- length(sample1)
    n2 <- length(sample2)

    # Perform Wilcoxon rank-sum test (equivalent to Mann-Whitney U)
    wilcox_result <- wilcox.test(sample1, sample2, exact = FALSE)

    # Calculate U statistics manually for detailed output
    combined <- c(sample1, sample2)
    ranks <- rank(combined)

    R1 <- sum(ranks[1:n1]) # Sum of ranks for sample1
    R2 <- sum(ranks[(n1 + 1):(n1 + n2)]) # Sum of ranks for sample2

    # Calculate U statistics
    U1 <- R1 - n1 * (n1 + 1) / 2
    U2 <- R2 - n2 * (n2 + 1) / 2

    # Test statistic is the smaller U
    U <- min(U1, U2)

    # For large samples (n1, n2 > 20), use normal approximation
    mean_U <- n1 * n2 / 2
    var_U <- n1 * n2 * (n1 + n2 + 1) / 12
    z_score <- (U - mean_U) / sqrt(var_U)

    # Effect size (r = Z / sqrt(N))
    effect_size <- abs(z_score) / sqrt(n1 + n2)

    # Medians for comparison
    median1 <- median(sample1)
    median2 <- median(sample2)

    conclusion <- ifelse(wilcox_result$p.value < alpha, "Menolak H0", "Gagal menolak H0")
    interpretation <- ifelse(wilcox_result$p.value < alpha,
        paste("Terdapat perbedaan signifikan antara kedua kelompok independen pada α =", alpha),
        paste("Tidak ada perbedaan signifikan antara kedua kelompok independen pada α =", alpha)
    )

    return(list(
        testStatistic = U,
        U1 = U1,
        U2 = U2,
        rankSum1 = R1,
        rankSum2 = R2,
        zScore = round(z_score, 2),
        pValue = round(wilcox_result$p.value, 4),
        median1 = round(median1, 2),
        median2 = round(median2, 2),
        sampleSize1 = n1,
        sampleSize2 = n2,
        effectSize = round(effect_size, 3),
        conclusion = conclusion,
        interpretation = interpretation,
        sample1 = sample1,
        sample2 = sample2,
        alpha = alpha,
        testType = "mannwhitney"
    ))
}
