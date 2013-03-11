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

# Append the accuracies
svm_accuracies <- sapply(svm_models, cv_accuracy, 
                          test_data=validation_data, test_labels=validation_labels)
accuracies <- rbind(accuracies,
                    data.frame(Classifier=svm_names, CV=svm_accuracies))

# Tune the radial svm
print('Tuning svm. . .')
svm_tuned_fit <- svm_tuned(train_data, validation_data, kernel='linear', validation_labels)

accuracies <- rbind(accuracies,
                    data.frame(Classifier=c('Linear SVM tuned'),
                      CV=c(cv_accuracy(svm_tuned_fit, validation_data, validation_labels))))