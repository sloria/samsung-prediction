set.seed(1)

accuracy <- function(predicted, targets) {
  n_errors <- sum(predicted != targets)
  accuracy <- mean(predicted == targets)
  # puts('Test set accuracy: ', accuracy)
  return(accuracy)
}

train_labels <- train_data[, ncol(train_data)]
test_labels <- test_data[, ncol(train_data)]

# K nearest neighbors
#####################
require('class')
print('## KNN ##')
# training data without labels

print('Training KNN. . .')
# Vector of predictions
knn_predicted <- knn(train_data[, -ncol(train_data)],
                 test_data[, -ncol(test_data)], 
                 train_labels)

# Create a dataframe to store accuracies
accuracies <- data.frame(Classifier=c('KNN'), CV=c(accuracy(knn_predicted, test_labels)))

# SVM
#####
require('e1071')
print('## SVM ##')
# Try different kernels
print('Trying different kernels. . .')
radial_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='radial')

polynomial_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='polynomial')

linear_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='linear')

sigmoid_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='radial')

svm_models <- list(radial_svm_fit, polynomial_svm_fit, linear_svm_fit, sigmoid_svm_fit)
svm_names <- c('Radial SVM', 'Polynomial SVM', 'Linear SVM', 'Sigmoid SVM')


svm_accuracy <- function(fit, test_data, test_labels){
  # Calculates the CV accuracy of a model given the test data and the labels
  predictions <- predict(fit, test_data)
  return(accuracy(predictions, test_labels))
}

# Append the accuracies
svm_accuracies <- sapply(svm_models, svm_accuracy, test_data=test_data, test_labels=test_labels)
accuracies <- rbind(accuracies,
                    data.frame(Classifier=svm_names, CV=svm_accuracies))

# Order classifiers by accuracy
accuracies <- accuracies[order(-accuracies$CV),]
print(accuracies)


