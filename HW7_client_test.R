## Write your client test code here
# HW7_client_test.R
# Client test script for Homework 7 API

library(httr)
library(jsonlite)

# lead_time_days, age, appt_hour, appt_wday, is_weekend, is_morning,
# prior_appts, prior_no_shows, specialty, address, provider_id
test_df <- read.csv("test_input_data.csv")

# Convert to JSON for POST request
json_input <- toJSON(test_df, auto_unbox = TRUE)

# -------- Test predict_prob endpoint --------
url_prob <- "http://127.0.0.1:8000/predict_prob"
res_prob <- POST(url_prob, body = json_input)

# Unserialize response
probabilities <- content(res_prob, as = "parsed")
cat("Predicted probabilities:\n")
print(probabilities)

# -------- Test predict_class endpoint --------
url_class <- "http://127.0.0.1:8000/predict_class"
res_class <- POST(url_class, body = json_input)

classes <- content(res_class, as = "parsed")
cat("Predicted classes:\n")
print(classes)
