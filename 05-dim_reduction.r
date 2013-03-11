# Try using a reduced versions of the dataset

n_dimensions <- 280 # reduce dimensions 50% 

print("Reducing training data 50%. . .")
reduced_train_data50 <- reduce_dataset(train_data, n_dimensions)
print("Reducing validation data 50%. . .")
reduced_validation_data50 <- reduce_dataset(validation_data, n_dimensions)

print('Training with reduced train data. . .')
svm_svd50_fit <- svm(as.factor(activity) ~ ., 
                        data=reduced_train_data50, 
                        method='C-classification', 
                        kernel='linear')

# Another approximation
n_dimensions <- 140 # reduce dimensions 75%
print("Reducing training data 75%. . .")
reduced_train_data75 <- reduce_dataset(train_data, n_dimensions)
print("Reducing validation data 75%. . .")
reduced_validation_data75 <- reduce_dataset(validation_data, n_dimensions)

print('Training with reduced train data. . .')
svm_svd75_fit <- svm(as.factor(activity) ~ ., 
                        data=reduced_train_data75, 
                        method='C-classification', 
                        kernel='linear')

print('Tuning svm+svd...')
svm_svd50_tuned_fit <- svm_tuned(reduced_train_data50,
                                        reduced_validation_data50, kernel='linear', validation_labels)

svm_svd75_tuned_fit <- svm_tuned(reduced_train_data75,
                                        reduced_validation_data75, kernel='linear', validation_labels)

knn_svd50_predictions <- knn(reduced_train_data50[,-ncol(reduced_train_data50)],
                            reduced_validation_data50[,-ncol(reduced_validation_data50)], 
                            train_labels, k=5)



accuracies <- rbind(accuracies,
                    data.frame(
                        Classifier=c('Linear SVM with 50% dim reduction',
                                        'Linear SVM with 75% dim reduction', 
                                        'Linear SVM with 50% dim reduction (tuned)',
                                        'kNN with 50% dim reduction'
                                    ),
                        CV=c(cv_accuracy(svm_svd50_fit, reduced_validation_data50, validation_labels),
                            cv_accuracy(svm_svd75_fit, reduced_validation_data75, validation_labels),
                            cv_accuracy(svm_svd50_tuned_fit, reduced_validation_data50, validation_labels),
                            mean(knn_svd50_predictions == validation_labels)
                            )
                    )
                )