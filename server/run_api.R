library(plumber)
cat("Starting Plumber API on http://0.0.0.0:8080\n")
pr <- plumb("api.R")

# Enable CORS for all routes
pr$filter("cors", function(req, res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    res$setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
    res$setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")

    if (req$REQUEST_METHOD == "OPTIONS") {
        res$status <- 200
        return(list())
    }

    plumber::forward()
})

pr$run(port = 8080, host = "0.0.0.0")