# Defines functions used for analysis

puts <- function(string1, string2) {
  ## Shorthand function for quickly printing a concatenated string
  print(paste(string1, string2, sep=''))
}

svd_reduce <- function(X, n_dimensions) {
  ## Reduce a matrix-like object to n dimensions using
  ## truncated SVD composition

  #Calculates the SVD
  sing <- svd(scale(X)) 
  # Approximate each result of SVD with the given the number of dimensions
  u1 <- as.matrix(sing$u[, 1:n_dimensions])
  d1 <- as.matrix(diag(sing$d)[1:n_dimensions, 1:n_dimensions])
  vt1 <- as.matrix(t(sing$v)[1:n_dimensions, 1:n_dimensions])

  #Create the new approximated matrix
  return(u1%*%d1%*%vt1)
}

reduce_dataset <- function(df, n_dimensions) {
  # Create a reduced version of a dataset
  # Assumes targets are in the last column of df
  reduced_data <- as.data.frame(
                          svd_reduce(df[,-ncol(df)], n_dimensions)
                  )
  # Add activity column (labels)
  reduced_data <- cbind(reduced_data, activity=df[,ncol(df)])
  return(reduced_data)
}

cv_accuracy <- function(fit, test_data, test_labels){
  # Calculates the CV accuracy of a model given the test data and the labels
  predictions <- predict(fit, test_data)
  return(mean(predictions == test_labels))
}

svm_tuned <- function(train_data, test_data, test_labels, kernel='radial', range=2^(0:4)) {
  require(e1071)
  # Returns a radial svm fit with the cost parameter tuned
  best_svm <- svm(as.factor(activity) ~ .,
                    data=train_data,
                    method='C-classification',
                    kernel=kernel,
                    cost=range[1])
  best_accuracy <- cv_accuracy(best_svm, test_data, test_labels)
  puts('Accuracy: ', best_accuracy)
  for (c in range[2:length(range)]){
    svm_fit <- svm(as.factor(activity) ~ .,
                    data=train_data,
                    method='C-classification',
                    kernel=kernel,
                    cost=c)
    accuracy <- cv_accuracy(svm_fit, test_data, test_labels)
    if (accuracy > best_accuracy) {
      best_svm <- svm_fit
      best_accuracy <- accuracy
    }
  }
  return(best_svm)
}