# Try using a reduced versions of the dataset

n_dimensions <- 281 # reduce dimensions 50% 

print("Reducing training data 50%. . .")
reduced_train_data50 <- reduce_dataset(train_data, n_dimensions)
print("Reducing test data 50%. . .")
reduced_test_data50 <- reduce_dataset(test_data, n_dimensions)

print('Training with reduced train data. . .')
radial_svm_svd50_fit <- svm(as.factor(activity) ~ ., 
                        data=reduced_train_data50, 
                        method='C-classification', 
                        kernel='radial')

accuracies <- rbind(accuracies,
                    data.frame(Classifier='Radial SVM with 50% dim reduction',
                    CV=cv_accuracy(radial_svm_svd50_fit, reduced_test_data50, test_labels))
                )


# Another approximation
n_dimensions <- 140 # reduce dimensions 75%
print("Reducing training data 75%. . .")
reduced_train_data75 <- reduce_dataset(train_data, n_dimensions)
print("Reducing test data 75%. . .")
reduced_test_data75 <- reduce_dataset(test_data, n_dimensions)

print('Training with reduced train data. . .')
radial_svm_svd75_fit <- svm(as.factor(activity) ~ ., 
                        data=reduced_train_data75, 
                        method='C-classification', 
                        kernel='radial')

accuracies <- rbind(accuracies,
                    data.frame(Classifier='Radial SVM with 75% dim reduction',
                    CV=cv_accuracy(radial_svm_svd75_fit, reduced_test_data75, test_labels))
                )

# Order classifiers by accuracy
accuracies <- accuracies[order(-accuracies$CV),]
print(accuracies)
# So far, the radial SVM with dimension reduction has the best accuracy

# Confusion matrix for the radial svm
confusion_matrix <- table(test_labels, predict(radial_svm_svd50_fit, reduced_test_data50))
print('Confusion matrix: ')
print(confusion_matrix)