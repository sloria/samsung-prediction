# SVM
#####
require('e1071')
print('## SVM ##')
# Try different kernels
print('Trying different kernels. . .')
print('Radial. . .')
radial_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='radial')

print('Polynomial . . .')
polynomial_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='polynomial')

print('Linear. . .')
linear_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='linear')

print('Sigmoid. . .')
sigmoid_svm_fit <- svm(as.factor(activity) ~ ., 
                      data=train_data, 
                      method='C-classification', 
                      kernel='radial')


svm_models <- list(radial_svm_fit, polynomial_svm_fit, linear_svm_fit, sigmoid_svm_fit)
svm_names <- c('Radial SVM', 'Polynomial SVM', 'Linear SVM', 'Sigmoid SVM')

# Append the accuracies
svm_accuracies <- sapply(svm_models, cv_accuracy, 
                          test_data=test_data, test_labels=test_labels)
accuracies <- rbind(accuracies,
                    data.frame(Classifier=svm_names, CV=svm_accuracies))