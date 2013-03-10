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

print('Tuning cost parameter...')
radial_svm_svd75_tuned_fit <- svm_tuned(reduced_train_data75,
                                        reduced_test_data75, test_labels)

accuracies <- rbind(accuracies,
                    data.frame(
                        Classifier=c('Radial SVM with 75% dim reduction', 
                                        'Radial SVM with 75% dim reduction (tuned)'),
                        CV=c(cv_accuracy(radial_svm_svd75_fit, reduced_test_data75, test_labels),
                            cv_accuracy(radial_svm_svd75_tuned_fit, reduced_test_data75, test_labels)
                            )
                    )
                )