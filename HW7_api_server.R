## Write your API endpoints in this file
# HW7_api_server.R
# Plumber API for patient no-show prediction

library(plumber)
library(jsonlite)
library(randomForest)

model <- readRDS("no_show_rf_model.rds")

#* Predict probability of no-show (returns numeric vector)
#* @post /predict_prob
function(req) {
  # Parse JSON body into data frame
  input <- jsonlite::fromJSON(req$postBody)
  
  if (!is.data.frame(input)) {
    stop("Input must be a data frame.")
  }
  
  # Predict probability of class "1" (no-show)
  prob <- predict(model, newdata = input, type = "prob")[, 2]
  
  return(prob)
}

#* Predict class (0 = show, 1 = no-show)
#* @post /predict_class
function(req) {
  input <- jsonlite::fromJSON(req$postBody)
  
  if (!is.data.frame(input)) {
    stop("Input must be a data frame.")
  }
  
  # Predict class labels (factor)
  pred_class <- predict(model, newdata = input, type = "response")
  
  # Convert factor -> numeric ("0"/"1" → 0 / 1)
  pred_class <- as.numeric(as.character(pred_class))
  
  return(pred_class)
}